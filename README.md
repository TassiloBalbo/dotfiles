# dotfiles
Configuration files

# Additional Configuration

## Disabling mouse acceleration

create and open `/etc/X11/xorg.conf.d/50-mouse-acceleration.conf`
```
sudo nano /etc/X11/xorg.conf.d/50-mouse-acceleration.conf
```
and paste the following:
```
Section "InputClass"
	Identifier "My Mouse"
	MatchIsPointer "yes"
	Option "AccelerationProfile" "-1"
	Option "AccelerationScheme" "none"
	Option "AccelSpeed" "-1"
EndSection
```