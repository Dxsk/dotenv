#!/usr/bin/env zsh
# =============================================================================
#  Workstation Management Aliases & Functions - Fedora Asahi
# =============================================================================

# -----------------------------------------------------------------------------
#  Default Editor
# -----------------------------------------------------------------------------
export EDITOR='vim'
export VISUAL='vim'
export SUDO_EDITOR='vim'

# Vim aliases
alias v='vim'
alias vi='vim'
alias vd='vim -d'
alias vr='vim -R'
alias vimrc='vim ~/.vimrc'

# -----------------------------------------------------------------------------
#  Python & Virtual Environments
# -----------------------------------------------------------------------------
if (( $+commands[python3] )); then
    alias py='python3'
    alias pip='pip3'
    alias pipi='pip3 install'
    alias pipu='pip3 install --upgrade'
    alias pipr='pip3 install -r requirements.txt'
    alias pipf='pip3 freeze'
    alias pipfr='pip3 freeze > requirements.txt'
    alias piplist='pip3 list'
    alias pipout='pip3 list --outdated'
    alias pipcache='pip3 cache purge'
    alias pyserve='python3 -m http.server'
    alias pyserve8='python3 -m http.server 8000'
fi

(( $+commands[python2] )) && alias py2='python2'

# Create and activate a venv
venv() {
    local venv_name="${1:-venv}"
    print "==> Creating venv '$venv_name'..."
    python3 -m venv "$venv_name" || return 1
    print "==> Activating venv..."
    source "$venv_name/bin/activate" || return 1
    print "==> Upgrading pip..."
    pip install --upgrade pip
    print "==> Venv '$venv_name' ready!"
}

# Activate an existing venv
va() {
    local venv_name="${1:-venv}"
    if [[ -d "$venv_name/bin" ]]; then
        source "$venv_name/bin/activate"
        print "Venv '$venv_name' activated"
    elif [[ -d ".venv/bin" ]]; then
        source .venv/bin/activate
        print "Venv '.venv' activated"
    else
        print "No venv found ($venv_name or .venv)" >&2
        return 1
    fi
}

alias vd='deactivate'

# Create a venv with .venv name (modern convention)
venv.() {
    venv .venv
}

# Remove a venv
venv-rm() {
    local venv_name="${1:-venv}"
    if [[ -d "$venv_name" ]]; then
        [[ "$VIRTUAL_ENV" == *"$venv_name"* ]] && deactivate
        rm -rf "$venv_name"
        print "Venv '$venv_name' removed"
    else
        print "Venv '$venv_name' not found" >&2
        return 1
    fi
}

# Reset a venv (remove + create)
venv-reset() {
    local venv_name="${1:-venv}"
    venv-rm "$venv_name" 2>/dev/null
    venv "$venv_name"
}

# Install requirements and activate
venv-init() {
    local venv_name="${1:-venv}"
    venv "$venv_name" || return 1
    if [[ -f "requirements.txt" ]]; then
        print "==> Installing requirements..."
        pip install -r requirements.txt
    fi
}

# Show current venv info
venv-info() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        print "Active venv: $VIRTUAL_ENV"
        print "Python: $(python --version 2>&1)"
        print "Pip: $(pip --version 2>&1)"
        print "Installed packages: $(pip list 2>/dev/null | wc -l)"
    else
        print "No active venv"
    fi
}

# List venvs in current directory
venv-list() {
    print "Found venvs:"
    local dir
    for dir in */(N) .*/(N); do
        [[ -f "${dir}bin/activate" ]] && print "  - ${dir%/}"
    done
}

# -----------------------------------------------------------------------------
#  JSON with jq
# -----------------------------------------------------------------------------
if (( $+commands[jq] )); then
    alias jqc='jq -C'
    alias jqr='jq -r'
    alias jqm='jq -c'
    alias jqs='jq -S'
    alias jqkeys='jq keys'
    alias jqlen='jq length'

    jqget() { jq -r ".$1"; }

    jqvalid() {
        if jq empty 2>/dev/null; then
            print "Valid JSON"
        else
            print "Invalid JSON" >&2
            return 1
        fi
    }
fi

