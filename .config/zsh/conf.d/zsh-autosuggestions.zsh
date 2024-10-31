#
# zsh-autosuggestions: Configuration for zsh-users/zsh-autosuggestions
#
# https://github.com/zsh-users/zsh-autosuggestions/

# Check if using zsh-users/zsh-autosuggestions
[[ -v ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE ]] || return 1

# Show history first, then fallback to completion
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
