# NOTE: This Makefile must remain compatible with BSD make and GNU make

all: src/aglfn_names.rs

# Produces src/aglfn_names.rs and src/aglfn.rs
src/aglfn_names.rs: agl-aglfn/aglfn.txt aglfn.awk
	sort agl-aglfn/aglfn.txt | awk -f aglfn.awk
	cargo fmt

