#Credit: https://github.com/Area69Lab
#setup.sh VNC_USER_PASSWORD VNC_PASSWORD NGROK_AUTH_TOKEN

#disable spotlight indexing
sudo mdutil -i off -a

#Create new account
sudo dscl . -create /Users/alone
sudo dscl . -create /Users/alone UserShell /bin/zsh
sudo dscl . -create /Users/alone RealName "Alone"
sudo dscl . -create /Users/alone UniqueID 1001
sudo dscl . -create /Users/alone PrimaryGroupID 80
sudo dscl . -create /Users/alone NFSHomeDirectory /Users/alone
sudo dscl . -passwd /Users/alone $1
sudo dscl . -passwd /Users/alone $1
sudo createhomedir -c -u alone > /dev/null

#Git config
#git config --global user.name ""
#git config --global user.email

#switch user
expect -c "spawn su - alone; expect -re \"Password:\"; send \"$1\r\"; set timeout -1; expect -re \"100%\";"

echo "Install OhMyZsh"
curl -L http://install.ohmyz.sh | sh

echo "Setting up Zsh plugins..."
cd ~/.oh-my-zsh/custom/plugins
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git

#exit user
exit

# echo "Use zsh as default shell"
# expect -c "spawn chsh -s /bin/zsh; expect -re \"Password for alone: \"; send \"$1\r\"; set timeout -1; expect -re \"100%\";"

#Enable RM access for everyone
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -allowAccessFor -allUsers -privs -all

#install ngrok
brew install --cask ngrok

#configure ngrok and start it
ngrok authtoken $3
ngrok tcp 22 --region=in &

killall Finder
