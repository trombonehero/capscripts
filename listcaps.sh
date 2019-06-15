#!/bin/sh

NOT_THE_CAPS_YOURE_LOOKING_FOR="([A-Z0-9_]CAP_)|(CAP_HAS)|(CAP_NEEDS)|(CAP_ABOVE)|(CAP_ISA)|(CAP_NET_ADMIN)|(GETCAP)|(\!capable)|(AGP)|(PCI)"

grep CAP_ */*.c */*/*.c */*/*/*.c */*/*/*/*.c \
	| egrep -v "$NOT_THE_CAPS_YOURE_LOOKING_FOR" \
	| sed 's/^.*CAP_\([A-Z_]\+\)[,; )?\.].*$/CAP_\1/' \
	| uniq | sort | uniq

