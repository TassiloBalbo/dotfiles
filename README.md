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

## Changing mouse speed

list input devices using `xinput list`

change sensitivity using:
<pre>
xinput set-prop 8 156 <b>1.5</b> 0 0 0 <b>1.5</b> 0 0 0 1
</pre>
<pre>
xinput set-prop [Device ID] 156 <b>[X Speed]</b> 0 0 0 <b>[Y Speed]</b> 0 0 0 1
</pre>
