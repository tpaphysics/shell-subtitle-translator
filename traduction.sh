#/bin/bash

# Diretórios

#Pasta com as legendas
IN_DIR="legends"

#Pasta com as legendas traduzidas
OUT_DIR="traduction"

# Idioma de tradução
TRANSLATE_LANGUAGE="en:pt-br"

ls ./$IN_DIR >arq_list.txt

if [ ! -d $IN_DIR ]; then
    mkdir $IN_DIR
    mv *.srt ./$IN_DIR/
fi

if [ ! -d $OUT_DIR ]; then
    mkdir $OUT_DIR
fi

while read line; do
    trans -b $TRANSLATE_LANGUAGE -i ./$IN_DIR/"$line" --no-warn >./$OUT_DIR/"$line" &
done <arq_list.txt

# Animação spin
spinner() {
    local i sp n
    sp='/-\|'
    n=${#sp}
    printf ' '
    while sleep 0.1; do
        printf "%s\b" "${sp:i++%n:1}"
    done
}

status=0
clear

# Motitora os processos que contem .srt no nome
while [ $status -eq 0 ]; do
    pgrep -f .srt >/dev/null
    status=$?
    printf 'Translating... '
    spinner &
    sleep 5
    kill "$!" # kill the spinner
    printf '\n'
    clear
done

# Messagem exibida quando todos os processos terminam
echo "[*] Translation completed successfully!"
exit 0
