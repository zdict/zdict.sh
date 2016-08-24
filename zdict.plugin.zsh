if [[ -n "$TMUX" ]]; then
    function _query_zdict () {
        # Current Active Window
        local CAW=$(tmux display-message -p '#I' 2>/dev/null </dev/null)
        local ZDICT_PANE_ID=$(tmux showenv ZDICT_TMUX_PANE_${CAW} 2>/dev/null </dev/null\
                              | cut -d '=' -f 2)
        if [ -n "${ZDICT_PANE_ID}" ]; then
            tmux select-pane -t ${ZDICT_PANE_ID} 2>&1 >/dev/null </dev/null
            if [ $? -eq 0 ]; then
                tmux select-pane -t ${TMUX_PANE} </dev/null
            else
                ZDICT_PANE_ID=''
            fi
        fi

        if [[ -n "${BUFFER}" ]]; then
            local ZDICT_WORD=${BUFFER}
            BUFFER='Querying...'

            if [ -z "${ZDICT_PANE_ID}" ]; then
                local cmd="tmux setenv ZDICT_TMUX_PANE_${CAW} \${TMUX_PANE};\
                        tmux wait-for -S ZDICT_TMUX_PANE_${CAW}; zdict"
                tmux split-window -h ${cmd} </dev/null
                tmux wait-for ZDICT_TMUX_PANE_${CAW} </dev/null
                tmux select-pane -t ${TMUX_PANE} </dev/null
                ZDICT_PANE_ID=$(tmux showenv ZDICT_TMUX_PANE_${CAW} 2>/dev/null </dev/null\
                                  | cut -d '=' -f 2)
            fi
            tmux send-keys -t .${ZDICT_PANE_ID} C-l </dev/null
            tmux send-keys -t .${ZDICT_PANE_ID} -l ${ZDICT_WORD} </dev/null
            tmux send-keys -t .${ZDICT_PANE_ID} Enter </dev/null
            tmux clear-history -t .${ZDICT_PANE_ID} </dev/null
            zle .kill-whole-line
        else
            # buffer is empty, close zdict pane if it exists
            if [ -n "${ZDICT_PANE_ID}" ]; then
                tmux kill-pane -t .${ZDICT_PANE_ID} </dev/null
                ZDICT_PANE_ID=''
            fi
        fi
    }
else
    function _query_zdict () {
        if [[ "${BUFFER}" = "" ]]; then
            BUFFER="zdict "
            CURSOR=$#BUFFER
        elif [[ "${BUFFER:0:6}" != "zdict " ]]; then
            BUFFER="zdict $BUFFER"
            zle .accept-line
        fi
    }
fi

zle -N _query_zdict
bindkey "\C-x" _query_zdict
