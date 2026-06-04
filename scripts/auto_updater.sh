#!/data/data/com.termux/files/usr/bin/bash
# ╔═══════════════════════════════════════════════════════════╗
# ║  DIVINE EARTHLY - Auto Update System                     ║
# ║  Updates models, knowledge base, and core scripts        ║
# ╚═══════════════════════════════════════════════════════════╝

GITHUB_REPO="https://raw.githubusercontent.com/divineearthly/divineearthly/main"
BASE_DIR="$HOME/.divine_earthly"
MODEL_DIR="$BASE_DIR/models"
KB_DIR="$BASE_DIR/knowledge"
SCRIPT_DIR="$BASE_DIR/scripts"
VERSION_FILE="$BASE_DIR/version.txt"

mkdir -p "$MODEL_DIR" "$KB_DIR" "$SCRIPT_DIR"

# Check internet
check_net() {
    ping -c 1 github.com > /dev/null 2>&1 && return 0 || return 1
}

# Get latest version from GitHub
get_latest_version() {
    curl -s "$GITHUB_REPO/version.txt" 2>/dev/null || echo "0"
}

# Get current version
get_current_version() {
    cat "$VERSION_FILE" 2>/dev/null || echo "0"
}

# Download with progress
download_file() {
    local url="$1"
    local dest="$2"
    local name="$3"
    echo "📥 Downloading $name..."
    curl -L --progress-bar "$url" -o "$dest" 2>&1
    echo "✅ $name updated"
}

# Update models
update_models() {
    echo "🧠 Checking model updates..."
    
    # Available models list
    declare -A MODELS=(
        ["smollm2-135m-q4_k_m.gguf"]="100MB|Tier 1: Instant responses"
        ["qwen2.5-0.5b-instruct-q4_k_m.gguf"]="469MB|Tier 2: Deep Vedic"
        ["llama-3.2-1b-instruct-q4_k_m.gguf"]="700MB|Tier 3: Multilingual"
    )
    
    for model in "${!MODELS[@]}"; do
        local info="${MODELS[$model]}"
        local size="${info%%|*}"
        local desc="${info##*|}"
        
        if [ ! -f "$MODEL_DIR/$model" ]; then
            echo "   $desc ($size) - Not installed"
            echo "   To download: divine install $model"
        else
            echo "   ✅ $desc - Installed"
        fi
    done
}

# Update knowledge base
update_knowledge() {
    echo "📚 Syncing Vedic Knowledge Base..."
    
    local kb_files=(
        "vedic_core.txt"
        "krishi_veda.txt"
        "ayurveda.txt"
        "vedic_math.txt"
        "kavach_security.txt"
        "quantum_vedic.txt"
    )
    
    for kb in "${kb_files[@]}"; do
        download_file "$GITHUB_REPO/knowledge/$kb" "$KB_DIR/$kb" "$kb"
    done
}

# Update scripts
update_scripts() {
    echo "🔧 Updating core scripts..."
    
    local scripts=(
        "vedic_ai.sh"
        "vedic_quantum_solver.sh"
        "vedic_multi_agent.sh"
        "vedic_security_layer.sh"
        "vedic_dashboard.sh"
    )
    
    for script in "${scripts[@]}"; do
        download_file "$GITHUB_REPO/scripts/$script" "$SCRIPT_DIR/$script" "$script"
        chmod +x "$SCRIPT_DIR/$script"
    done
}

# Main update
do_update() {
    echo "╔══════════════════════════════════════════╗"
    echo "║  🕉️  DIVINE EARTHLY - AUTO UPDATER  🕉️  ║"
    echo "╚══════════════════════════════════════════╝"
    echo ""
    
    if ! check_net; then
        echo "❌ No internet connection"
        return 1
    fi
    
    local current=$(get_current_version)
    local latest=$(get_latest_version)
    
    echo "Current: v$current | Latest: v$latest"
    echo ""
    
    if [ "$latest" != "$current" ]; then
        update_scripts
        update_knowledge
        update_models
        echo "$latest" > "$VERSION_FILE"
        echo ""
        echo "✅ Updated to v$latest"
    else
        echo "✅ Already up to date!"
    fi
}

# Install specific model
install_model() {
    local model="$1"
    local url=""
    
    case "$model" in
        smollm2*|135m)
            url="https://huggingface.co/bartowski/SmolLM2-135M-Instruct-GGUF/resolve/main/SmolLM2-135M-Instruct-Q4_K_M.gguf"
            dest="$MODEL_DIR/smollm2-135m-q4_k_m.gguf"
            ;;
        qwen*|0.5b)
            url="https://huggingface.co/bartowski/Qwen2.5-0.5B-Instruct-GGUF/resolve/main/Qwen2.5-0.5B-Instruct-Q4_K_M.gguf"
            dest="$MODEL_DIR/qwen2.5-0.5b-instruct-q4_k_m.gguf"
            ;;
        llama*|1b)
            url="https://huggingface.co/bartowski/Llama-3.2-1B-Instruct-GGUF/resolve/main/Llama-3.2-1B-Instruct-Q4_K_M.gguf"
            dest="$MODEL_DIR/llama-3.2-1b-instruct-q4_k_m.gguf"
            ;;
        *)
            echo "Unknown model: $model"
            echo "Available: smollm2, qwen, llama"
            return 1
            ;;
    esac
    
    echo "📥 Installing $model..."
    curl -L --progress-bar "$url" -o "$dest"
    echo "✅ Installed!"
}

# Command handler
case "${1:-update}" in
    update)
        do_update
        ;;
    install)
        install_model "$2"
        ;;
    list)
        echo "📦 Available Models:"
        echo "  smollm2  - SmolLM2-135M (100MB) - Fast tier"
        echo "  qwen     - Qwen2.5-0.5B (469MB) - Deep tier"
        echo "  llama    - Llama-3.2-1B (700MB) - Multi-tier"
        echo ""
        echo "📚 Knowledge Bases:"
        ls -la "$KB_DIR/" 2>/dev/null
        ;;
    status)
        echo "🕉️ Divine Earthly Status:"
        echo "  Version: $(get_current_version)"
        echo "  Models: $(ls $MODEL_DIR/*.gguf 2>/dev/null | wc -l) installed"
        echo "  Knowledge: $(ls $KB_DIR/*.txt 2>/dev/null | wc -l) files"
        echo "  Scripts: $(ls $SCRIPT_DIR/*.sh 2>/dev/null | wc -l) scripts"
        ;;
    *)
        echo "Divine Earthly Updater"
        echo "Usage: divine {update|install|list|status}"
        ;;
esac
