#!/bin/bash

# ==========================================
# Captive Portal Auto-Login Script
# ==========================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="$SCRIPT_DIR/.env"

if [ ! -f "$ENV_FILE" ]; then
    notify-send "Rajagiri Network" "Missing .env file at $ENV_FILE"
    exit 1
fi

source "$ENV_FILE"

# Override from arguments if provided
[ -n "$1" ] && USERNAME="$1"
[ -n "$2" ] && PASSWORD="$2"

urlencode() {
    local string="${1}"
    local strlen=${#string}
    local encoded=""
    local pos c o

    for (( pos=0 ; pos<strlen ; pos++ )); do
        c=${string:$pos:1}
        case "$c" in
            [-_.~a-zA-Z0-9] ) o="${c}" ;;
            * )               printf -v o '%%%02x' "'$c" ;;
        esac
        encoded+="${o}"
    done
    echo "${encoded}"
}

notify-send "Rajagiri Network" "Trying to login as $USERNAME..."
echo "Attempting login as $USERNAME..."

TIMESTAMP=$(date +%s%3N)
ENC_USER=$(urlencode "$USERNAME")
ENC_PASS=$(urlencode "$PASSWORD")

PAYLOAD="mode=191&username=${ENC_USER}&password=${ENC_PASS}&a=${TIMESTAMP}&producttype=0"

sleep 1

RESPONSE=$(curl -s -X POST "http://172.16.0.20:8090/login.xml" \
     -H "Content-Type: application/x-www-form-urlencoded" \
     -d "$PAYLOAD" --connect-timeout 10)

if [ $? -ne 0 ]; then
    notify-send "Rajagiri Network" "Login failed: Could not connect to portal"
    echo "Connection failed"
    exit 1
fi

if echo "$RESPONSE" | grep -qE '<status>.*LIVE.*</status>'; then
    notify-send "Rajagiri Network" "Logged in successfully as $USERNAME"
    echo "Successfully logged in."
    exit 0
elif echo "$RESPONSE" | grep -qE '<status>.*LOGIN.*</status>' || echo "$RESPONSE" | grep -qE '<status>.*REJECTED.*</status>'; then
    MESSAGE=$(echo "$RESPONSE" | grep -oP '(?<=<!\[CDATA\[).*?(?=\]\]>)' 2>/dev/null)
    [ -z "$MESSAGE" ] && MESSAGE=$(echo "$RESPONSE" | grep -oP '(?<=<message>).*?(?=</message>)' 2>/dev/null)
    [ -z "$MESSAGE" ] && MESSAGE="Invalid credentials or login rejected"

    notify-send "Rajagiri Network" "Login failed: $MESSAGE"
    echo "Login failed: $MESSAGE"
    exit 1
else
    notify-send "Rajagiri Network" "Login failed: Unexpected response from portal"
    echo "Login failed: Unexpected response"
    echo "$RESPONSE"
    exit 1
fi
