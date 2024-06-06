
if status is-interactive
    # Commands to run in interactive sessions can go here
    abbr --add k kubectl # https://fishshell.com/docs/current/cmds/abbr.html
    abbr --add gst "git status"
    abbr --add vim nvim
    abbr --add bathelp "bat -pl help"

    # Starship
    starship init fish | source

    ## Brew
    if test -d /home/linuxbrew/.linuxbrew # Linux
        set -gx HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew"
        set -gx HOMEBREW_CELLAR "$HOMEBREW_PREFIX/Cellar"
        set -gx HOMEBREW_REPOSITORY "$HOMEBREW_PREFIX/Homebrew"
    else if test -d /opt/homebrew # MacOS
        set -gx HOMEBREW_PREFIX "/opt/homebrew"
        set -gx HOMEBREW_CELLAR "$HOMEBREW_PREFIX/Cellar"
        set -gx HOMEBREW_REPOSITORY "$HOMEBREW_PREFIX/homebrew"
    end
    fish_add_path -gP "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin";
    ! set -q MANPATH; and set MANPATH ''; set -gx MANPATH "$HOMEBREW_PREFIX/share/man" $MANPATH;
    ! set -q INFOPATH; and set INFOPATH ''; set -gx INFOPATH "$HOMEBREW_PREFIX/share/info" $INFOPATH;
    # Brew command-not-found
    set HB_CNF_HANDLER (brew --repository)"/Library/Taps/homebrew/homebrew-command-not-found/handler.fish"
    if test -f $HB_CNF_HANDLER
        source $HB_CNF_HANDLER
    end 

    if  command -v atuin &>/dev/null
        set -gx ATUIN_NOBIND "true"
        atuin init fish | source

        # bind to ctrl-r in normal and insert mode, add any other bindings you want here too
        bind \cr _atuin_search
        bind -M insert \cr _atuin_search

        bind --preset -k up _atuin_bind_up
        bind --preset \e\[A _atuin_bind_up
        bind \e\[A _atuin_bind_up
    end

    if  command -v kubecolor &>/dev/null
        alias kubectl=kubecolor # https://fishshell.com/docs/current/cmds/alias.html

        # make kubecolor inherit completions from kubectl # https://fishshell.com/docs/current/cmds/complete.html
        complete -c kubecolor -w kubectl
    end

    if  command -v mise &>/dev/null
        mise activate fish | source
    end
end
