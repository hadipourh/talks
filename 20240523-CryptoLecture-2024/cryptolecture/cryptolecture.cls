\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cryptolecture}[2020/10/10 Beamer presentations for Crypto lectures]
% MAINTAINED AT
%   https://extgit.iaik.tugraz.at/castle/teaching/cryptolecture
% DEPENDENCIES:
% - TU Graz 2018 template, beamerthemetugraz2018.sty
%   see also https://tu4u.tugraz.at/en/students/organisation-and-administration/corporate-design-templates/latex-presentation-template/
% - TikZ crypto utils, tikzlibrarycipher.code.tex
%   see also https://extgit.iaik.tugraz.at/meichlseder/tikz
% - XKCD figures in figures/xkcd_* (optional, not included in public template)

\LoadClass[aspectratio=169,xcolor=table]{beamer}

\newif\ifexternalize\externalizefalse
\DeclareOption{externalize}{\externalizetrue}
\DeclareOption{handout}{\PassOptionsToClass{handout}{beamer}}
\newif\ifbiblatex\biblatexfalse
\DeclareOption{biblatex}{\biblatextrue}
\newif\ifexternalprotocol\externalprotocolfalse
\DeclareOption{externalprotocol}{\externalprotocoltrue}
\newif\ifvirtual\virtualfalse
\DeclareOption{virtual}{\PassOptionsToPackage{nofiles}{beamerthemetugraz2018}\virtualtrue}

%\DeclareOption{...}{\OptionNotUsed}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}
\ProcessOptions\relax

