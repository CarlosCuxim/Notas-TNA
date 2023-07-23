\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{qx-files/qx-book}
\LoadClassWithOptions{book}

% ==============================================================================
% ----------------------- CLASE CREADA POR CARLOS CUXIM ------------------------
%
% Esta clase modifica la clase de book para cambios estéticos. Como una portada 
% más elaborada y un cambio en el diseño de los capítulos
%
% ==============================================================================


\RequirePackage{geometry}
\RequirePackage{microtype}
\RequirePackage{fancyhdr}
\RequirePackage{tikz}



% PALETA DE COLORES ------------------------------------------------------------
\colorlet{MainColor}{blue!30!black}
\colorlet{SecondaryColor}{yellow!80!red}


% CABEZERA Y PIE DE PÁGINA -----------------------------------------------------
\pagestyle{fancy}
\renewcommand{\headrulewidth}{0pt}% Se suprime la linea de la cabecera
\fancyhead[EL,OR]{\thepage}% Número de página
\fancyhead[ER]{\leftmark}% Nombre del capítulo
\fancyhead[OL]{\rightmark}% Nombre de la sección
\fancyfoot{} % Se suprimo el pie de página

% Formato de \leftmark (capítulo)
\renewcommand{\chaptermark}[1]{\markboth{%
  \ifnum\c@secnumdepth>\m@ne
    \if@mainmatter
      \thechapter.%
    \fi
  \fi
  \space#1}{}}

% Formato de \leftmark (sección)
\renewcommand{\sectionmark}[1]{\markright{%
  \ifnum\c@secnumdepth>\z@
    \thesection%
  \fi
  \space#1}}

% Se agrega más espacio a la cabecera
\addtolength{\headheight}{1pt}
\addtolength{\topmargin}{-1pt}



% ENTRADAS AUXILIARES ----------------------------------------------------------

% Subtítulo
\DeclareRobustCommand*{\subtitle}[1]{\gdef\@subtitle{#1}}
% Publisher
\DeclareRobustCommand*{\publisher}[1]{\gdef\@publisher{#1}}



% PORTADA DEL LIBRO ------------------------------------------------------------

% Medidas adicionales
\newlength{\AuthorSep}\setlength{\AuthorSep}{1em}
% Colores adicionales
\colorlet{MainCover}{MainColor}
\colorlet{SecondaryCover}{SecondaryColor}

% Definición de el fondo de la cubierta
\newcommand\Qx@PrintBackBookCover{%
\begin{tikzpicture}[remember picture, overlay]
  \fill[MainCover]
    (current page.north west) rectangle (current page.south east);
  \fill[SecondaryCover]
    (current page.north west) rectangle +(\paperwidth,-3in);
  \draw[line width=2pt, white]
    (current page.north west) ++(1in,0) -- +(0,-\paperheight);
  \draw[line width=2pt, white]
    (current page.north west) ++(0,-3in) -- +(\paperwidth,0);
\end{tikzpicture}%
}

% Definición del texto de la cubierta
\newcommand\Qx@PrintBookCover{% Autores
  \begin{minipage}[b][2in][b]{\textwidth}%
    \color{MainCover}\Huge
    \begin{tabular}[b]{l}%
      \@author
    \end{tabular}%
  \end{minipage}\par
    \vskip1in% Título
  {\color{white}\bfseries\fontsize{60}{60}\selectfont\@title\par}%
  \ifdefined\@subtitle% Revisa si se usó \subtitle
      \vskip20\p@% Subtítulo
    {\color{SecondaryCover}\fontsize{30}{36}\selectfont\@subtitle\par}%
  \fi
  \ifdefined\@publisher% Revisa si se usó \publisher
    \vfill% Publisher
  {\color{white}\Huge\@publisher\par}%
  \fi
}

% Definición de la cubierta
\newcommand\MakeBookCover{%
  \thispagestyle{empty}% La numeración se suprime
  \newgeometry{left=1.5in, right=1in, top=0.5in, bottom=1in}% Cambio de los márgenes
  \begin{titlepage}% Se inicia el titlepage
    \parindent\z@\raggedright\sffamily% Cambio del formato del párrafo
    \def\thanks##1{}% Se suprime el \thanks
    \def\and{\\[\AuthorSep]}% Se modifica el significado del \and
    \Qx@PrintBackBookCover% Se imprime el fondo de la cubierta
    \Qx@PrintBookCover% Se imprime el texto de la cubierta
  \end{titlepage}%
  \restoregeometry% Se vuelve a los márgenes anteriores
  \clearpage\thispagestyle{empty}\clearpage% Se agrega una página vacía
}



% CAMBIO DEL COMANDO \maketitle ------------------------------------------------
\let\oldmaketitle=\maketitle% Se guarda el comando anterior por si algo
\renewcommand\maketitle{%
  \begin{titlepage}%
    \let\footnotesize\small
    \let\footnoterule\relax
    \let\footnote\thanks
    \null\vfil
    \vskip 60\p@
    \begin{center}%
      {\Huge\bfseries\@title\par}% Título
      \ifdefined\@subtitle% Revisa si \@subtitle está vacío
          \vskip 2em%
        {\LARGE\@subtitle\par}% Subtítulo
      \fi
        \vfil
      {\large% Autores
      \lineskip .75em%
        \begin{tabular}[t]{c}%
          \@author
        \end{tabular}\par}
        \vfil
      \ifdefined\@publisher% Revisa si \@publisher está vacío
        {\large\@publisher\par}% Publisher
          \vskip 1.5em%
      \fi
      {\large\@date\par}% Fecha
    \end{center}\par
    \@thanks
    \vfil\null
  \end{titlepage}%
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}



% CAMBIO DEL COMANDO \part -----------------------------------------------------
\renewcommand\part{%
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
  \thispagestyle{empty}% Se elimina la numeración
  \if@twocolumn
    \onecolumn
    \@tempswatrue
  \else
    \@tempswafalse
  \fi
  \null\vfil
  \secdef\@part\@spart}



% CAMBIO DE FORMATO DE CAPÍTULO ------------------------------------------------

% Medidas adicionales
\newlength{\ChapSqSize}
% Colores adicionales
\colorlet{ChapSqSize}{blue!50!black}

% Definición del formato de cabecera de capítulo numerado
\newcommand\QxChapterHead[1]{%
  \begin{tikzpicture}[trim left=\z@, trim right=\textwidth]
    \setlength{\ChapSqSize}{90\p@}
    \node[text=white, fill=ChapSqSize, align=center, text width=\ChapSqSize, minimum height=\ChapSqSize, inner sep=\z@, anchor=north west] (ChNo)
        {\textls{\MakeUppercase{\@chapapp}}\\[1ex]%
        {\fontsize{80}{96}\selectfont\thechapter}};
    \node[anchor=base west, text width={\textwidth-\ChapSqSize-5\p@}, inner sep=\z@, align=left, xshift=5\p@, yshift=-24\p@] (ChTit)
      at (ChNo.north east)
      {\Huge\bfseries #1\par};
  \end{tikzpicture}%
}

% Definición del fomato de cabezera de capítulo no numerado
\newcommand\QxsChapterHead[1]{%
  \begin{tikzpicture}[trim left=\z@, trim right=\textwidth]
    \setlength{\ChapSqSize}{30\p@}
    \node[text=white, fill=ChapSqSize, align=center, text width=\ChapSqSize, minimum height=\ChapSqSize, inner sep=\z@, anchor=north west] (ChNo)
        {};
    \node[anchor=base west, text width={\textwidth-\ChapSqSize-5\p@}, inner sep=\z@, align=left, xshift=5\p@, yshift=-24\p@] (ChTit)
      at (ChNo.north east)
      {\Huge\bfseries #1\par};
  \end{tikzpicture}%
}

% Redefinición del comando que se encarga del formato de cabecera de capítulo numerado
\def\@makechapterhead#1{%
  \vspace*{50\p@}%
  {\parindent\z@ \raggedright \normalfont
    \ifnum\c@secnumdepth>\m@ne
        \if@mainmatter
          \QxChapterHead{#1}%
        \else
          \QxsChapterHead{#1}%
        \fi
      \else
        \QxsChapterHead{#1}
    \fi%
    \vskip 40\p@ plus 5\p@ minus 5\p@
  }}

% Redefinición del comando que se encarga del formato de cabecera de capítulo no numerado
\def\@makeschapterhead#1{%
  \vspace*{50\p@}%
  {\parindent\z@ \raggedright \normalfont
    \QxsChapterHead{#1}
    \vskip 40\p@ plus 5\p@ minus 5\p@
  }}



% Sección de ejercicios --------------------------------------------------------

\newcommand\ExerciseSection{%
  \section*{Ejercicios}%
  \addcontentsline{toc}{subsection}{Ejercicios}%
}

\newenvironment{ExerciseList}{\begin{enumerate}}{\end{enumerate}}



\endinput