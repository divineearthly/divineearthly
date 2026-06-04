#!/data/data/com.termux/files/usr/bin/bash
# ╔═══════════════════════════════════════════════════════════╗
# ║  🕉️  VEDIC SWARM - Simplified Multi-Agent System  🕉️    ║
# ╚═══════════════════════════════════════════════════════════╝

MODEL="$HOME/llama.cpp/sovereign-mini.gguf"
BIN="$HOME/llama.cpp/build_vedic/bin/llama-cli"

# Simple keyword-based routing (no LLM needed for classification)
route_query() {
    local q=$(echo "$1" | tr '[:upper:]' '[:lower:]')
    if echo "$q" | grep -qE "farm|crop|soil|fertilizer|plant|harvest|agriculture|panchagavya|agnihotra"; then
        echo "prithvi"
    elif echo "$q" | grep -qE "math|calculate|multiply|divide|number|computation|sutra"; then
        echo "agni"
    elif echo "$q" | grep -qE "philosophy|brahman|dharma|karma|moksha|veda|upanishad|spiritual|om|atman"; then
        echo "varuna"
    elif echo "$q" | grep -qE "health|ayurveda|disease|medicine|heal|body|diet|herb"; then
        echo "surya"
    elif echo "$q" | grep -qE "emotion|mind|mental|psychology|feeling|stress|anxiety|meditation"; then
        echo "chandra"
    elif echo "$q" | grep -qE "protect|security|kavach|encrypt|safe|guard|shield"; then
        echo "kavach"
    elif echo "$q" | grep -qE "translate|language|communicate|explain|meaning|sanskrit"; then
        echo "vayu"
    else
        echo "indra"
    fi
}

# Run a single agent query
run_agent() {
    local agent="$1"
    local prompt="$2"
    local temp="$3"
    local tokens="$4"
    printf "%s\n/exit\n" "$prompt" | $BIN -m "$MODEL" -n "$tokens" --temp "$temp" --threads 2 2>/dev/null | \
        awk '/^> / && !done {done=1; next} done && !/^> \/exit/ && !/^\[ Prompt:/ && !/^\[ Generation:/'
}

# Vedic signature
vedic_sign() {
    local seed=0
    for ((i=0; i<${#1}; i++)); do
        seed=$(( (seed * 67 + $(printf "%d" "'${1:$i:1}") * 21) % 999999937 ))
    done
    echo "VEDIC-SIGN-$(printf "%09d" $seed)-OM"
}

# ═══════════════════════════════════════════════════════════
# 8 AGENTS
# ═══════════════════════════════════════════════════════════

agent_prithvi() {
    echo "🌍 PRITHVI (Earth/Farming):"
    run_agent "prithvi" "You are Prithvi, earth goddess. Give Vedic farming advice: $1" 0.5 250
}

agent_agni() {
    echo "🔥 AGNI (Fire/Mathematics):"
    run_agent "agni" "You are Agni. Solve with Vedic Sutras: $1" 0.3 200
}

agent_varuna() {
    echo "💧 VARUNA (Water/Wisdom):"
    run_agent "varuna" "You are Varuna, Vedic scholar. Answer: $1" 0.8 300
}

agent_surya() {
    echo "☀️ SURYA (Sun/Health):"
    run_agent "surya" "You are Surya. Ayurvedic advice: $1" 0.6 250
}

agent_chandra() {
    echo "🌙 CHANDRA (Moon/Mind):"
    run_agent "chandra" "You are Chandra. Mental wellness guidance: $1" 0.9 250
}

agent_kavach() {
    echo "🛡️ KAVACH (Protection):"
    run_agent "kavach" "Kavach is Vedic armor. Security guidance: $1" 0.4 200
}

agent_vayu() {
    echo "💨 VAYU (Wind/Communication):"
    run_agent "vayu" "You are Vayu. Explain clearly: $1" 0.7 200
}

agent_indra() {
    echo "👑 INDRA (Orchestrator):"
    run_agent "indra" "You are Indra, king of Devas. Answer: $1" 0.7 300
}

# ═══════════════════════════════════════════════════════════
# MAIN SWARM
# ═══════════════════════════════════════════════════════════

vedic_swarm() {
    local query="$1"
    local sig=$(vedic_sign "$query")
    local agent=$(route_query "$query")
    
    echo "🕉️ VEDIC SWARM | 🔐 $sig"
    echo ""
    
    case $agent in
        prithvi) agent_prithvi "$query" ;;
        agni)    agent_agni "$query" ;;
        varuna)  agent_varuna "$query" ;;
        surya)   agent_surya "$query" ;;
        chandra) agent_chandra "$query" ;;
        kavach)  agent_kavach "$query" ;;
        vayu)    agent_vayu "$query" ;;
        *)       agent_indra "$query" ;;
    esac
    
    echo ""
    echo "🔐 Signature: $sig"
}

# Main
if [ -n "$1" ]; then
    vedic_swarm "$1"
else
    echo "🕉️ Vedic Swarm - 8 Deva Agents"
    echo "Usage: swarm 'your question'"
    echo "Agents: Prithvi🌍 Agni🔥 Varuna💧 Surya☀️ Chandra🌙 Kavach🛡️ Vayu💨 Indra👑"
fi
