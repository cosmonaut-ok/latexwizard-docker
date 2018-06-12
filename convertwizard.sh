#!/bin/bash

ACTION=$1

test -z $2 && exit 1

FILE_PATH=$2
FILE_DIR="$(dirname $FILE_PATH)"
FILE_NAME="$(basename $FILE_PATH .tex)"

MAYBE_BIBTEX="$FILE_DIR"/"$FILE_NAME".bib

GITHUB_URL=https://raw.githubusercontent.com/citation-style-language/styles/master

CSL="$(grep bibliographystyle thesis.tex | cut -d '{' -f2 | cut -d'}' -f1)".csl

test -n "$MAYBE_BIBTEX" && PANDOC_BIB_STRING="--bibliography=$MAYBE_BIBTEX"

function generate_bibtex
{
    ## http://www.bibtex.org/Using/
    latex $FILE_PATH
    bibtex $FILE_DIR/$FILE_NAME
    latex $FILE_PATH
    latex $FILE_PATH
}

function get_csl
{
    test ! -f $CSL && curl "$GITHUB_URL/$CSL" > $FILE_DIR/$CSL
}

## make functions
function make_pdf
{
    pdflatex $FILE_PATH
}

function make_docx
{
    get_csl
    pandoc --csl=${FILE_DIR}/${CSL} -s $PANDOC_BIB_STRING $FILE_PATH -o "$FILE_DIR/$FILE_NAME".docx
}

function make_clean
{
    rm -rf $CSL
    for i in out bbl dvi log out blg aux; do
        rm -rf "$FILE_DIR"/"$FILE_NAME".${i}
    done
}

function make_odt
{
    echo NOT IMPLEMENTED YET
}

function make_html
{
    echo NOT IMPLEMENTED YET
}

function make_html5
{
    echo NOT IMPLEMENTED YET
}

function make_markdown
{
    echo NOT IMPLEMENTED YET
}

function make_rtf
{
    echo NOT IMPLEMENTED YET
}

function make_epub
{
    echo NOT IMPLEMENTED YET
}

function make_fb2
{
    echo NOT IMPLEMENTED YET
}

function make_wordpress
{
    echo NOT IMPLEMENTED YET
}
#################


if [ -n "$MAYBE_BIBTEX" ] && [ ! $ACTION == "clean" ]; then
    ## check citation style from list https://github.com/citation-style-language/styles else set default
    if [ ! "$(curl -s -o /dev/null -w "%{http_code}" $GITHUB_URL/$CSL)" == "200" ]; then
        export CSL="ieee.csl"
    fi

    generate_bibtex
fi

case $ACTION in
    "pdf")
        make_pdf
        ;;
    "docx")
        make_docx
        ;;
    "odt")
        make_odt
        ;;
    "clean")
        make_clean
        ;;
    "html")
        make_html
        ;;
    "html5")
        make_html5
        ;;
    "md"|"markdown")
        make_markdown
        ;;
    "rtf")
        make_rtf
        ;;
    "epub")
        make_epub
        ;;
    "fb2")
        make_fb2
        ;;
    "wp"|"wordpress")
        make_wordpress
        ;;
    *)
        :
        ;;
esac
