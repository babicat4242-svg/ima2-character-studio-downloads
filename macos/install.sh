#!/bin/bash
set -euo pipefail

# This installer adapts the official release locally. It does not redistribute app code.
version=0.1.4
expected=01ff5632af868c976d0d667e1e3622c9815e3462945f5c4e29cd329d9bbc5c2f
url="https://github.com/babicat4242-svg/ima2-character-studio-downloads/releases/download/v${version}/HERA-Character-${version}-Setup.exe"
destination="$HOME/Applications/HERA-Character-Mac"

[[ "$(uname -s)" == Darwin ]] || { echo 'macOS is required.' >&2; exit 1; }
for tool in node npm codex curl shasum bsdtar; do
  command -v "$tool" >/dev/null || { echo "Missing prerequisite: $tool" >&2; exit 1; }
done
node -e 'if (Number(process.versions.node.split(".")[0]) < 22) process.exit(1)' || { echo 'Node.js 22 or later is required.' >&2; exit 1; }
[[ ! -e "$destination" ]] || { echo "Already exists: $destination; move it before installing." >&2; exit 1; }

temp_dir=$(mktemp -d "${TMPDIR:-/tmp}/hera-install.XXXXXXXX")
trap 'rm -rf "$temp_dir"' EXIT
archive="$temp_dir/setup.exe"
curl --fail --location --retry 3 --output "$archive" "$url"
actual=$(shasum -a 256 "$archive" | awk '{print $1}')
[[ "$actual" == "$expected" ]] || { echo 'Installer checksum mismatch.' >&2; exit 1; }
bsdtar -xf "$archive" -C "$temp_dir" resources/app.asar

app_dir="$temp_dir/app"
mkdir "$app_dir"
node "$(dirname "$0")/unpack.cjs" "$temp_dir/resources/app.asar" "$app_dir" "$(command -v codex)"
npm install --prefix "$app_dir" --save-exact electron@45.3.3 sharp@0.35.5
node "$app_dir/node_modules/electron/install.js"
mkdir -p "$HOME/Applications"
mv "$app_dir" "$destination"
cat > "$destination/HERA 시작.command" <<'EOF'
#!/bin/bash
app_dir="$HOME/Applications/HERA-Character-Mac"
open -a "$app_dir/node_modules/electron/dist/Electron.app" --args "$app_dir"
EOF
chmod +x "$destination/HERA 시작.command"
echo "Installed. Open $destination/HERA 시작.command to launch HERA."
