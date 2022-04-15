<p align="center">
  <a href="#" target="blank"><img src=".images/linux.png" width="200" alt="Crazy Linux" /></a>
</p>

  <H3 align="center"> Uso pratico do shell script para tradução simultânea de arquivos de legendas de filmes.
    <H3 align="center">
<img src="https://img.shields.io/badge/shell_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white" alt="Shell" />

<img src="https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black" alt="Linux" />

<img src="https://img.shields.io/badge/Debian-D70A53?style=for-the-badge&logo=debian&logoColor=white" alt="Prisma.io" />

<img src="https://img.shields.io/badge/Arch%20Linux-1793D1?logo=arch-linux&logoColor=fff&style=for-the-badge" alt="Arch Linuxr" />

<img src="https://img.shields.io/badge/cent%20os-002260?style=for-the-badge&logo=centos&logoColor=F0F0F0" alt="Cent OS" />

## Descrição

Ao obter um curso em formato de vídeo me deparei com o com problema de traduzir as legendas.

Poderia copiar e colar o conteúdo dos arquivos e traduzir um por um manualmente no google tradutor... mas ia ser um trabalho penoso! 😵‍💫. Ou baixar algum player com esse recurso de forma nativa mas decidi implementar algumas linhas de código para fazer isso.

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

Copie e cole todas as legendas para a pasta <strong>en_legends</strong> e execute o script:

```bash
$ ./translate.sh
```

o script criará o diretório <strong>pt-br_traduction</strong> e começará a criar os arquivos de legendas em português brasileiro.

## Observação

Utilizado este escript abaixo verifiquei que o tempo para tradução dos aquivos era demasiadamente longo!

```shell
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
    trans -b $TRANSLATE_LANGUAGE -i ./$LEGENDS_DIR/"$line" >./$TRANSLATE_OUT_DIR/"$line"
done <arq_list.txt
```

Então, acrescentei o simbolo <strong>&</strong> ao final da linha 2:

```shell
1 while read line; do
2    trans -b $TRANSLATE_LANGUAGE -i ./$LEGENDS_DIR/"$line" >./$TRANSLATE_OUT_DIR/"$line" &
3 done <arq_list.txt
```

Desta forma todos os arquivos foram traduzidos de forma simultânea:

```shell
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


```

## **📚 Referências**

- [Blog Terminal Root](https://terminalroot.com.br/2019/10/traduza-rapidamente-textos-via-linha-de-comando.html)
- [Archlinux documentação translate-shell ](https://man.archlinux.org/man/community/translate-shell/trans.1.en)

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
