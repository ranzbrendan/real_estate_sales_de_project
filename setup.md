# Setup the Environment on Google Cloud Virtual Machine
## Generate SSH Key
(LINUX)
Open a unix-like terminal and use the ssh-keygen command with -C flag to generate a ssh key pair:
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
- Hit enter when propmted for a passphrase to set it to none.  
- You can add one for security reasons but you may have to do additional steps whenever you access the ssh keys.
```
ls
```
There will be two files, private and public key. (Never show private key to anyone)
```
cat KEY_FILENAME.pub
```
- Copy the content of the public ssh key into the clipboard.

- Open the browser, enter console.cloud.google.com in the URL
- Create an account and get the free trial  
- Navigate to: Navigation Menu -> Compute - Engine -> Metadata  
- Go to the SSH KEYS tab and click on the "ADD SSH KEY" button.  
- Paste the public ssh key content into the SSH key field and click Save.

## Create VM Instance
- Back in the browser, navigate to: Navigation Menu -> Compute Engine -> VM instances.  
- Click "CREATE INSTANCE".  
- Set the configurations:
  - Name: &lt; instance name &gt;
  - Region: &lt; select the nearest region &gt;
  - Zone: &lt; choose any zone &gt;
  - Series: E2
  - Machine Type: &lt; choose any &gt; *I chose e2-standard-4 (4 vCPU, 16 GB memory)*
  - Boot Disk:
      - Operating System: Ubuntu
      - Version: Ubuntu 20.04 LTS
      - Boot Disk Type: Balanced Persistent Disk
      - Size: 30 GB
- Click "CREATE"
- It will take some time for the vm instance to load.

## SSH into the VM
After the vm instance has loaded, copy the External IP.  
You can connect to the vm by going back to the terminal and entering these lines of code:
```
cd
```
Don't forget to replace the KEY_FILENAME and USER to the ones you set previously.  
Moreover, paste the external IP into the EXTERNAL_IP
```
ssh -i ~/.ssh/KEY_FILENAME USER@EXTERNAL_IP
```
You will be connected to the virtual machine.  
Check if Google Cloud SDK is installed
```
gcloud --version
```
## Setup ssh config
Open a new unix-like terminal outside of the vm environment.  
```
cd .ssh/
```
```
touch config
```
```
code config
```
This will open the config file in VS code.
Enter this into the file and replace the values.  
Example of identity file path: *c:/Users/USER/.ssh/KEY_FILENAME*
```
Host < VM instance name >
    Hostname < External IP >
    User < USER >
    IdentityFile < path/to/your/private/ssh/key >
```
You can now connect to the vm environment with:
```
cd
```
```
ssh < VM instance name >
```

## Install Anaconda
```
wget https://repo.anaconda.com/archive/Anaconda3-2024.06-1-Linux-x86_64.sh
```
```
bash Anaconda3-2024.06-1-Linux-x86_64.sh
```
Review and accept License.  
Confirm installation location.  
It will take some time to install.  
Enter yes to automatically initialize Anaconda3.  
For changes to take effect, you'll need to reconnect, or just use:
```
source .bashrc
```
There should now be (base) at the start of each command line.
Check if python if installed.  
```
which python
```
```
python
```
```
import pandas
```
```
pandas.__version__
```
