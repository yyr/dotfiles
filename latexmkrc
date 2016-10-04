# -*- mode: conf; -*-
#+DEST=$HOME/
#+FNAME=.latexmkrc

# $latex = 'latex --shell-escape';
# $pdflatex = 'pdflatex --shell-escape';

$pdf_previewer="emacsclient -c -e '(find-file %S)'";
$dvi_previewer = "emacsclient -c -e '(find-file %S)'";
$pdflatex='pdflatex %O -interaction=nonstopmode %S';
$pdf_update_method = 4;
$pdf_update_command = "emacsclient -e '(th/pdf-view-revert-buffer-maybe %S)'";
