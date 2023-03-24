if status is-interactive
else
	#echo "not interactive"
	exit
end
# Commands to run in interactive sessions can go here
# -----------------------------------------------------------------------------------------------------

fish_vi_key_bindings

# -----------------------------------------------------------------------------------------------------

#set -gx PATH /opt/openresty/bin:~/.local/bin:$PATH
fish_add_path ~/.local/bin /opt/openresty/bin

set -gx EDITOR nvim-wrapper
set -gx SUDO_ASKPASS /usr/local/bin/sudo-askpass

set -gx GTK_THEME 'Yaru-Aqua-dark'

# -----------------------------------------------------------------------------------------------------

bind \em 'history merge'

# -----------------------------------------------------------------------------------------------------

alias ls='exa -L 1 -T --icons'
alias l='ls'
alias la='ls -hal'
alias lt='exa -T --icons'

alias cat='bat'

alias reload='source ~/.config/fish/config.fish'
alias rm='trash-put'
alias sudo='sudo -A'

# -----------------------------------------------------------------------------------------------------

starship init fish | source

functions --erase starship_prompt
functions --copy fish_prompt starship_prompt


source /home/absolpega/.config/fish/autojump.fish

# -----------------------------------------------------------------------------------------------------
# function definitions need to be last

# merges history
function fish_prompt --description "show starship prompt and run some commands"
	printf '\e[?25l' # hide cursor
	starship_prompt
	#history merge
	printf '\e[?25h' # show cursor
end

