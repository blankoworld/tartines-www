
PAGES != find . | grep '\.md$$'

Q := @

TEMPLATE = templates/template.tmpl
PANDOC_OPTS = -f markdown -t html --template="${TEMPLATE}" --toc -M menu -M content

all: public static ${PAGES:C/.md$/.xhtml/g}
clean: ${PAGES:C/$/-clean/g}

public:
	$Qmkdir -p public/meetings

static:
	$Qcp index.js public/index.js
	$Qcp style.css public/style.css

.for page in ${PAGES}
${page:C/.md$/.xhtml/}: ${page} ${TEMPLATE}
	@echo ' [PANDOC] $@'
	$Qpandoc ${PANDOC_OPTS} ${page} -o public/$@

${page:C/$/-clean/}:
	@echo ' [  RM  ] ${page:C/.md$/.xhtml/}'
	$Qrm -f ${page:C/.md$/.xhtml/}
	$Qrm -rf public
.endfor

