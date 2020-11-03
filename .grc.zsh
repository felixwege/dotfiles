# Based on https://github.com/unixorn/warhol.plugin.zsh/blob/master/warhol.plugin.zsh
if (( $+commands[grc] )); then
  GRC=$(which -p grc)
    if [ "$TERM" != dumb ] && [ -n "$GRC" ]; then
        function diff(){
            \grc --colour=auto /usr/bin/diff "$@"
        }

        function head(){
            \grc --colour=auto /usr/bin/head "$@"
        }

        function tail(){
            \grc --colour=auto /usr/bin/tail "$@"
        }

        function env(){
            \grc --colour=auto /usr/bin/env "$@"
        }

        function ps(){
            \grc --colour=auto /bin/ps "$@"
        }

        function ping(){
            \grc --colour=auto /sbin/ping "$@"
        }
    fi
fi
