# SLES (SUSE Linux Enterprise Server)

## Cheat sheet

### Quickstart

* Enable SSH

```bash
# switches to root account
su

# installs OpenSSH
zypper install openssh

# starts sshd service and checks status
systemctl start sshd

# checks sshd service status
systemctl status sshd

# enables sshd service
systemctl enable sshd

# adds sshd service in firewall
firewall-cmd --permanent --add-service=ssh

# reloads firewall
firewall-cmd --reload
```
