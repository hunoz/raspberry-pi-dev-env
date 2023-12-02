createSyncthingConfigFile() {
  echo -n "\
<configuration version=\"37\">
    <folder id=\"rwskx-aerm6\" label=\"Workspace\" path=\"$CODE_SERVER_WORKSPACE\" type=\"sendreceive\" rescanIntervalS=\"3600\" fsWatcherEnabled=\"true\" fsWatcherDelayS=\"10\" ignorePerms=\"false\" autoNormalize=\"true\">
        <filesystemType>basic</filesystemType>
        <device id=\"U2WM3TH-R5YKKS7-XERD33A-VODZPH3-FLA7YEQ-G7VETZ4-XZY3IXH-XRTBQAA\" introducedBy=\"\">
            <encryptionPassword></encryptionPassword>
        </device>
        <minDiskFree unit=\"%\">1</minDiskFree>
        <versioning>
            <cleanupIntervalS>3600</cleanupIntervalS>
            <fsPath></fsPath>
            <fsType>basic</fsType>
        </versioning>
        <copiers>0</copiers>
        <pullerMaxPendingKiB>0</pullerMaxPendingKiB>
        <hashers>0</hashers>
        <order>random</order>
        <ignoreDelete>false</ignoreDelete>
        <scanProgressIntervalS>0</scanProgressIntervalS>
        <pullerPauseS>0</pullerPauseS>
        <maxConflicts>10</maxConflicts>
        <disableSparseFiles>false</disableSparseFiles>
        <disableTempIndexes>false</disableTempIndexes>
        <paused>false</paused>
        <weakHashThresholdPct>25</weakHashThresholdPct>
        <markerName>.stfolder</markerName>
        <copyOwnershipFromParent>false</copyOwnershipFromParent>
        <modTimeWindowS>0</modTimeWindowS>
        <maxConcurrentWrites>2</maxConcurrentWrites>
        <disableFsync>false</disableFsync>
        <blockPullOrder>standard</blockPullOrder>
        <copyRangeMethod>standard</copyRangeMethod>
        <caseSensitiveFS>false</caseSensitiveFS>
        <junctionsAsDirs>false</junctionsAsDirs>
        <syncOwnership>false</syncOwnership>
        <sendOwnership>false</sendOwnership>
        <syncXattrs>false</syncXattrs>
        <sendXattrs>false</sendXattrs>
        <xattrFilter>
            <maxSingleEntrySize>1024</maxSingleEntrySize>
            <maxTotalSize>4096</maxTotalSize>
        </xattrFilter>
    </folder>
    <device id=\"U2WM3TH-R5YKKS7-XERD33A-VODZPH3-FLA7YEQ-G7VETZ4-XZY3IXH-XRTBQAA\" name=\"$TARGET_HOSTNAME\" compression=\"metadata\" introducer=\"false\" skipIntroductionRemovals=\"false\" introducedBy=\"\">
        <address>dynamic</address>
        <paused>false</paused>
        <autoAcceptFolders>false</autoAcceptFolders>
        <maxSendKbps>0</maxSendKbps>
        <maxRecvKbps>0</maxRecvKbps>
        <maxRequestKiB>0</maxRequestKiB>
        <untrusted>false</untrusted>
        <remoteGUIPort>0</remoteGUIPort>
        <numConnections>0</numConnections>
    </device>
    <gui enabled=\"true\" tls=\"false\" debugging=\"false\" sendBasicAuthPrompt=\"false\">
        <address>127.0.0.1:8384</address>
        <theme>default</theme>
    </gui>
    <ldap></ldap>
    <options>
        <listenAddress>default</listenAddress>
        <globalAnnounceServer>default</globalAnnounceServer>
        <globalAnnounceEnabled>true</globalAnnounceEnabled>
        <localAnnounceEnabled>true</localAnnounceEnabled>
        <localAnnouncePort>21027</localAnnouncePort>
        <localAnnounceMCAddr>[ff12::8384]:21027</localAnnounceMCAddr>
        <maxSendKbps>0</maxSendKbps>
        <maxRecvKbps>0</maxRecvKbps>
        <reconnectionIntervalS>60</reconnectionIntervalS>
        <relaysEnabled>true</relaysEnabled>
        <relayReconnectIntervalM>10</relayReconnectIntervalM>
        <startBrowser>true</startBrowser>
        <natEnabled>true</natEnabled>
        <natLeaseMinutes>60</natLeaseMinutes>
        <natRenewalMinutes>30</natRenewalMinutes>
        <natTimeoutSeconds>10</natTimeoutSeconds>
        <urAccepted>-1</urAccepted>
        <urSeen>3</urSeen>
        <urUniqueID></urUniqueID>
        <urURL>https://data.syncthing.net/newdata</urURL>
        <urPostInsecurely>false</urPostInsecurely>
        <urInitialDelayS>1800</urInitialDelayS>
        <autoUpgradeIntervalH>12</autoUpgradeIntervalH>
        <upgradeToPreReleases>false</upgradeToPreReleases>
        <keepTemporariesH>24</keepTemporariesH>
        <cacheIgnoredFiles>false</cacheIgnoredFiles>
        <progressUpdateIntervalS>5</progressUpdateIntervalS>
        <limitBandwidthInLan>false</limitBandwidthInLan>
        <minHomeDiskFree unit=\"%\">1</minHomeDiskFree>
        <releasesURL>https://upgrades.syncthing.net/meta.json</releasesURL>
        <overwriteRemoteDeviceNamesOnConnect>false</overwriteRemoteDeviceNamesOnConnect>
        <tempIndexMinBlocks>10</tempIndexMinBlocks>
        <unackedNotificationID>authenticationUserAndPassword</unackedNotificationID>
        <trafficClass>0</trafficClass>
        <setLowPriority>true</setLowPriority>
        <maxFolderConcurrency>0</maxFolderConcurrency>
        <crashReportingURL>https://crash.syncthing.net/newcrash</crashReportingURL>
        <crashReportingEnabled>true</crashReportingEnabled>
        <stunKeepaliveStartS>180</stunKeepaliveStartS>
        <stunKeepaliveMinS>20</stunKeepaliveMinS>
        <stunServer>default</stunServer>
        <databaseTuning>auto</databaseTuning>
        <maxConcurrentIncomingRequestKiB>0</maxConcurrentIncomingRequestKiB>
        <announceLANAddresses>true</announceLANAddresses>
        <sendFullIndexOnUpgrade>false</sendFullIndexOnUpgrade>
        <connectionLimitEnough>0</connectionLimitEnough>
        <connectionLimitMax>0</connectionLimitMax>
        <insecureAllowOldTLSVersions>false</insecureAllowOldTLSVersions>
        <connectionPriorityTcpLan>10</connectionPriorityTcpLan>
        <connectionPriorityQuicLan>20</connectionPriorityQuicLan>
        <connectionPriorityTcpWan>30</connectionPriorityTcpWan>
        <connectionPriorityQuicWan>40</connectionPriorityQuicWan>
        <connectionPriorityRelay>50</connectionPriorityRelay>
        <connectionPriorityUpgradeThreshold>0</connectionPriorityUpgradeThreshold>
    </options>
    <defaults>
        <folder id=\"\" label=\"\" path=\"~\" type=\"sendreceive\" rescanIntervalS=\"3600\" fsWatcherEnabled=\"true\" fsWatcherDelayS=\"10\" ignorePerms=\"false\" autoNormalize=\"true\">
            <filesystemType>basic</filesystemType>
            <device id=\"U2WM3TH-R5YKKS7-XERD33A-VODZPH3-FLA7YEQ-G7VETZ4-XZY3IXH-XRTBQAA\" introducedBy=\"\">
                <encryptionPassword></encryptionPassword>
            </device>
            <minDiskFree unit=\"%\">1</minDiskFree>
            <versioning>
                <cleanupIntervalS>3600</cleanupIntervalS>
                <fsPath></fsPath>
                <fsType>basic</fsType>
            </versioning>
            <copiers>0</copiers>
            <pullerMaxPendingKiB>0</pullerMaxPendingKiB>
            <hashers>0</hashers>
            <order>random</order>
            <ignoreDelete>false</ignoreDelete>
            <scanProgressIntervalS>0</scanProgressIntervalS>
            <pullerPauseS>0</pullerPauseS>
            <maxConflicts>10</maxConflicts>
            <disableSparseFiles>false</disableSparseFiles>
            <disableTempIndexes>false</disableTempIndexes>
            <paused>false</paused>
            <weakHashThresholdPct>25</weakHashThresholdPct>
            <markerName>.stfolder</markerName>
            <copyOwnershipFromParent>false</copyOwnershipFromParent>
            <modTimeWindowS>0</modTimeWindowS>
            <maxConcurrentWrites>2</maxConcurrentWrites>
            <disableFsync>false</disableFsync>
            <blockPullOrder>standard</blockPullOrder>
            <copyRangeMethod>standard</copyRangeMethod>
            <caseSensitiveFS>false</caseSensitiveFS>
            <junctionsAsDirs>false</junctionsAsDirs>
            <syncOwnership>false</syncOwnership>
            <sendOwnership>false</sendOwnership>
            <syncXattrs>false</syncXattrs>
            <sendXattrs>false</sendXattrs>
            <xattrFilter>
                <maxSingleEntrySize>1024</maxSingleEntrySize>
                <maxTotalSize>4096</maxTotalSize>
            </xattrFilter>
        </folder>
        <device id=\"\" compression=\"metadata\" introducer=\"false\" skipIntroductionRemovals=\"false\" introducedBy=\"\">
            <address>dynamic</address>
            <paused>false</paused>
            <autoAcceptFolders>false</autoAcceptFolders>
            <maxSendKbps>0</maxSendKbps>
            <maxRecvKbps>0</maxRecvKbps>
            <maxRequestKiB>0</maxRequestKiB>
            <untrusted>false</untrusted>
            <remoteGUIPort>0</remoteGUIPort>
            <numConnections>0</numConnections>
        </device>
        <ignores></ignores>
    </defaults>
</configuration>
" > /sloop/syncthing/config.xml
}
setupSyncthingAsDaemon() {
  echo -n "\
[Unit]
Description=Syncthing - Open Source Continuous File Synchronization for %I
Documentation=man:syncthing(1)
After=network.target
StartLimitIntervalSec=60
StartLimitBurst=4

[Service]
Type=simple
Restart=on-failure
RestartSec=1
SuccessExitStatus=3 4
RestartForceExitStatus=3 4
ProtectSystem=full
PrivateTmp=true
SystemCallArchitectures=native
MemoryDenyWriteExecute=true
NoNewPrivileges=true
User="$FIRST_USER_NAME"
ExecStart=/usr/bin/syncthing serve --no-browser --no-restart --no-default-folder --config /sloop/syncthing --data /sloop/syncthing --logflags=0

[Install]
WantedBy=multi-user.target
" > /usr/lib/systemd/system/syncthing.service 
  systemctl daemon-reload
  systemctl enable syncthing
}

installSyncthing() {
  sudo mkdir -p /etc/apt/keyrings
  sudo curl -L -o /etc/apt/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg

  echo "deb [signed-by=/etc/apt/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
  printf "Package: *\nPin: origin apt.syncthing.net\nPin-Priority: 990\n" | sudo tee /etc/apt/preferences.d/syncthing.pref

  sudo apt-get update
  sudo apt-get install syncthing -y

  mkdir -p /sloop/syncthing
  createSyncthingConfigFile
  setupSyncthingAsDaemon
}
