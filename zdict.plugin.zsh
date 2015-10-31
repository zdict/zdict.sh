if [[ -n "$TMUX" ]]; then
    function _prepare_zdict_pane () {
        ZDICT_PANE=$(tmux show-environment ZDICT_PANE 2>/dev/null)
        if [[ -n $ZDICT_PANE ]]; then
            # zdict pane was exist
            eval "export $(tmux show-environment ZDICT_PANE 2>/dev/null)"
            # now try to select it
            if $(tmux select-pane -t $ZDICT_PANE 2>/dev/null); then
                # select successed, good
                tmux select-pane -t $TMUX_PANE
                return
            fi
        fi

        # no zdict window exists now, make one
        tmux split-window -h 'tmux set-environment ZDICT_PANE $TMUX_PANE; tmux wait-for -S ZDICT; zdict'
        tmux select-pane -t $TMUX_PANE
        tmux wait-for ZDICT
        eval "export $(tmux show-environment ZDICT_PANE 2>/dev/null)"
        tmux send-keys -t .$ZDICT_PANE C-l
    }

    function _query_zdict () {
        if [[ -n "$BUFFER" ]]; then
            querying_word=$BUFFER
            BUFFER='Querying...'   # display a message for user experience
            _prepare_zdict_pane
            tmux send-keys -l -t .$ZDICT_PANE $querying_word
            tmux send-keys -t .$ZDICT_PANE Enter
            zle .kill-whole-line
        fi
    }
    zle -N _query_zdict

    bindkey "\C-x" _query_zdict
fi
