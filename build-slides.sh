#!/bin/bash

makePdfs=${1}

mkdir -p ./output
rm -rf ./output/*

echo "Prepare static files"

cp ./README.adoc ./output
cp -R ./images ./output
cp ./styles.css ./output

echo "Start creating HTML slides for online publishing"
#bundle exec asciidoctor-revealjs \
npx asciidoctor-revealjs \
       -D output/lectures \
       -a revealjsdir=https://cdnjs.cloudflare.com/ajax/libs/reveal.js/3.9.2 \
       -a customcss=../styles.css \
        lectures/*.adoc

echo "Start creating README.html"
#bundle exec asciidoctor \
npx asciidoctor-revealjs \
       -D ./output README.adoc

if [ "$makePdfs" = "-makePdfs" ]; then

	echo "Start creating HTML slides for PDF publishing"

	#bundle exec asciidoctor-revealjs \
	npx asciidoctor-revealjs \
	   -D output/pdf-lectures \
       -a revealjs_theme=white \
       -a revealjsdir=https://cdnjs.cloudflare.com/ajax/libs/reveal.js/3.9.2 \
       -a customcss=../styles.css \
        lectures/*.adoc


	echo "Start creating PDF slides"
	for filenameWithExtension in ./output/pdf-lectures/*.html; do
		filename="$(basename $filenameWithExtension .html)"
		if [[ $filename  =~ ^[0-9]{2}-.* ]] && ! [[ $filename =~ .*aufgaben.* ]]; then
			npx decktape reveal "$filenameWithExtension" ./output/lectures/$filename.pdf -s 1280x950
		fi
	done
	echo "Start joining PDF files"
	gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=./output/lectures/all-slides.pdf ./output/lectures/*.pdf
fi

echo "Finished"