
.PHONY: all check docker-check docker-login smoke progress multiawk awkbox changelog

all:

clean:
	rm -v scripts/*.log

check: checkvars multiawk

smoke:
	@ testdir=testdata \
	    scripts/smoke 2> scripts/smoke.log

progress:
	@ testdir=testdata \
	    scripts/progress-wrap \
	    scripts/smoke 2> scripts/progress.log

multiawk:
	@ testdir=testdata \
	    scripts/multiawk-wrap \
	    scripts/progress-wrap \
	    scripts/smoke 2> scripts/multiawk.log

checkvars:
	@ scripts/vars 2> scripts/vars.log

boxcheck: awkbox
	@ docker run --rm -it -v "$(PWD):/home/user/work:rw" \
	    awkbox make check

boxlogin: awkbox
	@ docker run --rm -it -v "$(PWD):/home/user/work:rw" \
	    awkbox /bin/bash

awkbox:
	@ docker info >/dev/null 2>&1 || echo docker is not running >&2
	@ scripts/awkbox awkbox

changelog:
	@ scripts/gitlog-to-changelog \
		--append-dot \
		--ignore-matching="Merge branch|\\+" \
		--strip-cherry-pick \
		--commit-timezone > ChangeLog

# vim: set ft=make
