
# Build a tar from the local files. Tagging the build causes Travis to
# upload the package to the github releases.

empty :=
space := $(empty) $(empty)
usage::
	@echo 'usage:'
	@echo '# make [$(subst $(space),|,$(STRGT))]'

SRC += Makefile Rules.$(APP_ID).mk .travis.yml \
			 Makefile.default-goals
CLN += TODO.list $(APP_ID)-$(VERSION).tar
TRGT += TODO.list $(APP_ID)-$(VERSION).tar

$(APP_ID)-$(VERSION).tar: $(SRC) $(filter-out %.tar,$(TRGT))
	tar cvjf $@ $^


TODO.list: $(SRC)
	-grep -srI 'TODO\|FIXME\|XXX' $^ | grep -v 'grep..srI..TODO' | grep -v 'TODO.list' > $@

STRGT += release
release: M=Release
release:
	[ -n "$(VERSION)" ] || exit 1
	git add -u
	git ci -m "$(M) $(VERSION)"
	git tag $(VERSION)
	git push origin
	git push --tags

