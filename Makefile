.PHONY: build check clean deploy format source

build:
	bash ./scripts/go.sh

check:
	bash ./scripts/reports.sh

clean:
	python -c "import shutil; shutil.rmtree('output', ignore_errors=True)"

deploy:
	bash ./cloudflare.sh

format:
	mdformat content

source:
	bash ./scripts/make_source.sh
