set -g fish_greeting

if status is-interactive
    starship init fish | source
    zoxide init fish | source
    function reverse_history_search
        history | fzf --no-sort | read -l command
        if test -n "$command"
            commandline -rb "$command"
        end
    end

    function fish_user_key_bindings
        fish_vi_key_bindings
        bind -M default / reverse_history_search
    end
end

alias l='eza -lh  --icons=auto' # long list
alias ls='eza -1   --icons=auto' # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto' # long list dirs
alias lt='eza --icons=auto --tree' # list folder as tree
