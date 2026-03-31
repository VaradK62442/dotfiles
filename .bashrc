#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -la'
alias grep='grep --color=auto'

parse_git_status() {
	local branch=$(git branch --show-current 2>/dev/null)
	if [[ -n "$branch" ]]; then
		local git_status=$(git status --porcelain 2>/dev/null)
		local status=":$branch"	

		if echo "$git_status" | grep -q '^??'; then status="$status [U]"; fi
		if echo "$git_status" | grep -q 'M'; then status="$status [M]"; fi
		if [[ -z "$git_status" ]]; then status="$status"; fi

		echo -e "\e[1;35m$status\e[0m"
	fi
}
PS1='\[\e[90m\][\t]\[\e[0m\] \[\e[01;32m\]\u@\h\[\e[00m\]:\[\e[01;34m\]\w\[\e[00m\]$(parse_git_status)\n\$ '

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
	. ~/.private_bash_aliases
fi

. "$HOME/.cargo/env"
