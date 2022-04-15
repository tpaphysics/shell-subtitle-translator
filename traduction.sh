#/bin/bash

# Diretórios
TRANSLATE_OUT_DIR="pt-br_traduction"
LEGENDS_DIR="en_legends"

# Idioma de tradução
TRANSLATE_LANGUAGE="en:pt-br"

ls ./$LEGENDS_DIR >arq_list.txt

if [ ! -d $TRANSLATE_OUT_DIR ]; then
    mkdir $TRANSLATE_OUT_DIR
fi

while read line; do
    trans -b $TRANSLATE_LANGUAGE -i ./$LEGENDS_DIR/"$line" >./$TRANSLATE_OUT_DIR/"$line" &
done <arq_list.txt

echo "The end!"
