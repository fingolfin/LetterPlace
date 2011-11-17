all: doc test

doc: doc/manual.six

doc/manual.six: makedoc.g maketest.g ListOfDocFiles.g \
		PackageInfo.g \
		doc/LetterPlace.bib doc/*.xml doc/*.css \
		gap/*.gd gap/*.gi examples/*.g
	        gap makedoc.g

clean:
	(cd doc ; ./clean)

test:	doc
	gap maketest.g

archive: test
	(mkdir -p ../tar; cd ..; tar czvf tar/LetterPlace.tar.gz --exclude ".DS_Store" --exclude "*~" homalg/doc/*.* homalg/doc/clean homalg/gap/*.{gi,gd} homalg/{CHANGES,PackageInfo.g,README,VERSION,init.g,read.g,makedoc.g,makefile,maketest.g,ListOfDocFiles.g} homalg/examples/*.g)

WEBPOS=public_html
WEBPOS_FINAL=~/Sites/homalg-project/homalg

towww: archive
	echo '<?xml version="1.0" encoding="UTF-8"?>' >${WEBPOS}.version
	echo '<mixer>' >>${WEBPOS}.version
	cat VERSION >>${WEBPOS}.version
	echo '</mixer>' >>${WEBPOS}.version
	cp PackageInfo.g ${WEBPOS}
	cp README ${WEBPOS}/README.homalg
	cp doc/manual.pdf ${WEBPOS}/LetterPlace.pdf
	cp doc/*.{css,html} ${WEBPOS}
	rm -f ${WEBPOS}/*.tar.gz
	mv ../tar/LetterPlace.tar.gz ${WEBPOS}/homalg-`cat VERSION`.tar.gz
	rm -f ${WEBPOS_FINAL}/*.tar.gz
	cp ${WEBPOS}/* ${WEBPOS_FINAL}
	ln -s homalg-`cat VERSION`.tar.gz ${WEBPOS_FINAL}/LetterPlace.tar.gz
