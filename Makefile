all:

check: checkvars smoketest

smoketest:
	find testdata/mso/ -type f ! -name \*.vss -a ! -name \*.vsd -a ! -name \*.vst -a ! -name ~\* -exec sh -c "hsvba -pall \"{}\" | wc -c | xargs echo \"{}\"" \;

checkvars:
	AWK=gawk AWKOPT=-d/dev/stdout ./hsvba ./testdata/mso/word_office2007-12.0.6762.5000_dotm_ja-jp_001.dotm | grep ^_[^_] -c | xargs test 0 =
