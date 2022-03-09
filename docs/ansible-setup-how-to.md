# Fortinet IaC in ASH / ARM Using Ansible

WIP (2020-12-03)

----

## Prerequisites On Your Local Workstation

You'll need to configure your local Windows 10 workstation to run Ansible under the Linux Subsystem for Windows.  

This is because Ansible isn't supported natively on Windows.

- Install the Linux Subsystem for Windows 10
  - <https://docs.microsoft.com/en-us/windows/wsl/install-win10>
    - This will install WSL 1 by default
- Upgrade your WSL installation from WSL1 to WSL 2 (if you don't do this, Ansible will refuse to work!)
  - You can find instructions here: <https://ubuntu.com/blog/ubuntu-on-wsl-2-is-generally-available>
    - And for more information on WSL 2:
      - <https://docs.microsoft.com/en-gb/windows/wsl/wsl2-kernel>
- Install the latest release of Ubuntu (20.04 LTS) from the Microsoft Store
  - <https://www.microsoft.com/store/apps/9n6svws3rx71>
    - NOTE: Your UNIX username & password don't have to match your Windows credentials - but, if they do, it makes them easier to remember!

### Convert Your Ubuntu App From WSL 1 to WSL 2

Open an **elevated PowerShell session** on your Windows workstation to run the commands below.

- Check if your Ubuntu app is currently running under WSL 2

```powershell
wsl -l -v
```

- If it's listed as running "VERSION 1", run the following command to convert it to "VERSION 2"

```powershell
wsl --set-version <name_of_your_Ubuntu_app> 2

# Here's an example.

wsl --set-version Ubuntu-20.04 2
```

### Install Ansible In Your Ubuntu App

Launch the Ubuntu app you downloaded and installed from the Microsoft store, then run the commands below from the Linux CLI.

- First, install any available updates for Ubuntu
  - Run the two commands below one at a time:

```bash
sudo apt-get update
sudo apt-get upgrade -y

# Alternatively, you can run both commands together using a one-liner as per below.

sudo apt-get update && sudo apt-get upgrade -y
```

- Next, install the prerequisites for Ansible
  - NOTE: Python - Ubuntu 20.04 LTS ships with Python3 so an explicit installation of Python is **not** required
    - To confirm That Python3 is already installed, you can run this command:
      - `python3 --version`
    - Install the Pip module for Python3
  
```bash
sudo apt-get -y install python3-pip python-dev libffi-dev libssl-dev

# NOTE: You can confirm your pip3 installation by running the command below.

pip3 --version
```

- Next, install Ansible itself in your user's context
  - NOTE: This is done to avoid permission issues with Pip that are specific to WSL
  
```bash
pip3 install ansible --user
```

- Finally,  update $PATH to include ~/.local/bin (this is the directory where the Ansible executable lives)

```bash
echo 'PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc

source .bashrc
```

----

## Install the FortiGate Modules in Your Ubuntu App

- Install the fortiosAPI module - see <https://pypi.org/project/fortiosapi/>
  - `pip3 install fortiosapi`
- Install the FortiOS Ansible Collection - see <https://github.com/fortinet-ansible-dev/ansible-galaxy-fortios-collection>
  - `ansible-galaxy collection install fortinet.fortios`

----

## Test That Ansible Has Installed Successfully

You can use a very basic playbook to test that Ansible has installed successfully in your Ubuntu app.

Create a new file, `test-ansible.yaml`, in a folder **on your Windows workstation** and paste in the lines below, then save the file.

```yaml
---
    - hosts: localhost
      tasks:
        - debug: msg="Hooray!  Ansible is working!"
```

In your Ubuntu app, change your working directory to the folder where you saved your `test-ansible.yaml` file.

E.g. if you saved it to `C:/test-folder`, you would run the following Linux command.

```bash
cd /mnt/c/test-folder
```

Then run the following Linux command to run the test Ansible playbook.

```bash
ansible-playbook test-ansible.yaml
```

If your installation is in full working order, you should see the debug message returned in the output.

NOTE: This doesn't test that Ansible can connect to, and run commands on, the FortiGate firewalls hosted in Azure.  It's just a very basic test of Ansible itself.

----

## Appendix A: Restart the Ubuntu App Running Under WSL

It doesn't seem possible to issue a reboot command directly in the Ubuntu shell, so you should do this via PowerShell on the Windows host.

```powershell
wslconfig /L

wslconfig /t Ubuntu-20.04
```

Alternatively, the following command seems to work well.

```powershell
Get-Service LxssManager | Restart-Service
```

Then (re)open the Ubuntu app to start the shell running again.
