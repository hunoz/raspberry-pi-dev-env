

installOhMyZsh() {
  [ -d "${USER_HOME}/.oh-my-zsh" ] && rm -rf "${USER_HOME}/.oh-my-zsh"
  sudo -u "$FIRST_USER_NAME" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  chsh -s /usr/bin/zsh "$FIRST_USER_NAME"
}

configureSsh() {
  if [ "$PUBKEY_ONLY_SSH" = "1" ]; then
    echo "Configuring SSH for pubkey-only auth"
    if cat /etc/ssh/sshd_config | grep -q 'ChallengeResponseAuthentication'; then
      sed -i -E 's/^(#?)ChallengeResponseAuthentication.*/ChallengeResponseAuthentication no/g' /etc/ssh/sshd_config
    else
      echo "ChallengeResponseAuthentication no" >> /etc/ssh/sshd_config
    fi

    if cat /etc/ssh/sshd_config | grep -q 'PasswordAuthentication'; then
      sed -i -E 's/^(#?)PasswordAuthentication.*/PasswordAuthentication no/g' /etc/ssh/sshd_config
    else
      echo "PasswordAuthentication no" >> /etc/ssh/sshd_config
    fi

    if cat /etc/ssh/sshd_config | grep -q 'UsePAM'; then
       sed -i -E 's/^(#?)UsePAM.*/UsePAM no/g' /etc/ssh/sshd_config
      echo ""
    else
       echo "UsePAM no" >> /etc/ssh/sshd_config
        echo ""
    fi

    if cat /etc/ssh/sshd_config | grep -q 'PermitRootLogin'; then
      sed -i -E 's/^(#?)PermitRootLogin.*/PermitRootLogin without-password/g' /etc/ssh/sshd_config
    else
      echo "PermitRootLogin without-password" /etc/ssh/sshd_config
    fi
  else
    echo "Configuring SSH to allow password and pubkey auth"
    if cat /etc/ssh/sshd_config | grep -q 'PasswordAuthentication'; then
      sed -i -E 's/^(#?)PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config
    else
      echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
    fi

    if cat /etc/ssh/sshd_config | grep -q 'PermitRootLogin'; then
      sed -i -E 's/^(#?)PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config
    else
      echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
    fi
  fi

  if ! cat /etc/ssh/sshd_config | grep -qE 'Subsystem\s{1,}sftp\s{1,}internal-sftp'; then
    sed -i -E 's|^(#?)Subsystem\s{1}sftp\s{1,}/usr/lib/openssh/sftp-server|Subsystem sftp internal-sftp|g' /etc/ssh/sshd_config
  fi

  ! [ -d "${USER_HOME}/.ssh" ] && mkdir -p "${USER_HOME}/.ssh"
  if ! [ -z "$PUBKEY_SSH_FIRST_USER" ]; then
    ! [ -f "${USER_HOME}/.ssh/authorized_keys" ] && touch "${USER_HOME}/.ssh/authorized_keys"
    if ! cat "${USER_HOME}/.ssh/authorized_keys" | grep -q "$PUBKEY_SSH_FIRST_USER"; then
      echo "$PUBKEY_SSH_FIRST_USER" >> "${USER_HOME}/.ssh/authorized_keys"
    fi
  fi
}