# -----------------------------------------------------------------------------
#  System Updates (Fedora/DNF)
# -----------------------------------------------------------------------------
if (( $+commands[dnf] )); then
    alias maj='sudo dnf upgrade --refresh'
    alias maj-check='dnf check-update'
    alias maj-auto='sudo dnf upgrade --refresh -y'
    alias maj-kernel='sudo dnf upgrade kernel\*'
    alias maj-reboot='sudo dnf upgrade --refresh && sudo systemctl reboot'

    alias dnfi='sudo dnf install'
    alias dnfr='sudo dnf remove'
    alias dnfs='dnf search'
    alias dnfinfo='dnf info'
    alias dnflist='dnf list installed'
    alias dnfclean='sudo dnf autoremove && sudo dnf clean all'
    alias dnfhistory='dnf history'

    # Full update (system + flatpak + firmware)
    majall() {
        print "==> Updating DNF..."
        sudo dnf upgrade --refresh

        if (( $+commands[flatpak] )); then
            print "\n==> Updating Flatpak..."
            flatpak update
        fi

        if (( $+commands[fwupdmgr] )); then
            print "\n==> Checking firmware..."
            sudo fwupdmgr get-updates 2>/dev/null || print "No firmware updates"
        fi

        print "\n==> Done!"
    }

    # Interactive package search with fzf
    if (( $+commands[fzf] )); then
        dnzf() {
            local pkg
            pkg=$(dnf search "$1" 2>/dev/null | grep -v "^=" | fzf --preview 'dnf info {1}' | awk '{print $1}')
            if [[ -n "$pkg" ]]; then
                print -n "Install $pkg? [y/N] "
                read -r confirm
                [[ "$confirm" == [yY] ]] && sudo dnf install "$pkg"
            fi
        }
    fi
fi

# -----------------------------------------------------------------------------
#  Systemd Services
# -----------------------------------------------------------------------------
if (( $+commands[systemctl] )); then
    alias scs='sudo systemctl status'
    alias sstart='sudo systemctl start'
    alias sstop='sudo systemctl stop'
    alias srestart='sudo systemctl restart'
    alias senable='sudo systemctl enable'
    alias sdisable='sudo systemctl disable'
    alias sreload='sudo systemctl daemon-reload'
    alias sfailed='systemctl --failed'
    alias slist='systemctl list-units --type=service --state=running'

    alias jlog='journalctl -xe'
    alias jboot='journalctl -b'
    alias jfollow='journalctl -f'
    alias jkernel='journalctl -k'

    # Interactive service with fzf
    if (( $+commands[fzf] )); then
        svc() {
            local service
            service=$(systemctl list-units --type=service --all | fzf | awk '{print $1}')
            [[ -n "$service" ]] && systemctl status "$service"
        }
    fi
fi

# -----------------------------------------------------------------------------
#  System Monitoring
# -----------------------------------------------------------------------------
alias meminfo='free -h'
alias cpuinfo='lscpu'
alias diskinfo='df -h'
alias diskuse='du -sh * 2>/dev/null | sort -h'
alias top10='du -ah . 2>/dev/null | sort -rh | head -10'
alias ports='ss -tulpn'
alias pscpu='ps auxf | sort -nr -k 3 | head -10'
alias psmem='ps auxf | sort -nr -k 4 | head -10'

# Temperature reading
temp() {
    local zone temp_val
    for zone in /sys/class/thermal/thermal_zone*/temp(N); do
        temp_val=$(<"$zone")
        print "${zone:h:t}: $(( temp_val / 1000 )).$(( temp_val % 1000 / 100 ))°C"
    done
}

# Full system info
sysinfo() {
    print "=== SYSTEM ==="
    hostnamectl
    print "\n=== CPU ==="
    lscpu | grep -E "Model name|Socket|Core|Thread"
    print "\n=== MEMORY ==="
    free -h
    print "\n=== DISKS ==="
    df -h | grep -v tmpfs
    print "\n=== UPTIME ==="
    uptime
}

# -----------------------------------------------------------------------------
#  Network
# -----------------------------------------------------------------------------
alias ip-local='ip -br addr'
alias ip-public='curl -s ifconfig.me && print'
alias ip-all='ip addr show'
alias ping8='ping -c 4 8.8.8.8'
alias pingdns='ping -c 4 1.1.1.1'
alias connections='ss -tup'

