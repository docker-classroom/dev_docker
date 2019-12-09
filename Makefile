build:
	docker build -t research/dev .

run:
	docker run --rm -it \
		-e uid=`id -u` \
		-e uname=`id -un` \
		-e gid=`id -g` \
		-e gname=`id -gn` \
		-e password=abc \
		-p 8722:22 \
		-v $(PWD)/start.sh:/bin/start.sh \
		research/dev \
		/bin/start.sh
