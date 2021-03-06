#
# ~/.bashrc
# Tassilo Balbo
#

export PATH="$HOME/.scripts:$PATH"
#export TERM="urxvt"
export EDITOR="nano"
export GUI_EDITOR="code"
export BROWSER="brave"

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

### bash prompt
#PS1='[\u@\h \W]\$ '
#PS1='\[\033[36m\]\w \[\033[35m\]>> \[\033[37m\]'
PS2='\[\033[35m\]>> \[\033[37m\]'
parse_git_dirty () {
	[[ $(git status 2> /dev/null | tail -1) != "nothing to commit, working tree clean" ]] && echo "*"
}

parse_git_branch () {
	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

show_git_prompt () {
	git branch 2>/dev/null 1>&2 && echo -e "-( \e[36;1m$(parse_git_branch)\e[35;1m )"
}

if [[ -n $(type -t git) ]] ; then
	PS1="\$(show_git_prompt)"
else
	PS1=
fi

PS1="
\[\033[35m\]┌────[ \[\e[32;1m\]\u\[\033[35m\] :: \[\e[36;1m\]\h\[\033[35m\] ]─( \[\e[31;1m\]λ\[\033[35m\] )─[ \[\e[32;1m\]\w\[\033[35m\] ]$PS1
\[\033[35m\]└── \[\033[36m\]>> \[\e[0m\]"

### archive extraction
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;      
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

### aliases

# navigation
alias ..='cd ..' 
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# yay update
alias yaysyu="yay -Syu --noconfirm" 

# Colorize grep output (good for log files)
alias grep='grep --color=auto'

# confirm before overwriting something
# alias cp="cp -i"
# alias mv='mv -i'
# alias rm='rm -i'

# get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

# get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

# shutdown or reboot
alias ssn="sudo shutdown now"
alias sr="sudo reboot"
alias logout="light-locker-command -l"

# get error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# git
alias addup='git add -u'
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias status='git status'
alias tag='git tag'
alias newtag='git tag -a'

# youtube-dl
alias yta-mp3="youtube-dl --extract-audio --audio-format mp3 "
alias ytv-best="youtube-dl -f bestvideo+bestaudio "

# the terminal rickroll
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'

## random color script
~/.scripts/colorscript/colorscript.sh random
