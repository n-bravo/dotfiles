PS1='[%~] '

# Configure PATH
export PATH="$HOME/Library/Python/3.8/bin:$PATH"
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"
# export PATH="/opt/homebrew/anaconda3/bin:$PATH"  # commented out by conda initialize
export PATH="/opt/homebrew/opt/qt@5/bin:$PATH"
export PATH="$HOME/instantclient_19_8:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="/opt/homebrew/Cellar/lua-language-server/3.13.4/bin:$PATH"

export ORACLE_HOME=$HOME/instantclient_19_8
export DYLD_LIBRARY_PATH=$HOME/instantclient_19_8
export OCI_LIB_DIR=$HOME/instantclient_19_8
export OCI_INC_DIR=$HOME/instantclient_19_8

export LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@3/include"

autoload -Uz compinit
compinit

# init conda based on arch
source ~/.custrc/.condarc
if [[ $(uname -m) == 'x86_64' ]]; then
    init_conda_intel
    echo "conda x86_64 is activated"
else
    init_conda_m1
    echo "conda m1 is activated"
fi


# Aliases
alias genpass="openssl rand -base64"
alias nvconf="cd ~/.config/nvim && nvim ."
alias vim="nvim"
alias vi="nvim"

# NVM Config
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
