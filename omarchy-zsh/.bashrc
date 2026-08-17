# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# Auto-launch zsh shell if in interactive bash
if command -v zsh &> /dev/null; then
  if [[ $(ps --no-header --pid=$PPID --format=comm) != "zsh" && -z ${BASH_EXECUTION_STRING} && ${SHLVL} == 1 ]]
  then
    shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=''
    exec zsh $LOGIN_OPTION
  fi
fi

# Load shared shell configuration (bash fallback when zsh is unavailable)
[[ -f /usr/share/omarchy-zsh/shell/all ]] && source /usr/share/omarchy-zsh/shell/all

# Add your own exports, aliases, and functions below.

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in
    *:/home/u3sound/.juliaup/bin:*)
        ;;

    *)
        export PATH=/home/u3sound/.juliaup/bin${PATH:+:${PATH}}
        ;;
esac
# Tab completion for juliaup and julia channel selection
[ -f "/home/u3sound/.julia/juliaup/completions/bash.sh" ] && source "/home/u3sound/.julia/juliaup/completions/bash.sh"

# <<< juliaup initialize <<<
