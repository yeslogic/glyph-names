#!/usr/bin/env gmake
###############################################################################
#- This file makes testing Makefile is bmake compatible easier on GNU/Linux. -#
#- BSDmakefile © 2022 Fredrick R. Brennan <copypaste@kittens.ph>             -#
###############################################################################
#- Permission  is  hereby granted, free of charge, to any person obtaining  a #
#- copy of this software and associated documentation files (the "Software"), #
#- to  deal in the Software without restriction, including without limitation #
#- the  rights to use, copy, modify, merge, publish, distribute,  sublicense, #
#- and/or  sell  copies  of the Software, and to permit persons to  whom  the #
#- Software is furnished to do so, subject to the following conditions:       #
#-                                                                            #
#- The above copyright notice and this permission notice shall be included in #
#- all copies or substantial portions of the Software.                        #
#-                                                                            #
#- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR #
#- IMPLIED,  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF  MERCHANTABILITY, #
#- FITNESS  FOR  A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT  SHALL #
#- THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER #
#- LIABILITY,  WHETHER  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,  ARISING #
#- FROM,  OUT  OF  OR  IN CONNECTION WITH THE SOFTWARE OR THE  USE  OR  OTHER #
#- DEALINGS IN THE SOFTWARE.                                                  #
###############################################################################

SHELL=/bin/bash
MFLAGS:=-j1

ifneq (,$(shell which bmake))
MAKE2:=bmake
else
$(warning "`bmake` not installed!")
MAKE2:=gmake
endif

.PHONY:
.ONESHELL:
all:
	$(
	$(eval export $(shell $(MAKE) WHAT=awk test_busybox_has))
	$(eval export $(shell $(MAKE) WHAT=sed test_busybox_has))
	$) $(MAKE2) $(MFLAGS) -f Makefile
	#
	# == End of GNUmakefile ==
	#

.PHONY:
.ONESHELL:
_test_busybox_has:
ifeq (,$(shell hash busybox))
# Makes testing the above requirement easier on GNU/Linux.
	echo "$(ENVVAR)='busybox $(CMD)'"
ifneq (,$(shell busybox $(CMDCHECK) || echo FAIL))
	$(warning "Busybox has no $(CMD)!")
	$(MAKE) _test_busybox_has_fail
endif
else
	$(warning "Busybox not installed")
	$(MAKE) _test_busybox_has_fail
endif

.PHONY:
_test_busybox_has_fail:
	echo "$(ENVVAR)='$(shell which $(CMD))'"

BUSYBOX_CMDS=$(shell busybox --list | xargs printf '"%s" ')

.PHONY:
test_busybox_has_%:
	seeking=$$(echo $@ | sed -e s/^test_busybox_has_//) && \
	for cmd in $(BUSYBOX_CMDS); do
		if [[ $$cmd == $$seeking ]]; then
			echo "$$($(MAKE) -s ENVVAR=$$(echo $$cmd | tr '[:lower:]' '[:upper:]')\
				CMD=$$cmd\
				CMDCHECK='true' _test_busybox_has 2> /dev/null)"
			break
		else
			continue
		fi
	done

.PHONY:
test_busybox_has:
	$(shell $(MAKE) test_busybox_has_$(WHAT) | grep ^[A-Z] )

PERCENT = $(shell echo $$'\045')
