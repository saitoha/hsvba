
cnt:=$$(find testdata/mso/ -type f ! -name \*.vss -a ! -name \*.vsd -a ! -name \*.vst -a ! -name ~\* | wc -l)

all:

check: checkvars smoketest-in-all-awks

smoketest:
#	@ find testdata/mso/ -type f ! -name \*.vss -a ! -name \*.vsd -a ! -name \*.vst -a ! -name ~\* -exec bash -c " \
	    ./hsvba \"{}\" -pall > /dev/null; echo \"{} \$$?\"" \;
	@ find testdata/mso/ -type f ! -name \*.vss -a ! -name \*.vsd -a ! -name \*.vst -a ! -name ~\* | sort | while read f; do \
	    trap break SIGINT; \
	    ./hsvba $$f -pall > /dev/null; \
	    echo $$f $${?}; \
	done

checkvars:
	AWK=gawk AWKOPT=-d/dev/stdout ./hsvba ./testdata/mso/word_office2007-12.0.6762.5000_dotm_ja-jp_001.dotm | grep ^_[^_] -c | xargs test 0 =

progress:
	@ trap 'printf "\033[!p\033[?25h"' SIGINT && printf "\033[?25l\033D\033D\033D\033[3A\0337\0338"; { \
	    bar=$$(printf '%.s#' {1..60}); start=$$(date +%s); \
	    make smoketest | while read file result bytes hash; do \
	        test x$$result = x0 && : $$((++i)); \
		printf "\0338[\033[1m%-10s\033[m]\033[K\n[%-$${#bar}s] \033[1m%3ds\033[m\n[%2d / %2d] %s\033[K" \
	            "${AWK}" "$${bar:0:$$((i * $${#bar} / $(cnt)))}" "$$(($$(date +%s) - start))" $$i $(cnt) $$file; \
	        test $$((++n)) = $(cnt) && printf "\0338[\033[M\033[1m%-10s\033[m] $$(($(cnt) - i)) errors, \033[1m%3ds\033[m\033[K\n" \
	            "${AWK}" "$$(($$(date +%s) - start))"; \
	    done; \
	}
	@ trap "" SIGINT;

smoketest-in-all-awks:
	@ for awk in $$(which mawk gawk wak goawk bioawk jawk pawk oawk awk); do \
	    AWK="$${awk}" make progress; \
	done
