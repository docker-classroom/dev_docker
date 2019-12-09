build:
	docker build -t research/dev .

run:
	docker run --rm -it \
		research/dev \
		/bin/bash


