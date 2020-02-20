# NOTE: This Makefile must remain compatible with BSD make and GNU make

src/aglfn.rs: agl-aglfn/aglfn.txt aglfn.awk
	sort agl-aglfn/aglfn.txt | awk -f aglfn.awk > $@