if (( $+commands[nmcli] )); then
    alias wifi='nmcli device wifi list'
    alias wifi-on='nmcli radio wifi on'
    alias wifi-off='nmcli radio wifi off'
    alias wifi-connect='nmcli device wifi connect'
    alias net-restart='sudo systemctl restart NetworkManager'
fi

# -----------------------------------------------------------------------------
#  Cleanup
# -----------------------------------------------------------------------------
alias clean-cache='sudo dnf clean all'
alias clean-journal='sudo journalctl --vacuum-time=7d'
alias clean-tmp='sudo rm -rf /tmp/* /var/tmp/*'

cleanup() {
    print "==> Cleaning DNF cache..."
    sudo dnf clean all

    print "\n==> Removing orphan packages..."
    sudo dnf autoremove -y

    print "\n==> Cleaning journals (> 7 days)..."
    sudo journalctl --vacuum-time=7d

    if (( $+commands[flatpak] )); then
        print "\n==> Cleaning Flatpak..."
        flatpak uninstall --unused -y 2>/dev/null || true
    fi

    print "\n==> Disk space:"
    df -h /
}

# -----------------------------------------------------------------------------
#  Power Management (Asahi specific)
# -----------------------------------------------------------------------------
if (( $+commands[powerprofilesctl] )); then
    alias power-profile='powerprofilesctl get'
    alias power-balanced='powerprofilesctl set balanced'
    alias power-save='powerprofilesctl set power-saver'
    alias power-perf='powerprofilesctl set performance'
fi

if (( $+commands[upower] )); then
    alias battery='upower -i /org/freedesktop/UPower/devices/battery_macsmc_battery 2>/dev/null || print "No battery"'
fi

