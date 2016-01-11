if [[ -n "$TMUX" ]]; then
    function _extract_zdict_pane_id () {
        # check if tmux environment $ZDICT_PANE_VAR exists
        ret=$(tmux show-environment $ZDICT_PANE_VAR 2>/dev/null)
        if [[ $? -eq 0 ]]; then
            # yes it exists, parse it and export to env
            export ZDICT_PANE_ID=$(echo $ret | cut -d '=' -f 2)
        fi
    }

    function _prepare_zdict_pane () {
        _extract_zdict_pane_id
        if [[ -n "$ZDICT_PANE_ID" ]]; then
            # zdict pane was exist
            # now try to select it
            if tmux select-pane -t $ZDICT_PANE_ID 2>/dev/null; then
                # select successed, zdict pane exists
                tmux select-pane -t $TMUX_PANE
                # but does it is in the same window with me?
                if tmux list-panes | grep $ZDICT_PANE_ID 2>&1 1>/dev/null; then
                    # it's in the same window with me, good
                    return
                fi
            fi
        fi

        # no zdict window exists now, make one
        tmux split-window -h "tmux set-environment $ZDICT_PANE_VAR \$TMUX_PANE;\
                tmux wait-for -S $ZDICT_PANE_VAR;\
                zdict"
        tmux select-pane -t $TMUX_PANE
        tmux wait-for $ZDICT_PANE_VAR
        _extract_zdict_pane_id
    }

    function _query_zdict () {
        if [[ -n "$BUFFER" ]]; then
            querying_word=$BUFFER
            BUFFER='Querying...'   # display a message for user experience
            # tmux window index may change, so it cannot be cached
            export ZDICT_PANE_VAR="ZDICT_PANE_$(tmux display-message -p '#I')"
            _prepare_zdict_pane
            tmux send-keys -l -t .${ZDICT_PANE_ID} $querying_word
            tmux send-keys -t .${ZDICT_PANE_ID} Enter
            zle .kill-whole-line
        fi
    }
else
    function _query_zdict () {
        if [[ -n "$BUFFER" ]]; then
            if [[ ${BUFFER:0:6} != "zdict " ]]; then
                BUFFER="zdict $BUFFER"
            fi
            zle .accept-line
        fi
    }
fi

zle -N _query_zdict
bindkey "\C-x" _query_zdict
