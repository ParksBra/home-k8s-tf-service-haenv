#!/bin/bash
usage() {
    echo "Usage: $0 <unhashed_password> <optional_salt>" >&2
    exit 1
}

if [ "$#" -lt 1 ]; then
    usage
fi

PASSWORD="$1"
SALT="$2"

ITERATIONS=101
GENERATE_SALT_LENGTH=12

# If no salt is provided, generate a random alphanumeric string.
if [ -z "$SALT" ]; then
    SALT=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w $GENERATE_SALT_LENGTH | head -n 1)
fi

SALT_ENCODED=$(echo -n "$SALT" | base64 -w0 | sed 's/=*$//')

to_hex() {
    printf "%s" "$1" | od -A n -t x1 | tr -d ' \n'
}

PASSWORD_HEX=$(to_hex "$PASSWORD")
SALT_HEX=$(to_hex "$SALT")

B64_HASH=$(openssl kdf -keylen 64 -kdfopt digest:SHA512 \
                    -kdfopt hexpass:$PASSWORD_HEX \
                    -kdfopt hexsalt:$SALT_HEX \
                    -kdfopt iter:$ITERATIONS \
                    -binary PBKDF2 | base64 -w0)

B64_HASH="${B64_HASH%%=*}"
B64_HASH="${B64_HASH}=="

printf '{"hashed_password": "%s"}' "\$7\$${ITERATIONS}\$${SALT_ENCODED}\$${B64_HASH}"