# -----------------------------------------------------------------------------
#  Podman - Container Management
# -----------------------------------------------------------------------------
if (( $+commands[podman] )); then
    alias p='podman'
    alias pps='podman ps'
    alias ppsa='podman ps -a'
    alias pimg='podman images'
    alias prun='podman run -it --rm'
    alias prund='podman run -d'
    alias pexec='podman exec -it'
    alias plogs='podman logs'
    alias plogsf='podman logs -f'
    alias pstop='podman stop'
    alias pstart='podman start'
    alias prestart='podman restart'
    alias prm='podman rm'
    alias prmi='podman rmi'
    alias ppull='podman pull'
    alias ppush='podman push'
    alias pbuild='podman build'
    alias pinspect='podman inspect'
    alias pstats='podman stats'
    alias ptop='podman top'
    alias pnetwork='podman network ls'
    alias pvolume='podman volume ls'
    alias pprune='podman system prune -f'
    alias ppruneall='podman system prune -a -f --volumes'
    alias pinfo='podman info'
    alias pdf='podman system df'
    alias pversion='podman version'
    alias pcp='podman cp'

    # Podman Compose
    if (( $+commands[podman-compose] )); then
        alias pc='podman-compose'
        alias pcup='podman-compose up -d'
        alias pcdown='podman-compose down'
        alias pcrestart='podman-compose restart'
        alias pclogs='podman-compose logs -f'
        alias pcps='podman-compose ps'
        alias pcbuild='podman-compose build'
        alias pcpull='podman-compose pull'
    fi

    # Interactive functions with fzf
    if (( $+commands[fzf] )); then
        psh() {
            local container
            container=$(podman ps --format "{{.Names}}\t{{.Image}}\t{{.Status}}" | fzf | awk '{print $1}')
            [[ -n "$container" ]] && podman exec -it "$container" /bin/sh
        }

        pbash() {
            local container
            container=$(podman ps --format "{{.Names}}\t{{.Image}}\t{{.Status}}" | fzf | awk '{print $1}')
            [[ -n "$container" ]] && podman exec -it "$container" /bin/bash
        }

        plogf() {
            local container
            container=$(podman ps -a --format "{{.Names}}\t{{.Image}}\t{{.Status}}" | fzf | awk '{print $1}')
            [[ -n "$container" ]] && podman logs -f "$container"
        }

        pstopf() {
            local container
            container=$(podman ps --format "{{.Names}}\t{{.Image}}\t{{.Status}}" | fzf | awk '{print $1}')
            [[ -n "$container" ]] && podman stop "$container"
        }

        prmf() {
            local container
            container=$(podman ps -a --format "{{.Names}}\t{{.Image}}\t{{.Status}}" | fzf | awk '{print $1}')
            if [[ -n "$container" ]]; then
                print -n "Remove $container? [y/N] "
                read -r confirm
                [[ "$confirm" == [yY] ]] && podman rm -f "$container"
            fi
        }

        prmif() {
            local image
            image=$(podman images --format "{{.Repository}}:{{.Tag}}\t{{.Size}}\t{{.Created}}" | fzf | awk '{print $1}')
            if [[ -n "$image" ]]; then
                print -n "Remove $image? [y/N] "
                read -r confirm
                [[ "$confirm" == [yY] ]] && podman rmi "$image"
            fi
        }

        pports() {
            local container="${1:-}"
            [[ -z "$container" ]] && container=$(podman ps --format "{{.Names}}" | fzf)
            [[ -n "$container" ]] && podman port "$container"
        }

        phistory() {
            local image="${1:-}"
            [[ -z "$image" ]] && image=$(podman images --format "{{.Repository}}:{{.Tag}}" | fzf)
            [[ -n "$image" ]] && podman history "$image"
        }
    fi

    # Full Podman cleanup
    pcleanall() {
        print "==> Stopping all containers..."
        podman stop $(podman ps -q) 2>/dev/null || true

        print "\n==> Removing stopped containers..."
        podman rm $(podman ps -aq) 2>/dev/null || true

        print "\n==> Removing unused images..."
        podman image prune -a -f

        print "\n==> Removing unused volumes..."
        podman volume prune -f

        print "\n==> Removing unused networks..."
        podman network prune -f

        print "\n==> Recovered space:"
        podman system df
    }

    # Full Podman status
    pstatus() {
        print "=== RUNNING CONTAINERS ==="
        podman ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"
        print "\n=== ALL CONTAINERS ==="
        podman ps -a --format "table {{.Names}}\t{{.Image}}\t{{.Status}}"
        print "\n=== IMAGES ==="
        podman images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}"
        print "\n=== DISK USAGE ==="
        podman system df
    }

    psave() {
        local image="$1"
        local output="${2:-${image//\//_}.tar}"
        podman save -o "$output" "$image" && print "Image saved: $output"
    }

    pload() {
        local file="$1"
        podman load -i "$file" && print "Image loaded from: $file"
    }

    pexport() {
        local container="$1"
        local output="${2:-${container}.tar}"
        podman export -o "$output" "$container" && print "Container exported: $output"
    }

    pimport() {
        local file="$1"
        local name="$2"
        podman import "$file" "$name" && print "Container imported: $name"
    }
fi

# -----------------------------------------------------------------------------
#  Reboot / Shutdown
# -----------------------------------------------------------------------------
alias reboot='sudo systemctl reboot'
alias poweroff='sudo systemctl poweroff'
alias suspend='sudo systemctl suspend'
alias hibernate='sudo systemctl hibernate'

reboot-in() {
    local -i minutes=${1:-5}
    print "Rebooting in $minutes minutes..."
    sudo shutdown -r "+$minutes"
}

# -----------------------------------------------------------------------------
#  Quick Config Files
# -----------------------------------------------------------------------------
alias zshrc='${EDITOR:-vim} ~/.zshrc'
alias reload='source ~/.zshrc && print "Config reloaded!"'
alias aliases='${EDITOR:-vim} ~/Documents/dotenv/zsh/workstation.zsh'

# -----------------------------------------------------------------------------
#  Misc Utilities
# -----------------------------------------------------------------------------
alias cls='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias mkdir='mkdir -pv'
alias df='df -h'
alias du='du -h'
alias grep='grep --color=auto'
alias now='date +"%Y-%m-%d %H:%M:%S"'
alias week='date +%V'
alias path='print -l ${(s.:.)PATH}'

# History with fzf
(( $+commands[fzf] )) && alias h='history | fzf'

# Quick edit with fzf
if (( $+commands[fzf] )); then
    e() {
        local file
        file=$(fzf --preview 'head -100 {}')
        [[ -n "$file" ]] && "${EDITOR:-vim}" "$file"
    }
