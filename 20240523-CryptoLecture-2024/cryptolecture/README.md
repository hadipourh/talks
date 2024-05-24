cryptolecture.cls
=================

This template for [LaTeX Beamer](https://ctan.org/pkg/beamer?lang=de) is used to typeset the slides for most [cryptography lectures at IAIK](https://www.iaik.tugraz.at/teaching/master-information-security/#after_section_2).

Usage
-----

See `lecture_example.tex` for a quickstart on how to use the documentclass.
For a full documentation of the underlying TU Graz presentation class, see [TU4U](https://tu4u.tugraz.at/en/students/organisation-and-administration/corporate-design-templates/latex-presentation-template/).

Compile with

```
pdflatex lecture_example.tex
biber lecture_example
pdflatex lecture_example.tex
```

or simply

```
latexmk -pdf lecture_example.tex
```

Git Submodule
-------------

Instead of copying the class files, you can also include them as a git submodule.
In the target directory for your `.tex` presentation files in some git repository, do

```
git submodule add git@extgit.iaik.tugraz.at:castle/teaching/cryptolecture.git cryptolecture
echo "ensure_path( 'TEXINPUTS', './cryptolecture//' );\n\$pdf_mode = 1;" >> .latexmkrc
cp cryptolecture/lecture_example.tex .
latexmk lecture_example.tex
```


Links
-----

  - Maintained at https://extgit.iaik.tugraz.at/castle/teaching/cryptolecture

  - Includes `beamerthemetugraz2018.sty` from TU Graz corporate design ([git](https://extgit.iaik.tugraz.at/meichlseder/tugraz-presentation), [TU4U](https://tu4u.tugraz.at/en/students/organisation-and-administration/corporate-design-templates/latex-presentation-template/))

  - Includes `tikzlibrarycipher.code.tex` from [TikZ cipher library](https://extgit.iaik.tugraz.at/meichlseder/tikz)

Authors
-------

  - Maria Eichlseder
  - Daniel Kales
