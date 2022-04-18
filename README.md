<p align="center">
  <a href="#" target="blank"><img src=".images/linux.png" width="200" alt="Crazy Linux" /></a>
</p>

  <H3 align="center"> Script para tradução de arquivos de legendas de filmes.
    <H3 align="center">
<img src="https://img.shields.io/badge/shell_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white" alt="Shell" />

<img src="https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black" alt="Linux" />

<img src="https://img.shields.io/badge/Debian-D70A53?style=for-the-badge&logo=debian&logoColor=white" alt="Prisma.io" />

<img src="https://img.shields.io/badge/Arch%20Linux-1793D1?logo=arch-linux&logoColor=fff&style=for-the-badge" alt="Arch Linuxr" />

<img src="https://img.shields.io/badge/cent%20os-002260?style=for-the-badge&logo=centos&logoColor=F0F0F0" alt="Cent OS" />

## Descrição

Ao obter um curso em formato de vídeo me deparei com o com problema de traduzir as legendas. Poderia copiar e colar o conteúdo dos arquivos e traduzir um por um manualmente no google tradutor... mas ia ser um trabalho penoso 😵‍! Poderia também baixar algum player que possui este recurso de forma nativa mas decidi implementar algumas linhas de código para fazer isso.

Então, lembrando-me de alguns conhecimentos de shell script, instalei o [translate-shell](https://man.archlinux.org/man/community/translate-shell/trans.1.en).

```bash
$ apt install translate-shell
```

Para escolher a engine padrão:

```bash
# A engine default é a do google.
$ trans -S

  aspell
* google
  bing
  spell
  hunspell
  apertium
  yandex
```

## Funcionamento

O formato das minhas legendas são em srt, confira o formato das suas legendas. copie e cole o script no diretório das legendas abra o terminal e execute:

```bash
$ ./translate.sh
```

O script criará os diretórios <strong>traduction</strong> e <strong>legends</strong> e moverá suas legendas originais para pasta legends e criará arquivos traduzidos para português brasileiro na pasta traduction.

## Observação

Utilizado este escript abaixo, verifiquei que o tempo para tradução dos aquivos era demasiadamente longo!

```shell
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
    trans -b $TRANSLATE_LANGUAGE -i ./$IN_DIR/"$line" --no-warn >./$OUT_DIR/"$line"
done <arq_list.txt
```

Então acrescentei o simbolo <strong>&</strong> ao final da linha 2:

```shell
1 while read line; do
2   trans -b $TRANSLATE_LANGUAGE -i ./$IN_DIR/"$line" --no-warn >./$OUT_DIR/"$line" &
3 done <arq_list.txt
```

Desta forma o tempo de tradução é menor pois todos os arquivos são traduzidos de forma simultânea:

Durante as traduções, o comando pgrep pode mostrar o PID dos processos que contém .<strong>srt</strong> no nome:

```shell
$ pgrep -f .srt

854650
854651
854652
854653
854654
854655
854656
854657
854658
```

Para obter o número de processos:

```shell
$ pgrep -f .srt | wc -l
22
```

Quando todos os processos que contém <strong>.srt</strong> no nome acabam, a saída de erro <strong>$?</strong> possui valor igual a 1 e o loop é encerrado o que indica o final das traduções.

```shell
while pgrep -f .srt >/dev/null; do
    loading $init
    spinner &
    sleep 5
    kill "$!" # kill the spinner
    printf '\n'
    clear
done
```

A função loading recebe como parametro a variável init que deve ser declarada antes do loop. Ela mede o número de processos no inicio da tradução:

```shell
loading() {
    process=$(pgrep -f .srt | wc -l)
    result=$(echo "scale=2; 100*(1-$process/$1)" | bc)
    percent=$(echo "scale=0; $result/1" | bc)
    echo -n "Translating... $percent%"
}

init=$( pgrep -f .srt | wc -l )
loading $init
```

Desta forma conseguimos monitorar o andamento das traduções.

## **📚 Referências**

- [Terminal Root](https://terminalroot.com.br/2019/10/traduza-rapidamente-textos-via-linha-de-comando.html)
- [Archlinux](https://man.archlinux.org/man/community/translate-shell/trans.1.en)

## **👨‍🚀 Autor**

<a href="https://github.com/tpaphysics">
<img alt="Thiago Pacheco" src="https://images.weserv.nl/?url=avatars.githubusercontent.com/u/46402647?v=4?v=4&h=300&w=300&fit=cover&mask=circle&maxage=7d" width="100px"/>
  <br />
  <sub>
    <b>Thiago Pacheco de Andrade</b>
  </sub>
</a>
<br />

👋 Meus contatos!

[![Linkedin Badge](https://img.shields.io/badge/-LinkedIn-blue?style=for-the-badge&logo=Linkedin&logoColor=white&link=https://www.linkedin.com/in/thiago-pacheco-200a1a86/)](https://www.linkedin.com/in/thiago-pacheco-200a1a86/)
[![Gmail Badge](https://img.shields.io/badge/-Gmail-c14438?style=for-the-badge&logo=Gmail&logoColor=white&link=mailto:physics.posgrad.@gmail.com)](mailto:physics.posgrad.@gmail.com)

## Licença

Veja o arquivo [MIT license](LICENSE.md).
