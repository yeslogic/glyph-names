# NOTE: This Makefile must remain compatible with BSD make and GNU make

all: src/aglfn_names.rs src/aglfn.rs

src/aglfn_names.rs: agl-aglfn/aglfn.txt aglfn_names.awk
	sort agl-aglfn/aglfn.txt | awk -f aglfn_names.awk > $@

src/aglfn.rs: agl-aglfn/aglfn.txt aglfn.awk
	sort agl-aglfn/aglfn.txt | awk -f aglfn.awk > $@
