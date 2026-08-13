echo "Hi $USERNAME!\nThis is XPS14(Omarchy 3.6.0)."
echo
echo
echo "########## TODO ##########"
echo
cat ~/todo.txt

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load zsh options, keybindings, and completion
[[ -f /usr/share/omarchy-zsh/shell/zoptions ]] && source /usr/share/omarchy-zsh/shell/zoptions

# Load shared shell configuration (aliases, functions, environment, tool init)
[[ -f /usr/share/omarchy-zsh/shell/all ]] && source /usr/share/omarchy-zsh/shell/all

# Autosuggestion
[[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && \
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# fzf-tab
[[ -f /usr/share/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh ]] && \
  source /usr/share/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh

# History substring search
[[ -f /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ]] && \
  source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# Load the full zsh-autocomplete configuration so its asynchronous listing
# keeps the original directory/file sections.
if [[ -r /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
fi

# Let TAB open fzf-tab after zsh-autocomplete has shown its live candidates.
# fzf-tab replaces compadd while it runs, so restore its capture function just
# before invoking the widget (the compatibility pattern from the referenced
# fzf-tab setup).
my-fzf-tab() {
  functions[compadd]=$functions[-ftb-compadd]
  zle fzf-tab-complete
}
zle -N my-fzf-tab

# zsh-autocomplete installs its display styles at the first prompt, including
# `menu no no-select`.  Run after that initialization to retain the display
# styles while restoring the normal interactive TAB menu.
_restore_tab_menu_after_autocomplete() {
  zstyle -d ':completion:*:*:*:*:default' menu
  zstyle ':completion:*' menu select
  bindkey '^I' menu-select
  bindkey '^[[Z' my-fzf-tab
  bindkey -M menuselect '^I' menu-complete
  bindkey -M menuselect '^[[Z' reverse-menu-complete
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd _restore_tab_menu_after_autocomplete

# Apply these after all shared startup files: fzf's startup script otherwise
# rebinds TAB.  TAB keeps the normal highlighted menu; Shift+TAB opens
# fzf-tab's interactive candidate picker.
bindkey '^I' menu-select
bindkey '^[[Z' my-fzf-tab
bindkey -M menuselect '^I' menu-complete
bindkey -M menuselect '^[[Z' my-fzf-tab

# Compact completion list
zstyle ':completion:*' verbose false
zstyle ':completion:*' list-packed true

# Completion colors
if [[ -n "$LS_COLORS" ]]; then
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} 'ma=7'
else
  zstyle ':completion:*:default' list-colors 'ma=7'
fi


# ---- zsh-syntax-highlighting ----
typeset -A ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)

# Use RGB colors directly instead of terminal theme palette names.
# This avoids Omarchy theme palette conflicts.
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#ff5555,bold'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=#ff5555,bold'

ZSH_HIGHLIGHT_STYLES[command]='fg=#50fa7b'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=#50fa7b'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#50fa7b'
ZSH_HIGHLIGHT_STYLES[function]='fg=#50fa7b'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#50fa7b'

[[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Add your own customizations below
#
# Make an alias for invoking commands you use constantly
# alias p='python'
# alias cx="claude --permission-mode=plan --allow-dangerously-skip-permissions"
alias ls="eza --icons=always --time-style '+<%Y-%m-%d %H:%M:%S>'"
alias la="ls -a"
alias lsa="la -a"
alias lsla="la -la"
alias lsort="ls -l -r --total-size  -s size"
alias tree="eza --icons=always -T -L"
alias xuu="sudo sync ; sudo shutdown -h now"
alias grep="grep --color=auto"
alias dnsrestart="sudo systemctl restart systemd-resolved"
alias lock="omarchy-lock-screen"
alias screensaver="omarchy-launch-screensaver"
alias wake-main-desktop="ssh debian-server-on-tailscale /usr/local/bin/wake-main-desktop"
alias win-restart='sudo grub-reboot "Windows Boot Manager (on /dev/nvme0n1p1)" ; sudo reboot'

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/home/u3sound/.juliaup/bin' $path)
export PATH
# Tab completion for juliaup and julia channel selection
[ -f "/home/u3sound/.julia/juliaup/completions/zsh.zsh" ] && source "/home/u3sound/.julia/juliaup/completions/zsh.zsh"

# <<< juliaup initialize <<<

# Generic Colouriser
[[ -s "/etc/grc.zsh" ]] && source /etc/grc.zsh

# brew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"

# jmp
alias jmp="source jmp"

# CUDA
export CUDA_HOME=/usr/local/cuda
export PATH="$CUDA_HOME/bin:$PATH"
export LD_LIBRARY_PATH="$CUDA_HOME/lib64:${LD_LIBRARY_PATH:-}"
