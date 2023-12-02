# Description
Sloop is a Raspberry Pi image generator that uses [pi-gen](https://github.com/RPi-Distro/pi-gen) to create its images. Each image is set up with the following configuration:
* Pyenv, SDKMan, GVM, and nvm are installed to manage environments for Python, Java, Golang, and Node, respectively.
* `root` user is configured for SSH (User can be changed by specifying -u option)
* [ohmyzsh](https://ohmyz.sh/) installed
* Network configured via USB port for communication with an iPad for OTG development and USB tethering to a smartphone
* Timezone set to UTC (Can be changed by specifying -t option)
* Hostname configured to `sloop` (Can be changed by specifying -h option)
* Default shell set to zsh
* wlan0 configured to connect to certain networks (skipped if no `stage2/04-dev-env-setup/files/wpa_supplicant-wlan0.conf` file is present)
* code-server configured as web IDE, running at http://127.0.0.1:49300 (can be changed by placing a code-server config at `stage2/04-dev-env-setup/files/code-server.config`)
* Syncthing configured to serve code-server workspace (`/workspace`, can be changed by specifying -w option), accessible at http://127.0.0.1:8384

# Usage
This package must be used in a debian environment (preferrably on a Raspberry Pi to ensure build consistency). To understand the available options, run `./build.sh -h` to see the options. Either `-p` (publickey) or `-s` (password) must be specified. By default, password auth over SSH is disabled, specify the `-o` option to allow password auth for SSH.

All files in `stage2/04-dev-env-setup/files` are copied into `/sloop` in the image, so if you have any custom files that you need to reference in a config, such as SSL certificates for code-server, reference them in `/sloop`.

When using this image with an iPad, it will have the IP address `11.100.0.1` and the iPad will obtain an IP within the range of `11.100.0.2` - `11.100.0.6`. These IP addresses were chosen as they are incredibly unlikely to conflict with any other used IP address ranges.

To use this image and connect to an iPhone via USB tethering, just connect it to a USB port and ensure your hotspot is on. `eth1` will automatically pull an IP address via DHCP which will allow you network connectivity.

To use a custom configuration for code-server, you can copy your config file to `stage2/04-dev-env-setup/files/code-server.config` and it will be copied and use instead of the default config.

To configure the wlan0 connection, place a file in `stage2/04-dev-env-setup/files` with the name `wpa_supplicant-wlan0.conf` with a configuration that looks like the below example. As a note, if your SSID comes from an Apple device and contains an apostrophe, you will need to change the SSID in the example below to replace any apostrophes in the SSID with `\xE2\x80\x99`. Example is in the section below.
```
network={
  scan_ssid=1 # This tells it to scan for the network as it is not broadcast
  ssid="<SSID_HERE>" # Make sure that the SSID is in quotes unless you followed the aforementioned instructions due to there being illegal characters in your SSID
  psk="<PASSWORD_HERE" # The password to the network
  key_mgmt=WPA-PSK # Change to your needs
  priority=0 # Lower number means higher priority. You can specify the network block for each network you want, so use priority to prioritize their connectivity order
}

# iPhone network
network={
  scan_ssid=1
  ssid="hunoz\xE2\x80\x99s iPhone" # hunoz's iPhone
  psk="password"
  key_mgmt=WPA-PSK
  priority=1
}
```

To build the image, run `./build.sh -c <CONFIG_PATH>` with the required arguments if you specified a config path. If you did not specify a config path, run `./build.sh` with the required arguments. Once it is complete, it will output a file in `deploy/` with a name similar to `image_$(date +"%Y-%m-%d")-sloop-lite.zip` which can be extracted to obtain the `.img` file which can then be flashed on an SD card using something like [Raspberry Pi Imager](https://www.raspberrypi.com/software/)

# Roadmap
* Have syncthing start as a service on boot (implemented, needs testing)
