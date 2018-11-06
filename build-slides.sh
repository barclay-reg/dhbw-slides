bundle exec asciidoctor-revealjs -D output/ \
       -a revealjsdir=https://cdnjs.cloudflare.com/ajax/libs/reveal.js/3.5.0 \
       -a customcss=../styles.css \
        */*.adoc
