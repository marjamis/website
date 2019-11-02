# Note: --incremental is disabled on Jekyll as while it will build the specific file if something uses that file it wont be rebuilt

default:
	echo "No specific operation selected."

dbuild:
	docker run -p 4000:4000 --rm --volume="$$PWD/vendor/bundle:/usr/local/bundle"  --volume="$$PWD:/srv/jekyll" -it -e VERBOSE="" -e JEKYLL_DEBUG="" jekyll/jekyll:3.8.6 jekyll build -V

dserver:
	docker run -p 4000:4000 --rm --volume="$$PWD/vendor/bundle:/usr/local/bundle"  --volume="$$PWD:/srv/jekyll" -it -e VERBOSE="" -e JEKYLL_DEBUG="" jekyll/jekyll:3.8.6 jekyll serve -V --watch --force_polling
