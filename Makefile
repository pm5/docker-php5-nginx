NAME = pomin5/php5-nginx
VERSION = 0.1.4
CONTAINER_NAME=`pwd | sed 's/.*\///'`_php5-nginx

.PHONY: build test run

build:
	docker build --rm -t $(NAME):$(VERSION) .

test:
	docker run -it --rm \
		-p 8080:80 -p 2222:22 -p 2020:20 -p 2121:21 \
		-e ENABLE_FTP=1 \
		-e ENABLE_MY_KEY=1 \
	 	-v $(PWD):/var/www \
	 	-v $(PWD)/.run/log:/var/log \
	 	$(NAME):$(VERSION) /bin/bash

run:
	docker run -dt \
		-p 8080:80 -p 2222:22 -p 2020:20 -p 2121:21 \
		-e ENABLE_FTP=1 \
		-e ENABLE_MY_KEY=1 \
	 	-v $(PWD):/var/www \
	 	-v $(PWD)/.run/log:/var/log \
		--name $(CONTAINER_NAME) \
	 	$(NAME):$(VERSION)
