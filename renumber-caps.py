#!/usr/bin/python

import re
import sys

# Matches the definition of a capability right (e.g. CAP_READ).
cap = re.compile('^#define.*CAP_.*0x[01248]+ULL')

# Matches the mask of all valid capabilities.
mask = re.compile('^#define.*CAP_MASK_VALID.*0x.*ULL')

# The value to #define the next capability right as (1, 2, 4, 8, 10, ...).
value = 1

f = file(sys.argv[1], 'r')
for line in f.readlines():
	line = line.rstrip()

	if cap.match(line):
		(_,name,_) = line.split()[:3]
		comment = ""
		if '/*' in line:
			comment = '\t' + line[line.find('/*'):]

		space = '\t' * (3 - (len(name) / 8))
		line = '#define\t%s%s0x%016xULL%s' % (
			name, space, value, comment)

		value = value << 1

	elif mask.match(line):
		# 'value' is currently 2 * the largest CAP_ definition.
		# Thus, a mask of all CAP_ definitions is just (value - 1).
		line = '#define\tCAP_MASK_VALID\t\t0x%016xULL' % (value - 1)

	print line

