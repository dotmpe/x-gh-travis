
# TODO: create releases using travis, see also GIT publish
# TODO: use $GH_TAG_TOKEN to tag succesful builds with the current release version

empty :=
space := $(empty) $(empty)
usage::
	@echo 'usage:'
	@echo '# npm [info|update|test]'
	@echo '# make [$(subst $(space),|,$(STRGT))]'

SRC += Makefile Makefile.default-goals configure Rules.x-gh-travis.mk .travis.yml
TRGT += TODO.list x-gh-travis.tar

x-gh-travis.tar: $(SRC) $(filter-out *.tar,$(TRGT))
	tar cvjf $@ $^

TODO.list: $(SRC)
	grep -srI 'TODO\|FIXME\|XXX' $^ | grep -v 'grep..srI..TODO' | grep -v 'TODO.list' > $@

