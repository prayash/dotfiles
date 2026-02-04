#!/bin/zsh
# Run sudo ln -sf ~/Developer/dotfiles/x /usr/local/bin/x to setup.

# Colors
readonly RED=$'\033[0;31m'
readonly GREEN=$'\033[0;32m'
readonly YELLOW=$'\033[0;33m'
readonly BLUE=$'\033[0;34m'
readonly CYAN=$'\033[0;36m'
readonly BOLD=$'\033[1m'
readonly RESET=$'\033[0m'
# Get Xcode path
XCODE_PATH="${$(xcode-select -p)%/Contents/Developer}"
# Collect all openable items
typeset -a items
items=( *.xcworkspace(N) *.xcodeproj(N) *.playground(N) )
# Add current directory if Package.swift exists
[[ -f "Package.swift" ]] && items+=( "." )
# Handle results
case ${#items[@]} in
  0)
    echo "${RED}✗${RESET} No Xcode workspaces, projects, playgrounds, or packages found."
    exit 1
    ;;
  1)
    echo "${GREEN}✓${RESET} Opening ${CYAN}${items[1]}${RESET}"
    open -a "$XCODE_PATH" "${items[1]}"
    ;;
  *)
    echo "${BLUE}${BOLD}Multiple Xcode items found:${RESET}\n"
    for i in {1..${#items[@]}}; do
      item="${items[$i]}"
      if [[ "$item" == "." ]]; then
        echo "  ${YELLOW}$i)${RESET} ${CYAN}Package.swift${RESET} ${BOLD}(Swift Package)${RESET}"
      elif [[ "$item" == *.xcworkspace ]]; then
        echo "  ${YELLOW}$i)${RESET} ${GREEN}$item${RESET}"
      elif [[ "$item" == *.xcodeproj ]]; then
        echo "  ${YELLOW}$i)${RESET} ${BLUE}$item${RESET}"
      elif [[ "$item" == *.playground ]]; then
        echo "  ${YELLOW}$i)${RESET} ${CYAN}$item${RESET}"
      fi
    done
    echo ""
    echo -n "${BOLD}Select an item (1-${#items[@]}):${RESET} "
    read choice
    if [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice <= ${#items[@]} )); then
      echo "${GREEN}✓${RESET} Opening ${CYAN}${items[$choice]}${RESET}"
      open -a "$XCODE_PATH" "${items[$choice]}"
    else
      echo "${RED}✗${RESET} Invalid selection."
      exit 1
    fi
    ;;
esac