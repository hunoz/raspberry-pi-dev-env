***REMOVED***

source ./files/base
source ./files/ipad-network
source ./files/code-server
source ./files/programming-languages

# First, let's run base setup
installOhMyZsh

# Next, let's setup the system for ssh and connection to an iPad
updateBootConfig
setupNetwork

# Next, let's set up code-server
# TODO: This section should install code-server

# Finally, let's install our programming languages
nodejs
python
java
golang
