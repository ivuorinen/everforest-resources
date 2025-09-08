# Everforest light-soft theme for Zsh
# Add this to your ~/.zshrc

# Everforest color scheme for Zsh syntax highlighting and prompt
# Requires zsh-syntax-highlighting plugin

# Enable colors in terminal
export CLICOLOR=1

# Set LS_COLORS for directory listings (using ANSI codes)
export LS_COLORS="di=01;4:ln=01;6:so=01;5:pi=40;5:ex=01;1:bd=40;3;01:cd=40;3;01:su=37;41:sg=30;43:tw=30;4:ow=4;42:st=37;44:*.tar=01;9:*.tgz=01;9:*.arc=01;9:*.arj=01;9:*.taz=01;9:*.lha=01;9:*.lz4=01;9:*.lzh=01;9:*.lzma=01;9:*.tlz=01;9:*.txz=01;9:*.tzo=01;9:*.t7z=01;9:*.zip=01;9:*.z=01;9:*.dz=01;9:*.gz=01;9:*.lrz=01;9:*.lz=01;9:*.lzo=01;9:*.xz=01;9:*.zst=01;9:*.tzst=01;9:*.bz2=01;9:*.bz=01;9:*.tbz=01;9:*.tbz2=01;9:*.tz=01;9:*.deb=01;9:*.rpm=01;9:*.jar=01;9:*.war=01;9:*.ear=01;9:*.sar=01;9:*.rar=01;9:*.alz=01;9:*.ace=01;9:*.zoo=01;9:*.cpio=01;9:*.7z=01;9:*.rz=01;9:*.cab=01;9:*.jpg=01;5:*.jpeg=01;5:*.mjpg=01;5:*.mjpeg=01;5:*.gif=01;5:*.bmp=01;5:*.pbm=01;5:*.pgm=01;5:*.ppm=01;5:*.tga=01;5:*.xbm=01;5:*.xpm=01;5:*.tif=01;5:*.tiff=01;5:*.png=01;5:*.svg=01;5:*.svgz=01;5:*.mng=01;5:*.pcx=01;5:*.mov=01;5:*.mpg=01;5:*.mpeg=01;5:*.m2v=01;5:*.mkv=01;5:*.webm=01;5:*.ogm=01;5:*.mp4=01;5:*.m4v=01;5:*.mp4v=01;5:*.vob=01;5:*.qt=01;5:*.nuv=01;5:*.wmv=01;5:*.asf=01;5:*.rm=01;5:*.rmvb=01;5:*.flc=01;5:*.avi=01;5:*.fli=01;5:*.flv=01;5:*.gl=01;5:*.dl=01;5:*.xcf=01;5:*.xwd=01;5:*.yuv=01;5:*.cgm=01;5:*.emf=01;5:*.ogv=01;5:*.ogx=01;5:*.aac=00;6:*.au=00;6:*.flac=00;6:*.m4a=00;6:*.mid=00;6:*.midi=00;6:*.mka=00;6:*.mp3=00;6:*.mpc=00;6:*.ogg=00;6:*.ra=00;6:*.wav=00;6:*.oga=00;6:*.opus=00;6:*.spx=00;6:*.xspf=00;6"

# Zsh syntax highlighting colors (if using zsh-syntax-highlighting)
if [[ -n "${ZSH_HIGHLIGHT_STYLES}" ]]; then
    # Commands and builtins
    ZSH_HIGHLIGHT_STYLES[command]='fg=#7fbbb3'
    ZSH_HIGHLIGHT_STYLES[builtin]='fg=#7fbbb3'
    ZSH_HIGHLIGHT_STYLES[alias]='fg=#7fbbb3'
    ZSH_HIGHLIGHT_STYLES[function]='fg=#7fbbb3'

    # Keywords
    ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#e67e80'

    # Strings
    ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#a7c080'
    ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#a7c080'
    ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#a7c080'

    # Variables
    ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=#83c092'
    ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=#83c092'
    ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=#83c092'

    # Options and flags
    ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#dbbc7f'
    ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#dbbc7f'

    # Paths
    ZSH_HIGHLIGHT_STYLES[path]='fg=#5c6a72'
    ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=#c0cdb8'

    # Comments
    ZSH_HIGHLIGHT_STYLES[comment]='fg=#c0cdb8'

    # Errors
    ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#e67e80'

    # Globbing
    ZSH_HIGHLIGHT_STYLES[globbing]='fg=#d699b6'

    # History expansion
    ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#e69875'
fi

# Simple Everforest prompt example
# You can customize this further or use with prompt frameworks like Oh My Zsh
PROMPT='%F{4}%n%f@%F{2}%m%f:%F{3}%~%f%# '
