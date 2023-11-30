
***REMOVED***

source /root/base
source /root/ipad-network
source /root/code-server
source /root/programming-languages

# First, let's run base setup
echo "************* Configuring SSH *************"
configureSsh
echo "************* Finished configuring SSH *************"
echo ""
echo "************* Installing OhMyZsh *************"
installOhMyZsh
echo "************* Finished installing OhMyZsh *************"
echo ""
# Next, let's setup the system for ssh and connection to an iPad
echo "************* Configuring network settings for iPad *************"
updateBootConfig
setupNetwork
echo "************* Completed network configuration for iPad *************"
echo ""

# Next, let's set up code-server
echo "************* Installing NodeJS *************"
nodejs
echo "************* Completed NodeJS installation *************"
echo ""
echo "************* Installing Code Server *************"
installCodeServer
echo "************* Completed Code Server Installation *************"
echo ""
# TODO: Set up code-server as a service which starts on boot

# Finally, let's install our remaining programming languages
echo "************* Installing Python *************"
python
echo "************* Completed Python Installation *************"
echo ""
echo "************* Installing Java *************"
java
echo "************* Completed Java Installation *************"
echo ""
echo "************* Installing Golang *************"
golang
echo "************* Completed Golang Installation *************"
echo ""
