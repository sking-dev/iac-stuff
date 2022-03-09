# An Alternative Way to Set Up Ansible Under WSL

Source: <https://xkln.net/blog/running-ansible-on-windows-10-wsl/>

----

After installing WSL and an Ubuntu app.

First install any available Ubuntu updates.

`sudo apt-get update && sudo apt-get upgrade`

Then install the Ansible prerequisites.

`sudo apt-get -y install python3-pip python-dev libffi-dev libssl-dev`

Next install Ansible itself in the user's context (this is done to avoid permission issues with Pip that are specific to WSL)

`pip3 install ansible --user`

Finally, update `$PATH` to include `~/.local/bin` (this is where Ansible will live)

```shell
echo 'PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc

source .bashrc
```
