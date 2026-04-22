# general exports
export EDITOR=zeditor

# directories
export DIR_DOWNLOADS=/home/varad/Downloads
export DIR_NOTES=/home/varad/Desktop/Notes
export DIR_PROGRAMMING=/home/varad/Desktop/programming
export DIR_ALGMATCH=$DIR_PROGRAMMING/algmatch
export DIR_COASTER=$DIR_PROGRAMMING/coaster/coaster

# general aliases
alias vim='nvim'
alias a='sudo nvim ~/.bash_aliases'
alias b='cd ../'
alias q='qalc'
alias cat='bat'
alias gittree='git log --graph --pretty=oneline --abbrev-commit'
alias conf='vim ~/.config/'
alias fastfetch='portalfetch'
alias activate='source .venv/bin/activate'
alias coaster="$DIR_COASTER/target/debug/coaster"

# git aliases
alias ga='git add'
alias gs='git status'
alias gc='git commit'
alias gp='git push'
alias gd='git diff'
alias gr='git restore'

# general functions
git() {
  REL_EXP_DIR=src/algmatch/stableMatchings/studentProjectAllocation/ties/experiments
  if [[ "$(pwd)" == "$DIR_ALGMATCH"* ]]; then
    cwd=$(pwd)
    cd "$DIR_ALGMATCH"
    if [ "$1" = "push" ]; then
      command git push "${@:2}"
      command git subtree push --prefix=$REL_EXP_DIR experiments_repo main
    elif [ "$1" = "pull" ]; then
      command git subtree pull --prefix=$REL_EXP_DIR experiments_repo main
      command git pull "${@:2}"
    else
      cd "$cwd"
      command git "$@"
    fi
    cd "$cwd"
  else
    command git "$@"
  fi
}

program () {
	cd
	if [ -d "$DIR_PROGRAMMING/$1" ]; then
		cd $DIR_PROGRAMMING/$1;
		$EDITOR .;
		if [ -d "$DIR_PROGRAMMING/$1/.venv" ]; then
			activate;
		fi
	else
		mkdir $DIR_PROGRAMMING/$1;
		cd $DIR_PROGRAMMING/$1;
		$EDITOR .;
	fi
}

note () {
	vim $DIR_NOTES/$1;
}

mv_latest () {
	if [ "$#" -ne 1 ]; then
		echo $(ls -rth1 $DIR_DOWNLOADS | tail -1)
	else
		mv $DIR_DOWNLOADS/$(ls -rth1 $DIR_DOWNLOADS | tail -1) $DIR_DOWNLOADS/"$1";
	fi
}

# general function completions
_program() {
	local PROGRAM_DIR=$DIR_PROGRAMMING/
	local cmd=$1 cur=$2 pre=$3
	local arr i file

	arr=( $( cd "$PROGRAM_DIR" && compgen -f -- "$cur" ) )
	COMPREPLY=()
	for ((i = 0; i < ${#arr[@]}; ++i)); do
        	file=${arr[i]}
        	if [[ -d $MEMO_DIR/$file ]]; then
            		file=$file/
        	fi
        	COMPREPLY[i]=$file
    	done
}
complete -F _program -o nospace program

_note() {
	local NOTE_DIR=$DIR_NOTES/;
	local cmd=$1 cur=$2 pre=$3
	local arr i file

	arr=( $( cd "$NOTE_DIR" && compgen -f -- "$cur" ) )
	COMPREPLY=()
	for ((i = 0; i < ${#arr[@]}; ++i)); do
        	file=${arr[i]}
        	if [[ -d $MEMO_DIR/$file ]]; then
        	    	file=$file/
        	fi
        	COMPREPLY[i]=$file
    	done
}
complete -F _note -o nospace note
