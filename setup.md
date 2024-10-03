# Setup the Environment on Google Cloud Virtual Machine
## Generate SSH Key
(LINUX)
Open a terminal and use the ssh-keygen command with -C flag to generate a ssh key pair:
```
mkdir .ssh/
```
```
cd .ssh/
```
For the command below, replace KEY_FILENAME (name of SSH key file) and USER (your username)
```
ssh-keygen -t rsa -f ~/.ssh/KEY_FILENAME -C USER -b 2048
```
Hit enter when propmted for a passphrase to set it to none. You can add one for security reasons but you may have to do additional steps whenever you access the ssh keys.
```
ls
```
There will be two files, private and public key. (Never show private key to anyone)
```
cat KEY_FILENAME.pub
```
Copy the content of the public ssh key into the clipboard.

Open the browser, enter console.cloud.google.com and navigate to: Navigation Menu -> Compute Engine -> Metadata
Go to the SSH KEYS tab and click on the "ADD SSH KEY" button.
Paste the public ssh key content into the SSH key field and click Save.

