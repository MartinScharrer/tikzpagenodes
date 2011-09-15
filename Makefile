CONTRIBUTION  = tikzpagenodes
NAME          = Martin Scharrer
EMAIL         = martin@scharrer-online.de
DIRECTORY     = /macros/latex/contrib/${CONTRIBUTION}
LICENSE       = free
FREEVERSION   = lppl
FILE          = ${CONTRIBUTION}.tar.gz
export CONTRIBUTION VERSION NAME EMAIL SUMMARY DIRECTORY DONOTANNOUNCE ANNOUNCE NOTES LICENSE FREEVERSION FILE


SRCFILES = ${CONTRIBUTION}.sty
DOCFILES = ${CONTRIBUTION}.pdf README


TEXMF = ${HOME}/texmf

LATEXMK = latexmk -pdf

.PHONY: all upload doc clean install uninstall build

all: doc

${FILE}: ${CONTRIBUTION}.dtx ${CONTRIBUTION}.ins ${CONTRIBUTION}.sty README ${CONTRIBUTION}.pdf
	${MAKE} --no-print-directory build

upload: ${FILE}
	ctanupload -p

doc: ${CONTRIBUTION}.pdf

${CONTRIBUTION}.pdf: ${CONTRIBUTION}.dtx ${CONTRIBUTION}.sty ${CONTRIBUTION}.ins
	${MAKE} --no-print-directory build

BUILDDIR = build

build:
	-mkdir ${BUILDDIR} 2>/dev/null || true
	cp ${CONTRIBUTION}.ins README ${BUILDDIR}/
	tex '\input ydocincl\relax\includefiles{${CONTRIBUTION}.dtx}{${BUILDDIR}/${CONTRIBUTION}.dtx}' && ${RM} ydocincl.log
	cd ${BUILDDIR} && tex ${CONTRIBUTION}.ins
	cd ${BUILDDIR} && ${LATEXMK} ${CONTRIBUTION}.dtx
	cd ${BUILDDIR} && ctanify ${CONTRIBUTION}.dtx ${CONTRIBUTION}.ins ${CONTRIBUTION}.sty README ${CONTRIBUTION}.pdf
	cd ${BUILDDIR} && cp ${CONTRIBUTION}.tar.gz ${CONTRIBUTION}.pdf ..

clean:
	latexmk -C ${CONTRIBUTION}.dtx
	@${RM} ${CONTRIBUTION}.cod ${CONTRIBUTION}.glo ${CONTRIBUTION}.gls ${CONTRIBUTION}.exa ${CONTRIBUTION}.log ${CONTRIBUTION}.aux
	${RM} -r build ${FILE}


distclean:
	latexmk -c ${CONTRIBUTION}.dtx
	@${RM} ${CONTRIBUTION}.cod ${CONTRIBUTION}.glo ${CONTRIBUTION}.gls ${CONTRIBUTION}.exa ${CONTRIBUTION}.log ${CONTRIBUTION}.aux
	${RM} -r build


install: ${CONTRIBUTION}.pdf ${CONTRIBUTION}.sty
	-@mkdir ${TEXMF}/tex/latex/${CONTRIBUTION}/ 2>/dev/null || true
	-@mkdir ${TEXMF}/doc/latex/${CONTRIBUTION}/ 2>/dev/null || true
	cp ${SRCFILES} ${TEXMF}/tex/latex/${CONTRIBUTION}/
	cp ${DOCFILES} ${TEXMF}/doc/latex/${CONTRIBUTION}/
	test -f ${TEXMF}/ls-R && texhash ${TEXMF}


installsymlinks:
	-@mkdir ${TEXMF}/tex/latex/${CONTRIBUTION}/ 2>/dev/null || true
	-cd ${TEXMF}/tex/latex/${CONTRIBUTION}/ && ${RM} ${SRCFILES}
	ln -s $(addprefix ${PWD}/,${SRCFILES}) ${TEXMF}/tex/latex/${CONTRIBUTION}/
	test -f ${TEXMF}/ls-R && texhash ${TEXMF}


uninstall:
	${RM} ${TEXMF}/tex/latex/${CONTRIBUTION}/ ${TEXMF}/doc/latex/${CONTRIBUTION}/
	test -f ${TEXMF}/ls-R && texhash ${TEXMF}
