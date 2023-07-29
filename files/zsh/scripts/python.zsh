# Python
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export PATH="~/.local/bin:$PATH"
fpath+=~/.config/zsh/.zfunc

alias poetry_activate="source \"\$(poetry env list --full-path | grep Activated | cut -d' ' -f1 )/bin/activate\""


