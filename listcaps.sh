#!/bin/sh

grep CAP_ */*.c */*/*.c \
	| egrep -v "([A-Z_]CAP_)|(CAP_HAS)|(CAP_NEEDS)|(CAP_ABOVE)|(CAP_ISA)|(CAP_NET_ADMIN)" \
	| sed 's/^.*CAP_\([A-Z_]\+\)[,; )?\.].*$/CAP_\1/' \
	| uniq | sort | uniq

