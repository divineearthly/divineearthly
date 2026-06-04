#!/data/data/com.termux/files/usr/bin/bash
# ╔═══════════════════════════════════════════════════════════╗
# ║  🕉️ DIVINE EARTHLY - One Line Installer 🕉️              ║
# ║  curl -L bit.ly/divine-earthly | bash                    ║
# ╚═══════════════════════════════════════════════════════════╝

clear
echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║     🕉️  DIVINE EARTHLY AI  🕉️                    ║"
echo "║     Vedic-Quantum Autonomous System              ║"
echo "╚══════════════════════════════════════════════════╝"
echo ""

# Check Termux
if [ ! -d "/data/data/com.termux" ]; then
    echo "❌ Install Termux first: https://f-droid.org/packages/com.termux/"
    exit 1
fi

# Install dependencies
echo "📦 Installing dependencies..."
pkg update -y -q
pkg install -y wget curl tar git -q

# Setup
BASE_DIR="$HOME/.divine_earthly"
mkdir -p "$BASE_DIR"/{models,knowledge,scripts,bin}
VERSION="1.0.0"
REPO="https://raw.githubusercontent.com/divineearthly/divineearthly/main"

# Download scripts
echo "📥 Downloading core system..."
curl -sL "$REPO/scripts/auto_updater.sh" -o "$BASE_DIR/scripts/divine"
curl -sL "$REPO/build/scripts/swarm" -o "$BASE_DIR/scripts/swarm"
curl -sL "$REPO/build/scripts/v" -o "$BASE_DIR/scripts/v"
curl -sL "$REPO/build/scripts/vqs" -o "$BASE_DIR/scripts/vqs"
curl -sL "$REPO/build/scripts/vedic_multi_agent.sh" -o "$BASE_DIR/scripts/vedic_multi_agent.sh"
curl -sL "$REPO/build/scripts/vedic_quantum_solver.sh" -o "$BASE_DIR/scripts/vedic_quantum_solver.sh"
curl -sL "$REPO/build/scripts/vedic_dashboard.sh" -o "$BASE_DIR/scripts/vedic_dashboard.sh"
curl -sL "$REPO/build/scripts/vedic_security_layer.sh" -o "$BASE_DIR/scripts/vedic_security_layer.sh"
chmod +x "$BASE_DIR"/scripts/*

# Download knowledge base
echo "📚 Downloading Vedic knowledge..."
curl -sL "$REPO/build/knowledge/om.txt" -o "$BASE_DIR/knowledge/om.txt"
curl -sL "$REPO/build/knowledge/kavach.txt" -o "$BASE_DIR/knowledge/kavach.txt"
curl -sL "$REPO/build/knowledge/farming.txt" -o "$BASE_DIR/knowledge/farming.txt"
curl -sL "$REPO/build/knowledge/elements.txt" -o "$BASE_DIR/knowledge/elements.txt"

# Check for llama.cpp binaries
if [ ! -f "$BASE_DIR/bin/llama-cli" ]; then
    echo ""
    echo "⚠️ llama.cpp not found."
    echo "   Install llama.cpp first, then copy binaries to:"
    echo "   $BASE_DIR/bin/"
    echo ""
    echo "   Or run: pkg install llama.cpp"
fi

# Setup environment
if ! grep -q "divine_earthly" ~/.bashrc 2>/dev/null; then
    cat >> ~/.bashrc << 'EOF'

# 🕉️ Divine Earthly AI
export DIVINE_HOME="$HOME/.divine_earthly"
export PATH="$DIVINE_HOME/bin:$DIVINE_HOME/scripts:$PATH"
alias divine="$DIVINE_HOME/scripts/divine"
alias swarm="$DIVINE_HOME/scripts/swarm"
alias vqs="$DIVINE_HOME/scripts/vqs"
alias v="$DIVINE_HOME/scripts/v"
alias scan="vqs scan"
EOF
fi

echo "1.0.0" > "$BASE_DIR/version.txt"

echo ""
echo "╔══════════════════════════════════════════════╗"
echo "║  ✅ DIVINE EARTHLY INSTALLED!               ║"
echo "╠══════════════════════════════════════════════╣"
echo "║                                            ║"
echo "║  Quick Start:                              ║"
echo "║    source ~/.bashrc                        ║"
echo "║    divine install smollm2                  ║"
echo "║    swarm 'Hello, Vedic AI!'                ║"
echo "║    vqs 'How to achieve world peace?'       ║"
echo "║    scan                                    ║"
echo "║                                            ║"
echo "║  Commands:                                 ║"
echo "║    swarm  - Two-tier AI query              ║"
echo "║    vqs    - Vedic-Quantum problem solver   ║"
echo "║    v      - Vedic AI (farm/phil/kavach)    ║"
echo "║    scan   - Autonomous world scanner        ║"
echo "║    divine - Update/install models          ║"
echo "║                                            ║"
echo "╚══════════════════════════════════════════════╝"
echo ""
echo "🕉️ ॐ - May wisdom guide your path"
