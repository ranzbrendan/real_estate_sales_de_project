# Setup the Environment on Google Cloud Virtual Machine
## Generate SSH Key
(LINUX)
Open a unix-like terminal and use the ssh-keygen command with -C flag to generate a ssh key pair:
```
~$ mkdir .ssh/
```
```
~$ cd .ssh/
```
For the command below, replace KEY_FILENAME (name of SSH key file) and USER (your username)
```
~/.ssh$ ssh-keygen -t rsa -f ~/.ssh/KEY_FILENAME -C USER -b 2048
```
- Hit enter when propmted for a passphrase to set it to none.  
- You can add one for security reasons but you may have to do additional steps whenever you access the ssh keys.
```
~/.ssh$ ls
```
There will be two files, private and public key. (Never show private key to anyone)
```
~/.ssh$ cat KEY_FILENAME.pub
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
~/.ssh$ cd
```
Don't forget to replace the KEY_FILENAME and USER to the ones you set previously.  
Moreover, paste the external IP into the EXTERNAL_IP
```
~$ ssh -i ~/.ssh/KEY_FILENAME USER@EXTERNAL_IP
```
You will be connected to the virtual machine.  
Check if Google Cloud SDK is installed
```
~$ gcloud --version
```
## Setup ssh config
Open a new unix-like terminal outside of the vm environment.  
```
~$ cd .ssh/
```
```
~/.ssh$ touch config
```
```
~/.ssh$ code config
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
~/.ssh$ cd
```
```
~$ ssh < VM instance name >
```

## Install Anaconda
```
~$ wget https://repo.anaconda.com/archive/Anaconda3-2024.06-1-Linux-x86_64.sh
```
```
~$ bash Anaconda3-2024.06-1-Linux-x86_64.sh
```
Review and accept License.  
Confirm installation location.  
It will take some time to install.  
Enter yes to automatically initialize Anaconda3.  
For changes to take effect, you'll need to reconnect, or just use:
```
~$ source .bashrc
```
There should now be (base) at the start of each command line.
Check if python if installed.  
```
~$ which python
```
```
~$ python
```
```
import pandas
```
```
pandas.__version__
```

## Install Docker

Fetch the list of packages
```
sudo apt-get update
```
Now install docker
```
sudo apt-get install docker.io
```
Configure docker commands to run without sudo
1. Add the docker group if not exists.
```
sudo groupadd docker
```
2. Add the connected user $USER to the docker group
```
sudo gpasswd -a $USER docker
```
3. Reconnect to the vm connection.
*ctrl + D*
```
ssh < VM instance name >
```
4. This should now work:
```
docker run hello-world
```

## Install Docker Compose
Get the latest version from  
`https://github.com/docker/compose/releases`
```
cd
```
```
mkdir bin
```
```
cd bin/
```
This is for version 2.29.7 of docker compose. Don't forget to include the output flag and name
```
wget https://github.com/docker/compose/releases/download/v2.29.7/docker-compose-linux-x86_64 -O docker-compose
```
Make the file executable.
```
~/bin$ chmod +x docker-compose
```
Check
```
~/bin$ ./docker-compose version
```
Add docker compose to the path variable.  
```
~/bin$ cd
```
```
~$ nano .bashrc
```
Scroll to the end of file and add:
```
export PATH="${HOME}/bin:${PATH}"
```
Press *ctrl + O* to save, press enter, then *ctrl + X* to exit.  
Re-read the .bashrc file and apply the new changes. 
```
~$ source .bashrc
```
Check if docker-compose was successfully added to the PATH variable
```
~$ which docker-compose
```

## Clone this repository
```
~$ git clone https://github.com/ranzbrendan/real_estate_sales_de_project.git
```

## Connect to VM using VS code

- Open VS code and install the Remote - SSH extension.  
- At the lower-left corner, click the button to open a remote window.
- Click connect to host.
- Because we have created the config file, the VM host should appear in the options. Click on this.
- Click "Linux" when prompted for the platform of the remote host.
- Click on the Explorer tab and Open Folder `home/your_username/`. Click OK.
- Open a terminal in VS Code. You can now enter the remaining commands here.

## Install Terraform
- Get the download link address for terraform here: `https://developer.hashicorp.com/terraform/install?product_intent=terraform`.
- Choose the AMD64 Binary download for linux.
```
~$ cd bin/
```
```
~/bin$ wget https://releases.hashicorp.com/terraform/1.9.7/terraform_1.9.7_linux_amd64.zip 
```
- Install unzip
```
~/bin$ sudo apt-get install unzip
```
- Unzip the installed terraform zipfile
```
~/bin$ unzip terraform_1.9.7_linux_amd64.zip
```
- Remove the zip file
```
~/bin$ rm terraform_1.9.7_linux_amd64.zip
```
