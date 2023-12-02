nodejs() {
  # Install NVM to manage Node versions
  sudo -u "$FIRST_USER_NAME" sh -c "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash"
  if ! cat "${USER_HOME}/.zshrc" | grep -q 'NVM_DIR'; then
    echo 'export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion' >> "${USER_HOME}/.zshrc"
  fi
  sudo -u "$FIRST_USER_NAME" zsh -c "source \"${USER_HOME}/.zshrc\"; nvm install --lts"
}

python() {
  # Install pyenv to manage Python versions
  [ -d "${USER_HOME}/.pyenv" ] && rm -rf "${USER_HOME}/.pyenv"
  sudo -u "$FIRST_USER_NAME" zsh -c "curl https://pyenv.run | bash"

  # Update .bashrc for pyenv
  if ! cat "${USER_HOME}/.zshrc" | grep -q 'PYENV_ROOT'; then
    echo 'export PYENV_ROOT="$HOME/.pyenv"
    [ -d $PYENV_ROOT/bin ] && export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"' >> "${USER_HOME}/.zshrc"
  fi

  if ! cat "${USER_HOME}/.zshrc" | grep -q 'eval "$(pyenv virtualenv-init -)"'; then
    echo 'eval "$(pyenv virtualenv-init -)"' >> "${USER_HOME}/.zshrc"
  fi
}

java() {
  # Install SDKMan to manage JDK versions
  sudo -u "$FIRST_USER_NAME" zsh -c "curl -s \"https://get.sdkman.io\" | bash || true"
}

golang() {
  # Install GVM to manage Golang versions
  [ -d "${USER_HOME}/.gvm" ] && rm -rf "${USER_HOME}/.gvm"
  sudo -u "$FIRST_USER_NAME" bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)

  if ! cat "${USER_HOME}/.zshrc" | grep -q 'source \$HOME/.gvm/scripts/gvm'; then
    echo "source \$HOME/.gvm/scripts/gvm" >> "${USER_HOME}/.zshrc"
  fi
}