% Theme %{{{
\usetheme[minimal, webfont, nofootline, noheadline]{tugraz2018}
\setbeamersize{text margin right=\tugraz@indent cm} % TODO make default

\IfFileExists{beamerthemetugraz/background_16-9.jpg}{}{\tugraz@filesfalse} % TODO include in beamerthemetugraz2018.sty

\RequirePackage{scrextend}
\changefontsizes{12pt}

\setlength{\tugraz@blocksep}{.8ex}

\colorlet{main}{head}
\renewcommand{\emph}[1]{{\color{main}#1}}
\newcommand{\sn}[1]{\textcolor{gray}{\ifmmode #1 \else \small #1\fi}}
\colorlet{exa}{colE} % math
%\newcommand{\exa}[1]{\textcolor{exa}{#1}}
\newcommand{\exa}[1]{{\color{exa} #1}}
\newcommand{\good}[1]{{\color{tuggreen} #1}}
\newcommand{\medi}[1]{{\color{tugyellow} #1}}
\newcommand{\evil}[1]{{\color{tug} #1}}

\newcommand{\emphbox}[2][main]{\colbox[#1]{#2}}

\newcommand{\itemwrap}[1]{\parbox{1cm}{\centering #1}}
\setbeamertemplate{section in toc}{\inserttocsection}
%\setbeamertemplate{subsection in toc}{\itemwrap{\tugsq} \small\inserttocsubsection\par}
\setbeamercolor{subsection in toc}{fg=gray}
\setbeamertemplate{subsection in toc}{\itemwrap{~} \tugsq~~\small\inserttocsubsection\par}

\newcommand{\addsection}[3]{% Title   - Subtitle   - Icon
  \section{\texorpdfstring{\itemwrap{\large\emph{#3}} }{}#1}
}
\newcommand{\mysection}[3]{% Title   - Subtitle   - Icon
  \section{\texorpdfstring{\itemwrap{\large\emph{#3}} }{}#1}
  \unnumbered{
  \sectionheader[#2]{#1\\\emph{#3}}
  }
}
\newcommand{\mysectionmute}[3]{
  \section*{\texorpdfstring{\itemwrap{\large\emph{#3}} }{}#1}
  \unnumbered{
  \sectionheader[#2]{#1\\\emph{#3}}
  }
}
\let\makesection\mysection
\let\makesectionmute\mysectionmute

\setbeamertemplate{theorems}[normal font]

\newcommand{\stuff}[1]{\mbox{#1\hspace*{-1cm}}}
\newcommand{\sparen}{\vspace*{-.3cm}}

\RequirePackage[normalem]{ulem}
\newcommand\nope{\bgroup\markoverwith {\textcolor{tug}{\rule[0.5ex]{2pt}{1.5pt}}}\ULon}

\renewcommand{\instituteurl}[1]{\def\insertinstituteurl{\hypersetup{urlcolor=main}#1}}
\newcommand{\web}[1]{\instituteurl{\url{#1}}}
%}}}

% Packages and commands %{{{
\RequirePackage{xspace}
\RequirePackage{fontawesome5,fontawesome,pifont}
\RequirePackage{tabu,colortbl,booktabs,multirow}

\newcommand{\cipher}[1]{\texttt{#1}}
\newcommand{\hex}[1]{\texttt{#1}}
\newcommand{\empf}[1]{\emph{\bfseries #1}}
\newcommand{\exaf}[1]{\exa{\bfseries #1}}

\newcommand{\Z}{\ensuremath{\mathbb{Z}}}
\newcommand{\N}{\ensuremath{\mathbb{N}}}
\newcommand{\R}{\ensuremath{\mathbb{R}}}
\newcommand{\F}{\ensuremath{\mathbb{F}}}
%}}}

% Encoding
\RequirePackage[utf8]{inputenc}

% Biblatex %{{{
\RequirePackage{csquotes}
\ifbiblatex
  \RequirePackage[backend=biber,style=alphabetic,maxbibnames=16, minalphanames=3, maxalphanames=4, minbibnames=1]{biblatex}
  \AtEveryBibitem{
    \clearfield{eprint}
    %\clearlist{location}
    \clearname{editor}
  }
  \addbibresource{\jobname.bib}
\fi
%}}}


\tabulinesep=1mm % TODO
\newcommand{\tugtabublock}{%
  \taburulecolor{block title.bg}
  \taburowcolors[1]2{block body.bg .. block body.bg}
  \rowfont{\color{block title.fg}}\rowcolor{block title.bg}
}

% Colors
\setbeamercolor{block title}{fg=white, bg=head}
%\setbeamercolor{block body}{parent=normal text,bg=body}

\hypersetup{urlcolor=main}

% Special Slides
\let\@oldmaketitle\maketitle
\def\maketitle{%
  \ifbeamer@inframe
    \@oldmaketitle
  \else
    \frame[plain,noframenumbering]{\@oldmaketitle}
  \fi
}

\let\@oldtableofcontents\tableofcontents
\def\tableofcontents{% [#1]
  \ifbeamer@inframe
    \@oldtableofcontents %[#1]
  \else
    \begin{frame}{\itemwrap{\faMapSigns} Outline}
      \@oldtableofcontents %[#1]
    \end{frame}
  \fi
}


\ifvirtual
\setbeamercovered{invisible}
\fi

% IAIK settings
\instituteurl{www.iaik.tugraz.at}
\newcommand{\iaikrule}[1][3cm]{\\[-.5ex]\rule{#1}{1.5pt}\\[.5ex]}

\definecolor{IAIKcrypto}{HTML}{A6C947}
\definecolor{IAIKsystem}{HTML}{1171A8}
\definecolor{IAIKformal}{HTML}{F7931E}
\definecolor{IAIKapplied}{HTML}{7D219E}
\definecolor{IAIKdefault}{HTML}{707070}

\newcommand{\faSystem}{\faCogs\xspace}
\newcommand{\faCrypto}{\faKey\xspace}
\newcommand{\faFormal}{\faSearch\xspace}
\newcommand{\faApplied}{\faShield\xspace}

% TikZ %{{{
\usetikzlibrary{positioning,decorations.pathreplacing,decorations.markings}

\usetikzlibrary{external}
\newcommand*{\overlaynumber}{\number\beamer@slideinframe}
\ifexternalize
\tikzexternalize[prefix=figures/Externalize/, only named=true, aux in dpth=false]
\fi

\IfFileExists{tikzlibrarycipher.code.tex}{
  \usetikzlibrary{cipher}
  \tikzset{op/.append style={minimum size=1.25ex}}  % TODO move to individual lectures
  \tikzset{>=ipe arrow}

  % Crypto TikZ
  \tikzset{primi/.style={box, minimum size=.75cm, fill=tugblue, draw=tugblue, font=\color{white} },
           modebox/.style={box, inner sep=2pt, minimum size=.5cm, fill=tuggreen, draw=tuggreen, font=\color{white} },
           sidehash/.style={shape=trapezium,shape border rotate=270,trapezium angle=70},
           hash/.style={shape=trapezium,shape border rotate=180,trapezium angle=70},
           blockcipher/.style={primi,node contents={$E_K$}}}
}{}

\tikzset{every node/.style={align=center,inner sep=2pt},
         every label/.style={inner sep=2pt, tugblue,label position=below,label distance=0pt}}
\tikzset{user/.style={inner sep=2pt, label position=above,label distance=3pt},
         thing/.style={inner sep=1pt, minimum size=.5cm},
         channel/.style={->, >=stealth, line width=3pt, colB}}



\RequirePackage[skins]{tcolorbox} % for "fill overzoom image"
\usetikzlibrary{arrows,intersections,shapes,shapes.geometric,shapes.callouts,shapes.arrows,shadows}

\newcommand{\tikzwrap}[2][tmp]{\tikz[baseline=(#1.base),remember picture]{\node[inner sep=0pt] (#1) {#2};}} % to point to text elements
\newcommand{\tikzmath}[2][tmp]{\tikz[baseline=(#1.base),remember picture]{\node[inner sep=0pt] (#1) {\ensuremath{#2}};}} % to point to text elements

% Sticky Notes
\definecolor{stickyyellow}{RGB}{242,226,149}
\tikzset{stickynote/.style={
          drop shadow={shadow xshift=2pt, shadow yshift=-4pt},
          inner xsep=7pt, inner ysep=10pt,
          fill=stickyyellow,
          xslant=-0.1, yslant=0.1,
          align=left,
          minimum width=4cm, minimum height=2.5cm
}} % {\parbox[t][2.5cm][c]{4.15cm}{...}}
%}}}

\RequirePackage{xargs}
\RequirePackage{ifthen}
\ifexternalprotocol
\RequirePackage{protocol}
\else
\newenvironment{protocol}[1][]{%
  \center
  \tikzpicture[#1]
}{%
  \endtikzpicture
  \endcenter
}
\newcommandx{\protparticipants}[4][1=3.5cm,4]{
  \node[user, minimum width=#1] (alice) at (-3.5,0) {#2};
  \node[user, minimum width=#1] (bob) at  (3.5,0) {#3};
  \coordinate (step) at (0,-1);
  \coordinate (step2) at (7,-1);
  \ifthenelse{\equal{#4}{}}{}{
  \node[user, minimum width=#1] (charlie) at  (10.5,0) {#4};
  }
}
\newcommand{\protnext}{\draw (step) +(0,-1) coordinate (step); \draw (step2) +(0,-1) coordinate (step2);}
\newcommand{\protsends}[1]{\draw[channel, ->] (alice.east|-step) -- node[above] {#1} (bob.west|-step);}
\newcommand{\protrecvs}[1]{\draw[channel, <-] (alice.east|-step) -- node[above] {#1} (bob.west|-step);}
\newcommand{\protsendsalt}[1]{\draw[channel, ->] (bob.east|-step2) -- node[above] {#1} (charlie.west|-step2);}
\newcommand{\protrecvsalt}[1]{\draw[channel, <-] (bob.east|-step2) -- node[above] {#1} (charlie.west|-step2);}
\newcommand{\protsender}[1]{\node at (alice|-step) {#1};}
\newcommand{\protrecver}[1]{\node at (bob|-step) {#1};}
\newcommand{\protcharlie}[1]{\node at (charlie|-step) {#1};}
\fi

% Crypto Iconry
\definecolor{gold}{HTML}{F0AB00} % color for keys

\newcommand{\fafont}{\large}

\newcommand{\faMessage}{\faFileTextO\xspace}
\newcommand{\faCiphertext}{\faEnvelope\xspace}
\newcommand{\faCiphertextTag}{\mbox{\faEnvelope\hskip-1.45ex\raisebox{.2ex}{\scalebox{.5}{\color{white}\faCertificate} }}\xspace}
\renewcommand{\faCiphertextTag}[1][white]{\tikz[every node/.append style={anchor=center, inner sep=0pt}]{\node[name=C]{ \faCiphertext };\node[#1,scale=.5] at (C){\faCertificate};}}
\newcommand{\faNonce}{\faQuestionCircle\xspace}
\newcommand{\faTweak}{\faWrench\xspace}
\newcommand{\faAssociated}{\faFileText\xspace}
\newcommand{\faHash}{\faFilter\xspace}
\newcommand{\faMAC}{\faFileCode\xspace}

\renewcommand{\faSign}{\faPencilSquareO}
\let\faHandSign\faSignature
\renewcommand{\faSignature}{\faCertificate}

\newcommand{\faPrivKey}{\faKey}
\newcommand{\faPubKey}[1][white]{\scalebox{1.2}{\faCloud}\hskip-.9em\raisebox{.1em}{\scalebox{.7}{\color{#1}\faKey} }}

% Crypto Scheme Notation
\newcommand{\Hash}{\ensuremath{\mathcal{H}}\xspace}
\newcommand{\MAC}[1][K]{\ensuremath{\mathcal{H}_{#1}}\xspace}
\newcommand{\ENC}[1][K]{\ensuremath{\mathcal{E}_{#1}}\xspace}
\newcommand{\DEC}[1][K]{\ensuremath{\mathcal{D}_{#1}}\xspace}
\newcommand{\AUTHENC}[1][K]{\ensuremath{\mathcal{AE}_{#1}}\xspace}
\newcommand{\AUTHDEC}[1][K]{\ensuremath{\mathcal{AD}_{#1}}\xspace}


% XKCD characters
% TODO clickable
\newcommand{\alice}[1][1.2cm]{%\reflectbox{\includegraphics[height=#1]{figures/xkcd_megan_alpha}} 
  \resizebox{!}{#1}{%
  \begin{tikzpicture}[y=-0.08pt, x=-0.08pt, inner sep=0pt, outer sep=0pt]
    \path[fill] (130.0000,1322.0000) .. controls (130.0000,1318.0000) and
      (158.0000,1198.0000) .. (192.0000,1055.0000) .. controls (229.0000,899.0000)
      and (255.0000,767.0000) .. (257.0000,725.0000) .. controls (258.0000,687.0000)
      and (258.0000,660.0000) .. (256.0000,665.0000) .. controls (254.0000,671.0000)
      and (240.0000,714.0000) .. (226.0000,763.0000) .. controls (201.0000,843.0000)
      and (192.0000,859.0000) .. (178.0000,845.0000) .. controls (175.0000,842.0000)
      and (183.0000,806.0000) .. (196.0000,766.0000) .. controls (208.0000,726.0000)
      and (226.0000,650.0000) .. (235.0000,599.0000) .. controls (243.0000,547.0000)
      and (253.0000,495.0000) .. (255.0000,482.0000) .. controls (260.0000,461.0000)
      and (258.0000,460.0000) .. (221.0000,466.0000) .. controls (173.0000,474.0000)
      and (120.0000,457.0000) .. (91.0000,426.0000) .. controls (39.0000,371.0000)
      and (30.0000,239.0000) .. (71.0000,159.0000) .. controls (109.0000,83.0000)
      and (214.0000,53.0000) .. (311.0000,89.0000) .. controls (406.0000,125.0000)
      and (428.0000,166.0000) .. (423.0000,295.0000) .. controls (421.0000,349.0000)
      and (417.0000,374.0000) .. (409.0000,372.0000) .. controls (402.0000,370.0000)
      and (400.0000,376.0000) .. (404.0000,385.0000) .. controls (407.0000,393.0000)
      and (413.0000,407.0000) .. (416.0000,415.0000) .. controls (420.0000,425.0000)
      and (416.0000,430.0000) .. (406.0000,430.0000) .. controls (397.0000,430.0000)
      and (390.0000,435.0000) .. (390.0000,440.0000) .. controls (390.0000,446.0000)
      and (381.0000,450.0000) .. (370.0000,450.0000) .. controls (356.0000,450.0000)
      and (350.0000,457.0000) .. (350.0000,471.0000) .. controls (350.0000,486.0000)
      and (346.0000,490.0000) .. (331.0000,485.0000) .. controls (306.0000,477.0000)
      and (298.0000,492.0000) .. (310.0000,524.0000) .. controls (319.0000,549.0000)
      and (371.0000,767.0000) .. (383.0000,838.0000) .. controls (388.0000,861.0000)
      and (386.0000,870.0000) .. (376.0000,870.0000) .. controls (367.0000,870.0000)
      and (356.0000,843.0000) .. (345.0000,793.0000) .. controls (336.0000,750.0000)
      and (321.0000,684.0000) .. (311.0000,645.0000) -- (295.0000,575.0000) --
      (292.0000,677.0000) .. controls (290.0000,761.0000) and (296.0000,813.0000) ..
      (325.0000,967.0000) .. controls (362.0000,1161.0000) and (387.0000,1282.0000)
      .. (396.0000,1313.0000) .. controls (404.0000,1339.0000) and
      (373.0000,1334.0000) .. (364.0000,1308.0000) .. controls (360.0000,1295.0000)
      and (338.0000,1186.0000) .. (315.0000,1065.0000) .. controls
      (267.0000,813.0000) and (276.0000,811.0000) .. (216.0000,1080.0000) ..
      controls (165.0000,1311.0000) and (159.0000,1330.0000) .. (144.0000,1330.0000)
      .. controls (136.0000,1330.0000) and (130.0000,1326.0000) ..
      (130.0000,1322.0000) -- cycle(277.0000,419.0000) .. controls
      (333.0000,392.0000) and (363.0000,354.0000) .. (355.0000,320.0000) .. controls
      (346.0000,285.0000) and (323.0000,270.0000) .. (276.0000,270.0000) .. controls
      (212.0000,270.0000) and (159.0000,251.0000) .. (123.0000,215.0000) --
      (91.0000,183.0000) -- (79.0000,217.0000) .. controls (66.0000,257.0000) and
      (74.0000,329.0000) .. (97.0000,378.0000) .. controls (126.0000,440.0000) and
      (199.0000,457.0000) .. (277.0000,419.0000) -- cycle(232.0000,229.0000) ..
      controls (209.0000,225.0000) and (185.0000,218.0000) .. (180.0000,215.0000) ..
      controls (174.0000,212.0000) and (170.0000,211.0000) .. (170.0000,215.0000) ..
      controls (170.0000,225.0000) and (214.0000,239.0000) .. (245.0000,238.0000) ..
      controls (269.0000,238.0000) and (267.0000,236.0000) .. (232.0000,229.0000) --
      cycle;
  \end{tikzpicture}%
  }
}

\newcommand{\bob}[1][1.2cm]{%\includegraphics[height=#1]{figures/xkcd_hairy_alpha}
  \resizebox{!}{#1}{%
  \begin{tikzpicture}[y=-0.08pt, x=0.08pt, inner sep=0pt, outer sep=0pt]
    \path[fill] (100.0000,1386.0000) .. controls (100.0000,1369.0000) and
      (187.0000,1016.0000) .. (234.0000,840.0000) .. controls (248.0000,788.0000)
      and (260.0000,723.0000) .. (259.0000,695.0000) .. controls (258.0000,648.0000)
      and (257.0000,651.0000) .. (224.0000,764.0000) .. controls (206.0000,829.0000)
      and (188.0000,885.0000) .. (186.0000,888.0000) .. controls (183.0000,890.0000)
      and (174.0000,890.0000) .. (166.0000,887.0000) .. controls (152.0000,882.0000)
      and (152.0000,876.0000) .. (165.0000,833.0000) .. controls (174.0000,807.0000)
      and (198.0000,720.0000) .. (219.0000,640.0000) -- (257.0000,495.0000) --
      (210.0000,494.0000) .. controls (153.0000,492.0000) and (112.0000,465.0000) ..
      (81.0000,410.0000) .. controls (52.0000,359.0000) and (44.0000,267.0000) ..
      (63.0000,213.0000) .. controls (75.0000,178.0000) and (75.0000,170.0000) ..
      (65.0000,170.0000) .. controls (48.0000,170.0000) and (37.0000,139.0000) ..
      (46.0000,116.0000) .. controls (49.0000,107.0000) and (58.0000,100.0000) ..
      (65.0000,100.0000) .. controls (72.0000,100.0000) and (80.0000,91.0000) ..
      (83.0000,81.0000) .. controls (87.0000,66.0000) and (100.0000,60.0000) ..
      (143.0000,55.0000) .. controls (174.0000,51.0000) and (203.0000,50.0000) ..
      (208.0000,54.0000) .. controls (213.0000,57.0000) and (232.0000,55.0000) ..
      (250.0000,50.0000) .. controls (276.0000,43.0000) and (288.0000,44.0000) ..
      (300.0000,55.0000) .. controls (309.0000,63.0000) and (324.0000,70.0000) ..
      (333.0000,70.0000) .. controls (390.0000,70.0000) and (430.0000,125.0000) ..
      (430.0000,205.0000) .. controls (430.0000,323.0000) and (383.0000,434.0000) ..
      (322.0000,461.0000) -- (293.0000,474.0000) -- (310.0000,514.0000) .. controls
      (331.0000,562.0000) and (390.0000,818.0000) .. (390.0000,861.0000) .. controls
      (390.0000,879.0000) and (385.0000,890.0000) .. (376.0000,890.0000) .. controls
      (361.0000,890.0000) and (358.0000,879.0000) .. (324.0000,705.0000) .. controls
      (310.0000,635.0000) and (305.0000,621.0000) .. (299.0000,640.0000) .. controls
      (287.0000,683.0000) and (290.0000,792.0000) .. (304.0000,855.0000) .. controls
      (312.0000,888.0000) and (326.0000,958.0000) .. (335.0000,1010.0000) ..
      controls (343.0000,1062.0000) and (364.0000,1163.0000) .. (380.0000,1233.0000)
      .. controls (414.0000,1380.0000) and (415.0000,1390.0000) ..
      (395.0000,1390.0000) .. controls (387.0000,1390.0000) and (376.0000,1374.0000)
      .. (371.0000,1352.0000) .. controls (349.0000,1272.0000) and
      (310.0000,1091.0000) .. (294.0000,995.0000) .. controls (285.0000,940.0000)
      and (275.0000,889.0000) .. (271.0000,883.0000) .. controls (264.0000,869.0000)
      and (241.0000,947.0000) .. (177.0000,1210.0000) .. controls
      (144.0000,1347.0000) and (131.0000,1385.0000) .. (117.0000,1388.0000) ..
      controls (108.0000,1390.0000) and (100.0000,1389.0000) .. (100.0000,1386.0000)
      -- cycle(285.0000,437.0000) .. controls (378.0000,385.0000) and
      (415.0000,265.0000) .. (361.0000,192.0000) .. controls (347.0000,175.0000) and
      (330.0000,160.0000) .. (323.0000,160.0000) .. controls (316.0000,160.0000) and
      (310.0000,153.0000) .. (310.0000,145.0000) .. controls (310.0000,134.0000) and
      (299.0000,130.0000) .. (271.0000,130.0000) .. controls (249.0000,130.0000) and
      (230.0000,125.0000) .. (228.0000,119.0000) .. controls (222.0000,102.0000) and
      (166.0000,118.0000) .. (136.0000,145.0000) .. controls (104.0000,175.0000) and
      (76.0000,269.0000) .. (85.0000,318.0000) .. controls (108.0000,441.0000) and
      (191.0000,490.0000) .. (285.0000,437.0000) -- cycle;
  \end{tikzpicture}%
  }
}

\newcommand{\caesar}[1][1.2cm]{%\includegraphics[height=#1]{figures/xkcd_beretguy}
  \resizebox{!}{#1}{%
  \begin{tikzpicture}[y=-0.08pt, x=0.08pt, inner sep=0pt, outer sep=0pt]
    \path[fill] (345.0000,1218.0000) .. controls (324.0000,1157.0000) and
      (252.0000,854.0000) .. (237.0000,760.0000) .. controls (233.0000,738.0000) and
      (233.0000,738.0000) .. (231.0000,765.0000) .. controls (230.0000,782.0000) and
      (218.0000,858.0000) .. (205.0000,935.0000) .. controls (191.0000,1012.0000)
      and (175.0000,1108.0000) .. (168.0000,1148.0000) .. controls
      (160.0000,1197.0000) and (152.0000,1220.0000) .. (142.0000,1220.0000) ..
      controls (132.0000,1220.0000) and (130.0000,1212.0000) .. (134.0000,1193.0000)
      .. controls (141.0000,1158.0000) and (187.0000,886.0000) ..
      (194.0000,840.0000) .. controls (197.0000,821.0000) and (204.0000,781.0000) ..
      (209.0000,752.0000) .. controls (215.0000,723.0000) and (222.0000,655.0000) ..
      (225.0000,602.0000) -- (231.0000,505.0000) -- (192.0000,618.0000) .. controls
      (170.0000,680.0000) and (150.0000,733.0000) .. (146.0000,737.0000) .. controls
      (131.0000,753.0000) and (128.0000,727.0000) .. (142.0000,688.0000) .. controls
      (169.0000,615.0000) and (220.0000,452.0000) .. (220.0000,442.0000) .. controls
      (220.0000,437.0000) and (201.0000,430.0000) .. (178.0000,426.0000) .. controls
      (72.0000,409.0000) and (14.0000,317.0000) .. (40.0000,205.0000) .. controls
      (46.0000,180.0000) and (46.0000,164.0000) .. (40.0000,162.0000) .. controls
      (19.0000,154.0000) and (30.0000,101.0000) .. (57.0000,80.0000) .. controls
      (80.0000,62.0000) and (92.0000,60.0000) .. (136.0000,65.0000) .. controls
      (178.0000,71.0000) and (188.0000,69.0000) .. (193.0000,56.0000) .. controls
      (201.0000,36.0000) and (229.0000,35.0000) .. (236.0000,55.0000) .. controls
      (240.0000,63.0000) and (250.0000,70.0000) .. (259.0000,70.0000) .. controls
      (268.0000,70.0000) and (293.0000,79.0000) .. (316.0000,89.0000) .. controls
      (381.0000,119.0000) and (405.0000,194.0000) .. (359.0000,223.0000) .. controls
      (347.0000,230.0000) and (340.0000,247.0000) .. (340.0000,265.0000) .. controls
      (339.0000,306.0000) and (308.0000,372.0000) .. (277.0000,397.0000) .. controls
      (252.0000,416.0000) and (252.0000,418.0000) .. (265.0000,457.0000) .. controls
      (286.0000,518.0000) and (318.0000,642.0000) .. (325.0000,694.0000) .. controls
      (335.0000,756.0000) and (315.0000,755.0000) .. (301.0000,693.0000) .. controls
      (294.0000,666.0000) and (288.0000,641.0000) .. (286.0000,635.0000) .. controls
      (285.0000,630.0000) and (277.0000,598.0000) .. (269.0000,565.0000) --
      (255.0000,505.0000) -- (252.0000,593.0000) .. controls (249.0000,692.0000) and
      (274.0000,847.0000) .. (322.0000,1030.0000) .. controls (360.0000,1177.0000)
      and (369.0000,1213.0000) .. (370.0000,1223.0000) .. controls
      (370.0000,1235.0000) and (350.0000,1231.0000) .. (345.0000,1218.0000) --
      cycle(272.0000,361.0000) .. controls (310.0000,322.0000) and
      (311.0000,320.0000) .. (308.0000,259.0000) .. controls (305.0000,199.0000) and
      (303.0000,194.0000) .. (271.0000,173.0000) .. controls (240.0000,152.0000) and
      (229.0000,150.0000) .. (161.0000,156.0000) .. controls (71.0000,163.0000) and
      (60.0000,173.0000) .. (60.0000,244.0000) .. controls (60.0000,310.0000) and
      (86.0000,360.0000) .. (130.0000,382.0000) .. controls (188.0000,412.0000) and
      (227.0000,406.0000) .. (272.0000,361.0000) -- cycle(358.0000,193.0000) ..
      controls (374.0000,165.0000) and (350.0000,129.0000) .. (302.0000,109.0000) ..
      controls (270.0000,95.0000) and (234.0000,90.0000) .. (166.0000,90.0000) ..
      controls (74.0000,90.0000) and (50.0000,98.0000) .. (50.0000,128.0000) ..
      controls (50.0000,141.0000) and (66.0000,142.0000) .. (142.0000,137.0000) ..
      controls (244.0000,130.0000) and (286.0000,142.0000) .. (318.0000,186.0000) ..
      controls (338.0000,214.0000) and (346.0000,215.0000) .. (358.0000,193.0000) --
      cycle;
  \end{tikzpicture}%
  }
}

\newcommand{\eve}[1][1.2cm]{%\reflectbox{\includegraphics[height=#1]{figures/xkcd_ponytail_alpha}} 
  \resizebox{!}{#1}{%
  \begin{tikzpicture}[y=-0.08pt, x=-0.08pt, inner sep=0pt, outer sep=0pt]
    \path[fill] (356.0000,1278.0000) .. controls (347.0000,1227.0000) and
      (325.0000,1118.0000) .. (307.0000,1035.0000) .. controls (279.0000,902.0000)
      and (275.0000,890.0000) .. (268.0000,920.0000) .. controls (252.0000,985.0000)
      and (209.0000,1135.0000) .. (174.0000,1248.0000) .. controls
      (149.0000,1329.0000) and (135.0000,1360.0000) .. (123.0000,1360.0000) ..
      controls (113.0000,1360.0000) and (109.0000,1354.0000) .. (113.0000,1343.0000)
      .. controls (116.0000,1333.0000) and (134.0000,1273.0000) ..
      (155.0000,1210.0000) .. controls (248.0000,919.0000) and (273.0000,769.0000)
      .. (253.0000,625.0000) -- (247.0000,577.0000) -- (219.0000,671.0000) ..
      controls (204.0000,723.0000) and (186.0000,784.0000) .. (180.0000,808.0000) ..
      controls (174.0000,833.0000) and (163.0000,850.0000) .. (155.0000,850.0000) ..
      controls (147.0000,850.0000) and (140.0000,847.0000) .. (140.0000,844.0000) ..
      controls (140.0000,840.0000) and (161.0000,767.0000) .. (186.0000,681.0000) ..
      controls (211.0000,595.0000) and (233.0000,517.0000) .. (236.0000,508.0000) ..
      controls (240.0000,496.0000) and (233.0000,486.0000) .. (215.0000,478.0000) ..
      controls (201.0000,472.0000) and (176.0000,448.0000) .. (160.0000,426.0000) --
      (130.0000,386.0000) -- (130.0000,416.0000) .. controls (130.0000,461.0000) and
      (110.0000,522.0000) .. (97.0000,517.0000) .. controls (90.0000,515.0000) and
      (82.0000,493.0000) .. (78.0000,469.0000) .. controls (75.0000,445.0000) and
      (60.0000,400.0000) .. (46.0000,370.0000) .. controls (-2.0000,268.0000) and
      (17.0000,190.0000) .. (91.0000,190.0000) .. controls (112.0000,190.0000) and
      (130.0000,186.0000) .. (130.0000,180.0000) .. controls (130.0000,159.0000) and
      (191.0000,103.0000) .. (228.0000,91.0000) .. controls (292.0000,69.0000) and
      (390.0000,80.0000) .. (433.0000,113.0000) .. controls (474.0000,144.0000) and
      (500.0000,213.0000) .. (500.0000,289.0000) .. controls (500.0000,339.0000) and
      (465.0000,424.0000) .. (434.0000,452.0000) .. controls (408.0000,475.0000) and
      (346.0000,500.0000) .. (315.0000,500.0000) .. controls (301.0000,500.0000) and
      (290.0000,502.0000) .. (290.0000,504.0000) .. controls (290.0000,508.0000) and
      (379.0000,661.0000) .. (385.0000,668.0000) .. controls (391.0000,675.0000) and
      (430.0000,549.0000) .. (430.0000,521.0000) .. controls (430.0000,484.0000) and
      (457.0000,477.0000) .. (465.0000,513.0000) .. controls (471.0000,538.0000) and
      (409.0000,712.0000) .. (391.0000,718.0000) .. controls (385.0000,720.0000) and
      (369.0000,702.0000) .. (355.0000,678.0000) .. controls (341.0000,654.0000) and
      (318.0000,617.0000) .. (304.0000,595.0000) -- (279.0000,555.0000) --
      (286.0000,685.0000) .. controls (291.0000,784.0000) and (305.0000,878.0000) ..
      (346.0000,1079.0000) .. controls (376.0000,1225.0000) and (400.0000,1350.0000)
      .. (400.0000,1357.0000) .. controls (400.0000,1364.0000) and
      (394.0000,1370.0000) .. (387.0000,1370.0000) .. controls (378.0000,1370.0000)
      and (368.0000,1338.0000) .. (356.0000,1278.0000) -- cycle(380.0000,448.0000)
      .. controls (410.0000,432.0000) and (430.0000,412.0000) .. (444.0000,386.0000)
      .. controls (465.0000,345.0000) and (479.0000,230.0000) .. (464.0000,230.0000)
      .. controls (459.0000,230.0000) and (444.0000,241.0000) .. (432.0000,255.0000)
      .. controls (399.0000,289.0000) and (340.0000,303.0000) .. (259.0000,295.0000)
      .. controls (185.0000,287.0000) and (178.0000,291.0000) .. (178.0000,345.0000)
      .. controls (178.0000,394.0000) and (200.0000,433.0000) .. (240.0000,452.0000)
      .. controls (287.0000,476.0000) and (327.0000,475.0000) .. (380.0000,448.0000)
      -- cycle(113.0000,373.0000) .. controls (120.0000,332.0000) and
      (107.0000,217.0000) .. (94.0000,213.0000) .. controls (74.0000,206.0000) and
      (50.0000,240.0000) .. (50.0000,273.0000) .. controls (50.0000,307.0000) and
      (91.0000,411.0000) .. (101.0000,404.0000) .. controls (105.0000,402.0000) and
      (110.0000,388.0000) .. (113.0000,373.0000) -- cycle(173.0000,268.0000) ..
      controls (180.0000,263.0000) and (221.0000,263.0000) .. (266.0000,266.0000) ..
      controls (356.0000,273.0000) and (391.0000,262.0000) .. (429.0000,214.0000) ..
      controls (457.0000,178.0000) and (456.0000,165.0000) .. (419.0000,139.0000) ..
      controls (371.0000,105.0000) and (316.0000,97.0000) .. (254.0000,115.0000) ..
      controls (180.0000,136.0000) and (147.0000,180.0000) .. (143.0000,263.0000) ..
      controls (140.0000,314.0000) and (142.0000,321.0000) .. (150.0000,300.0000) ..
      controls (156.0000,287.0000) and (166.0000,272.0000) .. (173.0000,268.0000) --
      cycle;
  \end{tikzpicture}%
  }
}

\newcommand{\hatguy}[1][1.2cm]{%\includegraphics[height=#1]{figures/xkcd_whitehat_alpha}
  \resizebox{!}{#1}{%
  \begin{tikzpicture}[y=-0.08pt, x=0.08pt, inner sep=0pt, outer sep=0pt]
    \path[fill] (437.0000,1473.0000) .. controls (434.0000,1467.0000) and
      (371.0000,1267.0000) .. (261.0000,910.0000) .. controls (255.0000,889.0000)
      and (250.0000,899.0000) .. (235.0000,965.0000) .. controls
      (226.0000,1009.0000) and (196.0000,1117.0000) .. (170.0000,1205.0000) ..
      controls (143.0000,1293.0000) and (119.0000,1382.0000) .. (115.0000,1403.0000)
      .. controls (108.0000,1437.0000) and (87.0000,1461.0000) ..
      (75.0000,1448.0000) .. controls (69.0000,1442.0000) and (86.0000,1375.0000) ..
      (140.0000,1195.0000) .. controls (213.0000,952.0000) and (229.0000,858.0000)
      .. (221.0000,720.0000) -- (215.0000,605.0000) -- (197.0000,705.0000) ..
      controls (188.0000,760.0000) and (180.0000,820.0000) .. (180.0000,838.0000) ..
      controls (180.0000,869.0000) and (159.0000,883.0000) .. (145.0000,861.0000) ..
      controls (139.0000,851.0000) and (195.0000,528.0000) .. (209.0000,495.0000) ..
      controls (215.0000,479.0000) and (209.0000,471.0000) .. (173.0000,448.0000) ..
      controls (121.0000,415.0000) and (80.0000,338.0000) .. (80.0000,273.0000) ..
      controls (80.0000,231.0000) and (80.0000,231.0000) .. (49.0000,237.0000) ..
      controls (3.0000,246.0000) and (16.0000,218.0000) .. (63.0000,207.0000) --
      (99.0000,198.0000) -- (93.0000,150.0000) -- (88.0000,103.0000) --
      (176.0000,87.0000) .. controls (225.0000,78.0000) and (304.0000,68.0000) ..
      (353.0000,64.0000) -- (440.0000,57.0000) -- (440.0000,108.0000) --
      (440.0000,159.0000) -- (480.0000,162.0000) .. controls (530.0000,166.0000) and
      (533.0000,184.0000) .. (485.0000,188.0000) .. controls (452.0000,191.0000) and
      (450.0000,193.0000) .. (457.0000,218.0000) .. controls (469.0000,261.0000) and
      (462.0000,369.0000) .. (444.0000,406.0000) .. controls (420.0000,457.0000) and
      (353.0000,493.0000) .. (292.0000,488.0000) -- (244.0000,485.0000) --
      (268.0000,565.0000) .. controls (281.0000,609.0000) and (300.0000,677.0000) ..
      (310.0000,716.0000) .. controls (320.0000,756.0000) and (336.0000,804.0000) ..
      (344.0000,824.0000) .. controls (354.0000,847.0000) and (355.0000,862.0000) ..
      (349.0000,866.0000) .. controls (332.0000,876.0000) and (323.0000,860.0000) ..
      (295.0000,765.0000) .. controls (251.0000,617.0000) and (250.0000,616.0000) ..
      (253.0000,720.0000) .. controls (255.0000,785.0000) and (263.0000,834.0000) ..
      (278.0000,875.0000) .. controls (289.0000,908.0000) and (320.0000,1003.0000)
      .. (346.0000,1085.0000) .. controls (372.0000,1168.0000) and
      (408.0000,1282.0000) .. (426.0000,1340.0000) .. controls (445.0000,1398.0000)
      and (460.0000,1453.0000) .. (460.0000,1463.0000) .. controls
      (460.0000,1480.0000) and (445.0000,1487.0000) .. (437.0000,1473.0000) --
      cycle(383.0000,427.0000) .. controls (429.0000,385.0000) and
      (448.0000,301.0000) .. (428.0000,237.0000) -- (415.0000,195.0000) --
      (350.0000,198.0000) .. controls (235.0000,204.0000) and (126.0000,220.0000) ..
      (118.0000,232.0000) .. controls (106.0000,252.0000) and (109.0000,304.0000) ..
      (124.0000,341.0000) .. controls (153.0000,409.0000) and (229.0000,459.0000) ..
      (307.0000,460.0000) .. controls (341.0000,460.0000) and (355.0000,454.0000) ..
      (383.0000,427.0000) -- cycle(265.0000,175.0000) .. controls
      (415.0000,161.0000) and (410.0000,163.0000) .. (410.0000,124.0000) .. controls
      (410.0000,83.0000) and (412.0000,84.0000) .. (260.0000,105.0000) .. controls
      (127.0000,124.0000) and (120.0000,127.0000) .. (120.0000,154.0000) .. controls
      (120.0000,186.0000) and (129.0000,192.0000) .. (170.0000,186.0000) .. controls
      (189.0000,183.0000) and (232.0000,178.0000) .. (265.0000,175.0000) -- cycle;
  \end{tikzpicture}%
  }
}
