# Set up zoxide alias
eval "$(zoxide init zsh)"

alias cp="cp -i"                                                # Confirm before overwriting something
alias free='free -m'                                            # Show sizes in MB

alias g=git
alias hx=helix
alias ls=eza
alias cat='bat --theme ansi'
alias notes='cd "$HOME/Documents/notes"; echo "\x1b]2;Notes\x1b\\"; hx .'
alias w='cd $(git rev-parse --show-toplevel || jj root)'
alias hw='hx $(git rev-parse --show-toplevel || jj root) --working-dir .'
alias cw='code $(git rev-parse --show-toplevel)'
