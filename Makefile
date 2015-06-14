BUILD               := .build/
DIR                 := $(CURDIR)
BASE                := $(shell cd $(DIR);pwd)

HOST                := $(shell hostname|tr '.' '-')

ENV                 ?= development

APP_ID              := x-gh-travis

VERSION             := 0.0.5-master# x-gh-travis

# BSD weirdness
echo = /bin/echo

#      ------------ --

## Make internals

# make include search path
VPATH              := . /

# make shell
SHELL              := /bin/bash

# reset file extensions
# xxx for imlicit rules?
.SUFFIXES:
.SUFFIXES: .rst .mk .yaml .tar .bz2 .list

#      ------------ --

## Local setup

# name default target, dont set deps yet
default::

# preset DEFAULT based on environment/goals
include Makefile.default-goals

# global path/file lists
SRC                :=
DMK                :=
#already setMK                 :=
DEP                :=
TRGT               :=
STRGT              := default usage stat build test install check clean info 
CLN                :=
TEST               :=
INSTALL            :=

relative = $(patsubst $(BASE)%,$(APP_ID):%,$1)
where-am-i = $(call relative,$(lastword $(MAKEFILE_LIST)))

# rules: return Rules files for each directory in $1
rules = $(foreach D,$1,\
	$(wildcard \
		$DRules.mk $D.Rules.mk \
		$DRules.$(APP_ID).mk $D.Rules.$(APP_ID).mk \
		$DRules.$(HOST).mk $D.Rules.$(HOST).mk))

# Include local rules
#
include                $(call rules,$(DIR)/)

# pseudo targets are not files, don't check with OS
.PHONY: $(STRGT)

DEFAULT ?= usage

#      ------------ --

## Main rules/deps

default:: $(DMK) $(DEP)
default:: $(DEFAULT)

usage::
	@echo 'set ENV to [development|testing|production] for other default behaviour'

stat:: $(SRC)

build:: $(TRGT)

test:: $(TEST)

install:: $(INSTALL)

check::

clean:: .
	rm -rf $(CLN)

info::
	@echo "Id: $(APP_ID)/$(VERSION)"
	@echo "Name: $(APP_ID)"
	@echo "Version: $(VERSION)"

