# Security and encryption utilities
# GPG encryption, decryption, and security-related functions

# ===== GPG Encryption Functions =====

# Encrypt files with GPG
# Usage: encr <source_file_or_dir> <output_name>
encr() {
  tar czf "$2".tar.gz $1
  gpg -er "${GPG_DEFAULT_RECIPIENT:-$(git config user.email)}" "$2".tar.gz
  rm -f "$2".tar.gz
}

# Decrypt GPG files
# Usage: decr <encrypted_file>
decr() {
  gpg -do decrypted.tar.gz $1
  tar xvf decrypted.tar.gz
  rm -f decrypted.tar.gz
}