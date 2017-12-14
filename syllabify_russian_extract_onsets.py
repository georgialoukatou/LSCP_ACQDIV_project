#!/usr/bin/env python
#Georgia Loukatou, georgialoukatou@gmail.com, 14-12-2017
#Extracts real onsets from Russian acqdiv corpus

import re
import numpy as np
import fileinput
from tempfile import mkstemp
from shutil import move
from os import fdopen, remove
import sys

INPUT=sys.argv[1]
OUTPUT=sys.argv[2]

list1=[]

f = open(sys.argv[1])

for line in f:
	onsets=re.findall(r'\;eword\s([b|c|d|f|g|h|j|k|l|m|n|p|q|r|s|t|v|w|x|z|ʃ|ʒ|ɹ|θ|ŋ|ʑ|ð|ɭ]*)', line)
	for i in onsets:
	 if i !='':
	  if i not in list1:
	  	list1.append(i)
	onsets1=re.findall(r'^([b|c|d|f|g|h|j|k|l|m|n|p|q|r|s|t|v|w|x|z|ʃ|ʒ|ɹ|θ|ŋ|ʑ|ð|ɭ]*)', line)
	for y in onsets1:
	  if y !='':
	   if y not in list1:
	  	 list1.append(y)


outfile = open(sys.argv[2], "w")
outfile.write("\n".join(str(i) for i in list1))
outfile.close()

