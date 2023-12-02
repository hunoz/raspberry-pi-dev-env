createCodeServerConfigFile() {
  if ! [ -f /sloop/code-server.config ]; then
    cat > /sloop/code-server.config << EOF
bind-addr: 127.0.0.1:49300
auth: none
cert: false
disable-telemetry: true
ignore-last-opened: true
EOF
  fi
}

setupCodeServerAsDaemon() {
echo -n "\
[Unit]
Description=Code Server
After=network.target
StartLimitBurst=5
StartLimitIntervalSec=10

[Service]
Type=simple
Restart=on-failure
RestartSec=1
User="$FIRST_USER_NAME"
Environment="PATH=${USER_HOME}/.nvm/versions/node/v18.19.0/bin"
ExecStart=/bin/sh -c \"code-server --config /sloop/code-server.config '$(readlink -f $CODE_SERVER_WORKSPACE)'\"

[Install]
WantedBy=multi-user.target
" > /usr/lib/systemd/system/code-server.service
  systemctl daemon-reload
  systemctl enable code-server
}

installCodeServer() {
  sudo -u "$FIRST_USER_NAME" /bin/zsh -c "source \"$USER_HOME\"/.zshrc; nvm install 18.19.0; curl -fsSL https://code-server.dev/install.sh | bash"
  echo "PATH=\"\$(npm bin -g):\$PATH\"" >> "${USER_HOME}/.zshrc"
  mkdir -p "$CODE_SERVER_WORKSPACE"
  SUDO_USER=root chown "$FIRST_USER_NAME" "$CODE_SERVER_WORKSPACE"

  createCodeServerConfigFile
  setupCodeServerAsDaemon
}
