#!/data/data/com.termux/files/usr/bin/bash
# ╔═══════════════════════════════════════════════════════════╗
# ║  DIVINE EARTHLY - One Line Installer                     ║
# ║  curl -L URL | bash                                     ║
# ╚═══════════════════════════════════════════════════════════╝

echo ""
echo "🕉️  DIVINE EARTHLY AI INSTALLER"
echo "================================="
echo ""

# Check Termux
if [ ! -d "/data/data/com.termux" ]; then
    echo "❌ This app requires Termux. Install from F-Droid."
    exit 1
fi

# Install dependencies
echo "📦 Installing dependencies..."
pkg update -y > /dev/null 2>&1
pkg install -y wget curl tar > /dev/null 2>&1

# Setup directories
BASE_DIR="$HOME/.divine_earthly"
mkdir -p "$BASE_DIR"/{models,knowledge,scripts,bin}

# Download latest release
VERSION=$(curl -s https://raw.githubusercontent.com/divineearthly/divineearthly/main/version.txt)
echo "📥 Downloading Divine Earthly v$VERSION..."

curl -L "https://github.com/divineearthly/divineearthly/releases/download/v${VERSION}/divine-earthly-ai-v${VERSION}-arm64.tar.gz" -o /tmp/divine.tar.gz

# Extract
tar -xzf /tmp/divine.tar.gz -C "$BASE_DIR/"
rm /tmp/divine.tar.gz

# Setup environment
cat >> ~/.bashrc << 'EOF'

# 🕉️ Divine Earthly AI
export DIVINE_HOME="$HOME/.divine_earthly"
export PATH="$DIVINE_HOME/bin:$DIVINE_HOME/scripts:$PATH"
alias divine="$DIVINE_HOME/scripts/divine"
alias swarm="$DIVINE_HOME/scripts/swarm"
alias vqs="$DIVINE_HOME/scripts/vqs"
alias v="$DIVINE_HOME/scripts/v"
alias scan="vqs scan"
echo "🕉️ Divine Earthly AI Ready!"
EOF

source ~/.bashrc

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║  ✅ DIVINE EARTHLY INSTALLED!           ║"
echo "╠══════════════════════════════════════════╣"
echo "║                                        ║"
echo "║  Next steps:                           ║"
echo "║    divine update   - Update system     ║"
echo "║    divine install smollm2 - Get model  ║"
echo "║    swarm 'hello'   - Test AI           ║"
echo "║                                        ║"
echo "╚══════════════════════════════════════════╝"
echo ""
echo "🕉️ ॐ - May wisdom guide your path"
