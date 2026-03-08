#!/bin/bash

# update_index.sh
# Metti questo script in GitHub/denti-game/
# Eseguilo dopo ogni export Godot con: bash update_index.sh

GENERATED="index.html"
CUSTOM="index_custom.html"

# Controlla che esistano entrambi i file
if [ ! -f "$GENERATED" ]; then
    echo "❌ $GENERATED non trovato. Hai fatto l'export?"
    exit 1
fi

if [ ! -f "$CUSTOM" ]; then
    echo "❌ $CUSTOM non trovato. Metti index_custom.html in questa cartella."
    exit 1
fi

# Estrae i fileSizes dal nuovo index.html generato da Godot
SIZES=$(grep -o '"fileSizes":{[^}]*}' "$GENERATED")

if [ -z "$SIZES" ]; then
    echo "❌ fileSizes non trovato in $GENERATED. Controlla che sia un export Godot valido."
    exit 1
fi

# Aggiorna i fileSizes nell'index custom
sed -i '' "s/\"fileSizes\":{[^}]*}/$SIZES/" "$CUSTOM"

# Sovrascrive index.html con il custom aggiornato
cp "$CUSTOM" "$GENERATED"

echo "✅ index.html aggiornato con: $SIZES"
