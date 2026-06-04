#!/data/data/com.termux/files/usr/bin/bash
echo "🕉️ Installing Divine Earthly AI..."
echo ""

BASE_DIR="$HOME/.divine_earthly"
mkdir -p "$BASE_DIR"/{models,knowledge,scripts,bin}

# Copy all files
cp -r scripts/* "$BASE_DIR/scripts/"
cp -r bin/* "$BASE_DIR/bin/"
cp -r knowledge/* "$BASE_DIR/knowledge/"

# Setup aliases
cat >> ~/.bashrc << 'ALIASES'
# Divine Earthly AI
alias divine="$HOME/.divine_earthly/scripts/divine"
alias vedic="$HOME/.divine_earthly/scripts/vedic_ai.sh"
alias swarm="$HOME/.divine_earthly/scripts/swarm"
alias vqs="$HOME/.divine_earthly/scripts/vqs"
alias v="$HOME/.divine_earthly/scripts/v"
alias scan="$HOME/.divine_earthly/scripts/vqs scan"
echo "🕉️ Divine Earthly AI Ready!"
ALIASES

source ~/.bashrc

echo ""
echo "✅ Installation complete!"
echo ""
echo "Quick start:"
echo "  divine update   - Update system"
echo "  divine install smollm2 - Install fast model"
echo "  swarm 'query'   - Ask anything"
echo "  vqs 'problem'   - Solve any problem"
echo "  scan            - World problem scanner"
