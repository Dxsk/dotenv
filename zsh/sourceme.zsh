# Auto-load/unload sourceme files
# Sources a 'sourceme' file when entering a directory,
# keeps it active in child directories,
# and unloads it when leaving the project tree.

typeset -g _SOURCEME_ROOT=""
typeset -g _SOURCEME_FILE=""
typeset -g _SOURCEME_VARS=()
typeset -g _SOURCEME_SNAPSHOT=""

_sourceme_snapshot() {
  env | sort
}

_sourceme_check() {
  local dir="$PWD"

  # If we're inside the current sourceme project, do nothing
  if [[ -n "$_SOURCEME_ROOT" && "$PWD" == "$_SOURCEME_ROOT"* ]]; then
    return
  fi

  # We left the project tree - unsource
  if [[ -n "$_SOURCEME_ROOT" ]]; then
    _sourceme_unload
  fi

  # Walk up to find a sourceme file (prefer .zsh, then .bash, then plain)
  while [[ "$dir" != "/" ]]; do
    for f in "$dir/sourceme.zsh" "$dir/sourceme.bash" "$dir/sourceme"; do
      if [[ -f "$f" ]]; then
        _sourceme_load "$dir" "$f"
        return
      fi
    done
    dir="${dir:h}"
  done
}

_sourceme_load() {
  local root="$1"
  local file="$2"
  _SOURCEME_ROOT="$root"
  _SOURCEME_FILE="$file"
  _SOURCEME_SNAPSHOT="$(_sourceme_snapshot)"
  source "$file"
  echo "\033[0;33m[sourceme]\033[0m loaded from $file"
}

_sourceme_unload() {
  if [[ -z "$_SOURCEME_SNAPSHOT" ]]; then
    _SOURCEME_ROOT=""
    return
  fi

  # Diff env to find new/changed vars and unset them
  local current="$(_sourceme_snapshot)"
  local new_vars
  new_vars=(${(f)"$(comm -13 <(echo "$_SOURCEME_SNAPSHOT") <(echo "$current") | cut -d= -f1)"})

  for var in $new_vars; do
    [[ "$var" == "_SOURCEME_"* || "$var" == "OLDPWD" || "$var" == "PWD" ]] && continue
    unset "$var" 2>/dev/null
  done

  echo "\033[0;33m[sourceme]\033[0m unloaded from $_SOURCEME_FILE"
  _SOURCEME_ROOT=""
  _SOURCEME_FILE=""
  _SOURCEME_SNAPSHOT=""
}

autoload -Uz add-zsh-hook
add-zsh-hook chpwd _sourceme_check

# Check on shell startup too
_sourceme_check
