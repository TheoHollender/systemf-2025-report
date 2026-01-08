
REPORT_NAME    = report
LATEX_COMPILER = lualatex
LATEX_FLAGS    = -interaction=nonstopmode --shell-escape

CHAPTERS= \
	chapters/**/*.tex \
	chapters/*.tex
TEMPLATE=template/commands.tex \
	template/format.tex \
	template/preamble.tex \
	template/references.bib \
	template/titlepage.tex

CLEAN_EXTENSIONS = \
    .aux .bbl .blg .idx .ind .ilg .lof .lot .out .toc .log .nav .snm .vrb .synctex.gz .bcf .run.xml

.PHONY: all report clean

all: report clean
fast: _fast clean

report: $(REPORT_NAME).pdf

_fast: $(REPORT_NAME).tex $(CHAPTERS) $(TEMPLATE)
	$(LATEX_COMPILER) $(LATEX_FLAGS) report.tex
$(REPORT_NAME).pdf: $(REPORT_NAME).tex $(CHAPTERS) $(TEMPLATE)
	$(LATEX_COMPILER) $(LATEX_FLAGS) $<
	biber report
	$(LATEX_COMPILER) $(LATEX_FLAGS) $<
	$(LATEX_COMPILER) $(LATEX_FLAGS) $<

clean:
	@echo "Cleaning up..."
	@for ext in $(CLEAN_EXTENSIONS); do \
		rm -f $(REPORT_NAME)$$ext; \
	done