fi

# Create a directory and cd into it
mkcd() {
    mkdir -p "$1" && builtin cd -- "$1"
}

# Universal extraction
extract() {
    if [[ ! -f "$1" ]]; then
        print "'$1' is not a valid file" >&2
        return 1
    fi

    case "$1" in
        *.tar.bz2)   tar xjf "$1"     ;;
        *.tar.gz)    tar xzf "$1"     ;;
        *.tar.xz)    tar xJf "$1"     ;;
        *.bz2)       bunzip2 "$1"     ;;
        *.rar)       unrar x "$1"     ;;
        *.gz)        gunzip "$1"      ;;
        *.tar)       tar xf "$1"      ;;
        *.tbz2)      tar xjf "$1"     ;;
        *.tgz)       tar xzf "$1"     ;;
        *.zip)       unzip "$1"       ;;
        *.Z)         uncompress "$1"  ;;
        *.7z)        7z x "$1"        ;;
        *)           print "'$1' format not supported" >&2; return 1 ;;
    esac
}

# -----------------------------------------------------------------------------
#  Help Functions
# -----------------------------------------------------------------------------
ws-help() {
    local B=$'\033[1m' N=$'\033[0m'
    local BLUE=$'\033[38;5;75m' GREEN=$'\033[38;5;114m'
    local YELLOW=$'\033[38;5;221m' GRAY=$'\033[38;5;250m'
    local MAGENTA=$'\033[38;5;213m' CYAN=$'\033[38;5;87m'

    print "
  ${BLUE}${B}WORKSTATION ALIASES${N}
  ${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}

  ${YELLOW}${B}UPDATES${N}
    ${GREEN}maj${N}            ${GRAY}System update${N}
    ${GREEN}majall${N}         ${GRAY}Full update (dnf+flatpak+fw)${N}
    ${GREEN}maj-check${N}      ${GRAY}Check available updates${N}

  ${YELLOW}${B}PACKAGES${N}
    ${GREEN}dnfi${N} <pkg>     ${GRAY}Install a package${N}
    ${GREEN}dnfs${N} <term>    ${GRAY}Search a package${N}
    ${GREEN}dnzf${N} <term>    ${GRAY}Interactive search with fzf${N}
    ${GREEN}dnfclean${N}       ${GRAY}Clean cache + orphans${N}

  ${YELLOW}${B}SERVICES${N}
    ${GREEN}scs${N} <svc>      ${GRAY}Service status${N}
    ${GREEN}svc${N}            ${GRAY}Interactive service selection${N}
    ${GREEN}sfailed${N}        ${GRAY}Failed services${N}
    ${GREEN}jlog${N}           ${GRAY}System logs${N}

  ${YELLOW}${B}MONITORING${N}
    ${GREEN}sysinfo${N}        ${GRAY}Full system info${N}
    ${GREEN}meminfo${N}        ${GRAY}Memory${N}
    ${GREEN}diskinfo${N}       ${GRAY}Disks${N}
    ${GREEN}pscpu${N}/${GREEN}psmem${N}    ${GRAY}Top CPU/RAM processes${N}

  ${YELLOW}${B}NETWORK${N}
    ${GREEN}ip-local${N}       ${GRAY}Local IP${N}
    ${GREEN}ip-public${N}      ${GRAY}Public IP${N}
    ${GREEN}wifi${N}           ${GRAY}Available WiFi networks${N}
    ${GREEN}ports${N}          ${GRAY}Open ports${N}

  ${YELLOW}${B}CLEANUP${N}
    ${GREEN}cleanup${N}        ${GRAY}Full system cleanup${N}
    ${GREEN}clean-journal${N}  ${GRAY}Clean journals${N}

  ${YELLOW}${B}POWER${N}
    ${GREEN}battery${N}        ${GRAY}Battery status${N}
    ${GREEN}power-save${N}     ${GRAY}Power saving mode${N}
    ${GREEN}power-perf${N}     ${GRAY}Performance mode${N}

  ${YELLOW}${B}PYTHON & VENV${N}
    ${GREEN}venv${N} [name]    ${GRAY}Create and activate a venv${N}
    ${GREEN}venv.${N}          ${GRAY}Create and activate a '.venv'${N}
    ${GREEN}va${N} [name]      ${GRAY}Activate an existing venv${N}
    ${GREEN}vd${N}             ${GRAY}Deactivate venv${N}
    ${GREEN}venv-init${N}      ${GRAY}Create venv + install requirements${N}
    ${GREEN}venv-info${N}      ${GRAY}Info about active venv${N}
    ${GREEN}pipi${N} <pkg>     ${GRAY}pip install${N}

  ${YELLOW}${B}MISC${N}
    ${GREEN}reload${N}         ${GRAY}Reload zsh config${N}
    ${GREEN}aliases${N}        ${GRAY}Edit this file${N}
    ${GREEN}e${N}              ${GRAY}Edit a file (fzf)${N}
    ${GREEN}extract${N}        ${GRAY}Extract an archive${N}

  ${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}
  ${MAGENTA}Type '${CYAN}podman-help${MAGENTA}' for Podman commands${N}
"
}

