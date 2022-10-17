LaTeX package 'tikzpagenodes'
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Copyright (c) 2011-2022 by Martin Scharrer <martin.scharrer@web.de>
WWW: http://latex.scharrer.me/
CTAN: http://www.ctan.org/pkg/tikzpagenodes
Code repository: https://github.com/MartinScharrer/tikzpagenodes/

This LaTeX package provides specials PGF/TikZ nodes for the text, marginpar,
footer and header area of the current page.  They are inspired by the special
'current page' node defined by PGF/TikZ itself.

The nodes are rectangular and have the following names:

    current page text area
    current page marginpar area
    current page header area
    current page footer area

In order to use these nodes a TikZ picture needs to use the 'remember picture' option
and be compiled twice.

