# Everforest light-medium theme
# Add these environment variables to your fish config (e.g., ~/.config/fish/config.fish)

# Everforest color definitions for eza
set -gx EZA_COLORS "\
di=#7fbbb3:\
ex=#e67e80:\
fi=#5c6a72:\
ln=#83c092:\
or=#e67e80:\
ow=#7fbbb3:\
pi=#d699b6:\
so=#e69875:\
bd=#dbbc7f:\
cd=#dbbc7f:\
su=#e67e80:\
sg=#e67e80:\
tw=#7fbbb3:\
st=#c0cdb8:\
*.tar=#e69875:\
*.zip=#e69875:\
*.7z=#e69875:\
*.gz=#e69875:\
*.bz2=#e69875:\
*.xz=#e69875:\
*.jpg=#d699b6:\
*.jpeg=#d699b6:\
*.png=#d699b6:\
*.gif=#d699b6:\
*.svg=#d699b6:\
*.pdf=#a7c080:\
*.txt=#5c6a72:\
*.md=#a7c080:\
*.json=#dbbc7f:\
*.yml=#dbbc7f:\
*.yaml=#dbbc7f:\
*.xml=#dbbc7f:\
*.toml=#dbbc7f:\
*.ini=#dbbc7f:\
*.cfg=#dbbc7f:\
*.conf=#dbbc7f:\
*.log=#c0cdb8:\
*.tmp=#c0cdb8:\
*.bak=#c0cdb8:\
*.swp=#c0cdb8:\
*.lock=#c0cdb8:\
*.js=#dbbc7f:\
*.ts=#7fbbb3:\
*.jsx=#7fbbb3:\
*.tsx=#7fbbb3:\
*.py=#7fbbb3:\
*.rb=#e67e80:\
*.go=#83c092:\
*.rs=#e69875:\
*.c=#7fbbb3:\
*.cpp=#7fbbb3:\
*.h=#d699b6:\
*.hpp=#d699b6:\
*.java=#e69875:\
*.class=#e69875:\
*.sh=#a7c080:\
*.bash=#a7c080:\
*.zsh=#a7c080:\
*.fish=#a7c080:\
*.vim=#a7c080:\
*.nvim=#a7c080"

# Alternative aliases for eza with color support
alias ls='eza --color=always --group-directories-first'
alias ll='eza --color=always --group-directories-first --long'
alias la='eza --color=always --group-directories-first --long --all'
alias lt='eza --color=always --group-directories-first --tree'
