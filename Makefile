.DEFAULT_GOAL := helper

JEKYLL_IMAGE := jekyll/jekyll:3.8.6
JEKYLL_PORT := -p 4000:4000
JEKYLL_COMMAND := docker run --rm --volume="$$PWD/vendor/bundle:/usr/local/bundle"  --volume="$$PWD:/srv/jekyll" -it -e VERBOSE="" -e JEKYLL_DEBUG="" ${JEKYLL_PORT} ${JEKYLL_IMAGE}

helper: # Adapted from: https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
	@echo "Available targets..."
	@grep -hE '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build: ## Builds the application statically
	${JEKYLL_COMMAND} jekyll build -V

serve: ## Builds the application and runs a webserver
	# Note: --incremental is disabled on Jekyll as while it will build the specific file if something uses that file it wont be rebuilt
	${JEKYLL_COMMAND} jekyll serve -V --watch --force_polling

update: ## Updates the Jekyll bundle when there are changes required
	${JEKYLL_COMMAND} bundle update

clean: ## Cleans up any old/unneeded items
