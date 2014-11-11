#特殊字符：http://www.unicode.org/charts/PDF/U1F600.pdf
#注意：颜色设置要加[]，否则当输入超过bash一行显示的字符时，光标会跳到开头，覆盖之前的字符
#原因:对于不打印的字符，如果不用[]括起来，bash在换行计算光标位置时会减去不打印字符的长度 see http://askubuntu.com/questions/24358/how-do-i-get-long-command-lines-to-wrap-to-the-next-line
PS1="[\u \[\e[0;32m\]\`if [ \$? = 0 ]; then echo -e '\[\e[01;32m\]\xE2\x98\xBA'; else echo -e '\[\e[01;31m\]\xE2\x98\xB9'; fi\`\[\e[m\] \W\[\e[0;32m\]\$(parse_git_branch)\[\e[m\]]\$ "

parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

export PATH="$PATH:$HOME/bin"
