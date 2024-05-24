# you might need to install gnuplot
# sudo apt install gnuplot

ensure_path( 'TEXINPUTS', './cryptolecture//' );
$latex = 'latex -interaction=nonstopmode -shell-escape';
$pdflatex = 'pdflatex -interaction=nonstopmode -shell-escape';
$pdf_mode = 1;
