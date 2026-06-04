#!/data/data/com.termux/files/usr/bin/bash
# ╔═══════════════════════════════════════════════════════════╗
# ║  DIVINE EARTHLY - APK Builder                            ║
# ║  Packages entire Vedic AI system into installable APK    ║
# ╚═══════════════════════════════════════════════════════════╝

APK_NAME="divine-earthly-ai"
VERSION="1.0.0"
OUTPUT_DIR="$HOME/divine-earthly-apk/output"
WORK_DIR="$HOME/divine-earthly-apk/build"

echo "🕉️ Building Divine Earthly APK v$VERSION"
echo "=========================================="

# Clean build
rm -rf "$WORK_DIR" "$OUTPUT_DIR"
mkdir -p "$WORK_DIR" "$OUTPUT_DIR"

# Step 1: Package Termux bootstrap
echo "📦 Step 1: Packaging Termux bootstrap..."
pkg install termux-app -y 2>/dev/null

# Step 2: Copy all Vedic scripts
echo "📜 Step 2: Bundling Vedic scripts..."
mkdir -p "$WORK_DIR/scripts"
cp ~/vedic_multi_agent.sh "$WORK_DIR/scripts/"
cp ~/vedic_quantum_solver.sh "$WORK_DIR/scripts/"
cp ~/vedic_security_layer.sh "$WORK_DIR/scripts/"
cp ~/vedic_dashboard.sh "$WORK_DIR/scripts/"
cp ~/vedic_rag_live.sh "$WORK_DIR/scripts/"
cp ~/swarm "$WORK_DIR/scripts/"
cp ~/v "$WORK_DIR/scripts/"
cp ~/vqs "$WORK_DIR/scripts/"
cp ~/divine-earthly-apk/scripts/auto_updater.sh "$WORK_DIR/scripts/divine"

# Step 3: Bundle llama.cpp binaries
echo "🔧 Step 3: Bundling llama.cpp..."
mkdir -p "$WORK_DIR/bin"
cp ~/llama.cpp/build_vedic/bin/llama-cli "$WORK_DIR/bin/"
cp ~/llama.cpp/build_vedic/bin/llama-quantize "$WORK_DIR/bin/"
cp ~/llama.cpp/build_vedic/bin/libggml.so "$WORK_DIR/bin/"
cp ~/llama.cpp/build_vedic/bin/libllama.so "$WORK_DIR/bin/"
cp ~/llama.cpp/build_vedic/bin/libggml-base.so "$WORK_DIR/bin/"
cp ~/llama.cpp/build_vedic/bin/libggml-cpu.so "$WORK_DIR/bin/"
cp ~/llama.cpp/build_vedic/bin/libggml-blas.so "$WORK_DIR/bin/"

# Step 4: Create knowledge base
echo "📚 Step 4: Creating knowledge base..."
mkdir -p "$WORK_DIR/knowledge"
cp ~/llama.cpp/vedic_training_data.txt "$WORK_DIR/knowledge/vedic_core.txt" 2>/dev/null
cp ~/vedic_knowledge/*.txt "$WORK_DIR/knowledge/" 2>/dev/null

# Step 5: Create installer script
echo "📝 Step 5: Creating installer..."
cat > "$WORK_DIR/install.sh" << 'INSTALL'
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
INSTALL
chmod +x "$WORK_DIR/install.sh"

# Step 6: Create version file
echo "$VERSION" > "$WORK_DIR/version.txt"

# Step 7: Package everything
echo "📦 Step 6: Creating APK package..."
cd "$WORK_DIR"
tar -czf "$OUTPUT_DIR/${APK_NAME}-v${VERSION}-arm64.tar.gz" .

# Step 8: Generate manifest
cat > "$OUTPUT_DIR/manifest.json" << MANIFEST
{
    "name": "Divine Earthly AI",
    "version": "$VERSION",
    "description": "Vedic-Quantum Autonomous AI for Edge Devices",
    "architecture": "arm64-v8a",
    "min_android": "7.0",
    "size": "$(du -sh $OUTPUT_DIR/${APK_NAME}-v${VERSION}-arm64.tar.gz | cut -f1)",
    "features": [
        "Two-Tier AI (135M + 0.5B models)",
        "8 Deva Agent Swarm",
        "Vedic-Quantum Solver",
        "Sutra-Based Encryption",
        "Autonomous World Scanner",
        "Offline Operation"
    ],
    "models_available": {
        "smollm2-135m": "100MB - Instant tier (50-95 t/s)",
        "qwen2.5-0.5b": "469MB - Deep Vedic tier (15-30 t/s)",
        "llama-3.2-1b": "700MB - Multilingual tier"
    },
    "install_command": "curl -L https://github.com/divineearthly/divineearthly/releases/download/v${VERSION}/divine-earthly-ai-v${VERSION}-arm64.tar.gz | tar -xz && bash install.sh",
    "github_repo": "https://github.com/divineearthly/divineearthly"
}
MANIFEST

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║  ✅ APK BUILD COMPLETE!                 ║"
echo "╠══════════════════════════════════════════╣"
echo "║  Output: $OUTPUT_DIR/${APK_NAME}-v${VERSION}-arm64.tar.gz"
echo "║  Size: $(du -sh $OUTPUT_DIR/${APK_NAME}-v${VERSION}-arm64.tar.gz | cut -f1)"
echo "╚══════════════════════════════════════════╝"
echo ""
echo "Next steps:"
echo "  1. Upload to GitHub Releases"
echo "  2. Share: curl -L URL | tar -xz && bash install.sh"
echo "  3. Users run: divine update"
