# This file makes testing that `Makefile` is gmake compatible easier on GNU/Linux.
# BSDmakefile © 2022 Fredrick R. Brennan <copypaste@kittens.ph>
# 3-Clause BSD licensed.

SHELL=/bin/sh

PERCENT=%
DOBEFORE=eval export "$$($(MAKE) $(MFLAGS) before)" > /dev/null && set -x
MFLAGS:=-j1

.PHONY:
.ONESHELL:
before:
.for var in SED AWK LS TEE CAT TAC
	echo "$(var)="'"'"$$(if [ "$$(eval echo "$($(var))")" = "" ]; then which $$(echo "$(var)" | tr '[:upper:]' '[:lower:]'); else echo "$$(eval echo "$($(var))")"; fi)"'"'
.endfor
