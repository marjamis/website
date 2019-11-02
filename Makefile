JEKYLL_IMAGE := jekyll/jekyll:3.8.6
# Note: --incremental is disabled on Jekyll as while it will build the specific file if something uses that file it wont be rebuilt
JEKYLL_COMMON := docker run --rm --volume="$$PWD/vendor/bundle:/usr/local/bundle"  --volume="$$PWD:/srv/jekyll" -it -e VERBOSE="" -e JEKYLL_DEBUG=""
JEKYLL_PORT := -p 4000:4000

default:
	echo "No specific operation selected."

dbuild:
	${JEKYLL_COMMON} ${JEKYLL_PORT} ${JEKYLL_IMAGE} jekyll build -V

dserver:
	${JEKYLL_COMMON} ${JEKYLL_PORT} ${JEKYLL_IMAGE} jekyll serve -V --watch --force_polling

update:
	${JEKYLL_COMMON} --network=host --dns 8.8.8.8 ${JEKYLL_IMAGE} bundle update
