#pylint: skip-file
# Based on: https://shantanoo-desai.github.io/posts/technology/mosquitto_ansible_passgen
import sys
import json
import passlib.hash # type: ignore

SALT_SIZE = 12
ITERATIONS = 101

def mosquitto_passwd(passwd: str, salt: str = "") -> str:
    """Hash a password for Mosquitto using PBKDF2-SHA512.

    Args:
        passwd (str): The plaintext password to hash.

    Returns:
        str: The hashed password string.
    """
    hasher_args = {"rounds": ITERATIONS}
    if salt:
        salt_bytes = str(salt).encode("utf-8")
        hasher_args["salt"] = salt_bytes # type: ignore
        hasher_args["salt_size"] = len(salt_bytes)
    else:
        hasher_args["salt_size"] = SALT_SIZE
    hasher = passlib.hash.pbkdf2_sha512.using(**hasher_args)
    digest = hasher.hash(passwd)
    digest = digest.replace("pbkdf2-sha512", "7")
    digest = digest.replace(".", "+")
    digest = digest + "=="

    return digest

def main():
    """Main function to hash a password provided as a command-line argument."""
    if len(sys.argv) < 2:
        print(f"Usage: python3 {sys.argv[0]} <unhashed_password> <optional_salt>", file=sys.stderr)
        sys.exit(1)

    unhashed_password = sys.argv[1]
    salt = sys.argv[2] if len(sys.argv) > 2 else ""

    json_output = json.dumps({"hashed_password": mosquitto_passwd(unhashed_password, salt)})

    print(json_output, file=sys.stdout, end="")

if __name__ == "__main__":
    main()
