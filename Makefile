pdfviewer = evince
latex = pdflatex

pics := flow.pic

all : project 
#work cv

############### PROJECT
project : project_dvi
	#dvips project.dvi
	#ps2pdf project.ps
	
project_dvi : project_bbl  
	$(latex) project.tex
	
$(pics) : %.pic : %.flo
	flow  $< $@

project_bbl : 
	# generate .aux
	$(latex) project.tex
	# generate .bbl
	bibtex project
	$(latex) project.tex

############### WORK
work : work_dvi

work_dvi : work_bbl
	$(latex) work.tex

work_bbl :
	$(latex) work.tex
	bibtex bu1
	bibtex bu2
	bibtex bu3
	bibtex bu4
	$(latex) work.tex

############### CV
cv : cv_dvi

cv_dvi : cv_bbl
	cd cv; \
	$(latex) cv2.tex; \
	cd ..

cv_bbl :
	cd cv; \
	$(latex) cv2.tex; \
	bibtex bu1; \
	bibtex bu2; \
	bibtex bu3; \
	bibtex bu4; \
	$(latex) cv2.tex; \
	cd ..

view : all
	$(pdfviewer) project.pdf 
#work.pdf cv/cv2.pdf &
	
clean :
	rm *.pic *.aux *.bbl *.blg *.log *.dvi  *.out; \
	cd cv; \
	rm *.pic *.aux *.bbl *.blg *.log *.dvi  *.out; \
	cd ../Thesis; \
	rm *.pic *.aux *.bbl *.blg *.log *.dvi  *.out; \
	cd ..
