#!/data/data/com.termux/files/usr/bin/bash
MODEL="$HOME/llama.cpp/sovereign-mini.gguf"
BIN="$HOME/llama.cpp/build_vedic/bin/llama-cli"
KB_DIR="$HOME/vedic_knowledge"
mkdir -p "$KB_DIR"

# Create knowledge base if not exists
[ -f "$KB_DIR/om.txt" ] || cat > "$KB_DIR/om.txt" << 'K'
Om (ॐ) is the primordial sound in Vedic tradition. It represents 
three states: waking (A), dreaming (U), deep sleep (M). It is 
Brahman, the ultimate reality, essence of all Vedas.
K

[ -f "$KB_DIR/kavach.txt" ] || cat > "$KB_DIR/kavach.txt" << 'K'
Kavach (कवच) is a Vedic protective armor invoked through mantras.
It creates a spiritual shield around the practitioner.
K

[ -f "$KB_DIR/farming.txt" ] || cat > "$KB_DIR/farming.txt" << 'K'
Krishi Veda: Panchagavya (5 cow products), Agnihotra ash for 
pest control, lunar planting cycles, Ahimsa towards all beings.
K

vedic_search() {
    local q="$1"
    local found=""
    for f in "$KB_DIR"/*.txt; do
        if grep -qi "$q" "$f" 2>/dev/null; then
            found="$found$(cat "$f")\n"
        fi
    done
    echo -e "$found"
}

rag_query() {
    local q="$1"
    local ctx=$(vedic_search "$q")
    if [ -n "$ctx" ]; then
        $BIN -m "$MODEL" \
            -p "Vedic Reference:\n$ctx\n\nQuestion: $q\nAnswer:" \
            -n 250 --temp 0.7 --threads 2 --no-display-prompt 2>/dev/null
    else
        ~/v phil "$q"
    fi
}

# Main
echo "🕉️ Vedic RAG Live (type 'exit' to quit)"
while true; do
    echo -ne "\n📿 Query: "
    read -r q
    [ "$q" = "exit" ] && break
    [ -n "$q" ] && rag_query "$q"
done
