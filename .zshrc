
# common settings
#-----------------------------------------------------------------------------
#export LANG=ja_JP.eucJP
export LANG=ja_JP.UTF-8

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
export HISTTIMEFORMAT='%Y-%m-%d %T '

bindkey -e
autoload -U compinit; compinit -d ~/.zcompdump

zstyle ':completion:*' group-name ''
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:descriptions' format '%d'
zstyle ':completion:*:options' verbose yes
zstyle ':completion:*:values' verbose yes
zstyle ':completion:*:options' prefix-needed yes

zstyle ':completion:*:default' menu select=1

zstyle ':completion:*' matcher-list \
  '' \
  'm:{a-z}={A-Z}' \
  'l:|=* r:|[.,_-]=* r:|=* m:{a-z}={A-Z}'

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

setopt \
HIST_IGNORE_SPACE \
alwayslastprompt autolist automenu \
autoparamslash autoremoveslash autoparamkeys \
listtypes listpacked \
completeinword printeightbit \
autopushd pushdminus pushd_ignore_dups \
no_beep correct extended_glob always_last_prompt cdable_vars sh_word_split auto_param_keys rcquotes sunkeyboardhack nonomatch

stty erase '^?'
stty stop undef

# hide rprompt after execute the command.
setopt transient_rprompt

# ディレクトリ名だけで cd
setopt auto_cd

# / を単語の境界と認識させる
# WORDCHARS="*?_-.[]~=/&;!#$%^(){}<>"
WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"

# ctrl-u の振る舞いを bash 風にする
bindkey \^U backward-kill-line

# 2秒以上かかったプロセスの内訳を表示する
REPORTTIME=2

# git のファイル名補完がはやくなるらしい
# http://u7fa9.org/memo/HEAD/archives/2011-02/2011-02-01.rst
__git_files() { _files }

# nice, ionice のショートカット
# execute row priority
alias allnice="ionice -c2 -n7 nice -n19"
# execute command with low priority
alias lowpriority="ionice -c3 nice -n19"

# environment
#-----------------------------------------------------------------------------
export PAGER=lv
export CVS_RSH=ssh
export EDITOR=vi

if [ "$PAGER" = "lv" ]; then
    export LV="-c -l"
else
    alias lv="$PAGER"
fi

# haxe
#-----------------------------------------------------------------------------
export HAXE_LIBRARY_PATH=/usr/local/haxe/std:. # the ':.' part is important
export HAXE_STD_PATH=/usr/local/haxe/std:. # the ':.' part is important
export HAXE_HOME=/usr/local/haxe
PATH=$HAXE_LIBRARY_PATH:$HAXE_HOME/bin:$PATH

# java
#-----------------------------------------------------------------------------
export JAVA_HOME=$(/usr/libexec/java_home)
PATH=$JAVA_HOME/bin:$PATH

# path
#-----------------------------------------------------------------------------
export PATH=/usr/local/php5/bin:/usr/local/bin:$PATH

# local settings
#-----------------------------------------------------------------------------
[[ -s "$HOME/.zshrc.d/.zshrc.`hostname -s`" ]] && source "$HOME/.zshrc.d/.zshrc.`hostname -s`"

# display
#-----------------------------------------------------------------------------
# PROMPT
setopt prompt_subst
autoload -U colors; colors

RPROMPT="%{${fg[green]}%}[%~]%{${reset_color}%}%{${fg[magenta]}%}\`__git_ps1\`%{${reset_color}%}"

# color
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export ZLS_COLORS=$LS_COLORS
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# 標準エラーに色を付けるグローバルエイリアス
tored() {
    perl -pe 's/^/\e[0;38;5;161m/ && s/$/\e[m/'
}
alias -g E='2> >(tored)'

# syntax highlight
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# completion
#-----------------------------------------------------------------------------
[[ -s $HOME/.git-completion.bash ]] && source $HOME/.git-completion.bash

# alias
#-----------------------------------------------------------------------------
setopt complete_aliases

[[ -s "$HOME/.zsh_aliases" ]] && source "$HOME/.zsh_aliases"

# tmux
#-----------------------------------------------------------------------------
t () {
    TMUXCMD="tmux -S $HOME/.tmux/socket"
    if $TMUXCMD ls > /dev/null 2>&1 ; then
        $TMUXCMD attach -d
    else
        ssh-agent $TMUXCMD
    fi
}

# php (with xdebug session)
#-----------------------------------------------------------------------------
phpx () {
    XDEBUG_CONFIG="idekey=DBGP" \
    XDEBUG_SESSION_START=DBGP \
    php $@
}
phpunitx () {
    XDEBUG_CONFIG="idekey=DBGP" \
    XDEBUG_SESSION_START=DBGP \
    phpunit $@
}

# display color code list
#-----------------------------------------------------------------------------
function pcolor() {
    for ((f = 0; f < 255; f++)); do
        printf "\e[38;5;%dm %3d#\e[m" $f $f
        if [[ $f%8 -eq 7 ]] then
            printf "\n"
        fi
    done

    echo
    echo 

    echo "tmux color code"
    for i in $(seq 0 4 255); do
        for j in $(seq $i $(expr $i + 3)); do
            for k in $(seq 1 $(expr 3 - ${#j})); do
                printf " "
            done
            printf "\x1b[38;5;${j}mcolour${j}"
            [[ $(expr $j % 4) != 3 ]] && printf "    "
        done
        printf "\n"
    done

    printf "\n"
}

# for tmux
#-----------------------------------------------------------------------------
PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'


# EOF
