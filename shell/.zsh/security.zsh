# Security and encryption utilities
# GPG encryption, decryption, and security-related functions

# ===== GPG Encryption Functions =====

# Encrypt files/directories with GPG
# Usage: encr <source_file_or_dir> <output_name>
encr() {
  if [[ $# -ne 2 ]]; then
    echo "Usage: encr <source> <output_name>" >&2
    return 1
  fi

  local source="$1"
  local output="$2"

  tar czf "${output}.tar.gz" "$source" || { echo "tar failed" >&2; return 1; }
  if ! gpg -er "${GPG_DEFAULT_RECIPIENT:-$(git config user.email)}" "${output}.tar.gz"; then
    echo "gpg encryption failed" >&2
    rm -f "${output}.tar.gz"
    return 1
  fi
  rm -f "${output}.tar.gz"
}

# Decrypt GPG files
# Usage: decr <encrypted_file>
decr() {
  if [[ $# -ne 1 ]]; then
    echo "Usage: decr <encrypted_file>" >&2
    return 1
  fi

  local tmpfile="decrypted_$$.tar.gz"
  gpg -do "$tmpfile" "$1" || { echo "gpg decryption failed" >&2; return 1; }
  tar xvf "$tmpfile" || { echo "tar extraction failed" >&2; rm -f "$tmpfile"; return 1; }
  rm -f "$tmpfile"
}
