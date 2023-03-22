Seminar Presentation
====================

Add your (final) presentation slides `presentation.pdf` here.
Of course, you can also add your working files (`.tex`, `.xslx`, etc), but no garbage compilation artefacts please (no `.log`, `.aux`, etc. -- you can copy  `Seminar-Report/.gitignore` here).

For your slides, you can use any LaTeX Beamer / Powerpoint / Google Slides / ... Template you deem appropriate for communicating your content; if unsure, consider using the [TU Graz templates](https://tu4u.tugraz.at/en/students/organisation-and-administration/corporate-design-templates/#c248569) ([LaTeX](https://tu4u.tugraz.at/en/students/organisation-and-administration/corporate-design-templates/latex-presentation-template/) or [Powerpoint](https://tu4u.tugraz.at/en/students/organisation-and-administration/corporate-design-templates/minimalist-powerpoint-presentation-template-with-more-space-for-content/)).


Use the following command to compile the latex file:

```sh
latexmk -pdf main.tex --shell-escape test-utf8
```
