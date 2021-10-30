.PHONY: ihaskell

ihaskell: CONTAINER := pfds
ihaskell: TAG := latest
ihaskell:
	@docker run \
		--name $(CONTAINER) \
		--rm \
		-p 8888:8888 \
		-v $(PWD):/home/jovyan/src \
		gibiansky/ihaskell:$(TAG)