podman-help() {
    local B=$'\033[1m' N=$'\033[0m'
    local MAGENTA=$'\033[38;5;213m' CYAN=$'\033[38;5;87m'
    local GREEN=$'\033[38;5;114m' YELLOW=$'\033[38;5;221m' GRAY=$'\033[38;5;250m'

    print "
  ${MAGENTA}${B}PODMAN ALIASES${N}
  ${MAGENTA}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}

  ${YELLOW}${B}CONTAINERS${N}
    ${GREEN}pps${N}            ${GRAY}List running containers${N}
    ${GREEN}ppsa${N}           ${GRAY}List all containers${N}
    ${GREEN}prun${N} <img>     ${GRAY}Run interactive container (auto rm)${N}
    ${GREEN}pexec${N} <c>      ${GRAY}Execute command in container${N}
    ${GREEN}psh${N} / ${GREEN}pbash${N}    ${GRAY}Interactive shell (fzf)${N}
    ${GREEN}pstop${N} <c>      ${GRAY}Stop a container${N}
    ${GREEN}pstopf${N}         ${GRAY}Stop a container (fzf)${N}
    ${GREEN}prm${N} <c>        ${GRAY}Remove a container${N}
    ${GREEN}prmf${N}           ${GRAY}Remove a container (fzf)${N}

  ${YELLOW}${B}IMAGES${N}
    ${GREEN}pimg${N}           ${GRAY}List images${N}
    ${GREEN}ppull${N} <img>    ${GRAY}Pull an image${N}
    ${GREEN}pbuild${N}         ${GRAY}Build an image${N}
    ${GREEN}prmi${N} <img>     ${GRAY}Remove an image${N}
    ${GREEN}prmif${N}          ${GRAY}Remove an image (fzf)${N}
    ${GREEN}psave${N} <img>    ${GRAY}Save image to .tar${N}
    ${GREEN}pload${N} <file>   ${GRAY}Load image from .tar${N}

  ${YELLOW}${B}LOGS & MONITORING${N}
    ${GREEN}plogs${N} <c>      ${GRAY}Container logs${N}
    ${GREEN}plogsf${N} <c>     ${GRAY}Real-time logs${N}
    ${GREEN}plogf${N}          ${GRAY}Real-time logs (fzf)${N}
    ${GREEN}pstats${N}         ${GRAY}Live resource stats${N}
    ${GREEN}pstatus${N}        ${GRAY}Full overview${N}

  ${YELLOW}${B}COMPOSE${N}
    ${GREEN}pc${N}             ${GRAY}podman-compose${N}
    ${GREEN}pcup${N}           ${GRAY}Start services${N}
    ${GREEN}pcdown${N}         ${GRAY}Stop services${N}
    ${GREEN}pclogs${N}         ${GRAY}Service logs${N}

  ${YELLOW}${B}CLEANUP${N}
    ${GREEN}pprune${N}         ${GRAY}Clean unused resources${N}
    ${GREEN}ppruneall${N}      ${GRAY}Full cleanup (images, vol, etc.)${N}
    ${GREEN}pcleanall${N}      ${GRAY}Stop + full removal${N}

  ${MAGENTA}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}
"
}
