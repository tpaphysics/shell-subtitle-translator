#/bin/bash

#Pasta com as legendas
IN_DIR="legends"

#Pasta com as legendas traduzidas
OUT_DIR="traduction"

# Idioma de tradução
TRANSLATE_LANGUAGE="en:pt-br"

if [ ! -d $IN_DIR ]; then
    mkdir $IN_DIR
    mv *.srt ./$IN_DIR/
fi

ls ./$IN_DIR >arq_list.txt

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

# Andamento das traduções
loading() {
    process=$(pgrep -f .srt | wc -l)
    result=$(echo "scale=2; 100*(1-$process/$1)" | bc)
    percent=$(echo "scale=0; $result/1" | bc)
    echo -n "Translating... $percent%"
}

# Motitora os processos que contem .srt no nome
clear
sleep 2
init=$(pgrep -f .srt | wc -l)

while pgrep -f .srt >/dev/null; do
    loading $init
    spinner &
    sleep 5
    kill "$!" # kill the spinner
    printf '\n'
    clear
done
echo "[*] Translation completed successfully !"
exit 0
