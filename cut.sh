#!/bin/sh
# This script cuts the concatenated coprus into a choosen number of parts
# Here, 10 sub-parts to perform several analysis of variance.
# Laia Fibla laia.fibla.reixachs@gmail.com 2017-03-22
# Modified by Georgia Loukatou georgialoukatou@gmail.com 14-12-2017 

##### Variables #####

input=$1 # Path already provided by the used, otherwise, include absolute paths
output=$2
namefile=$3
outputnamefile=$4
divide=10 # Modify this line to divide the corpus in a specific number of sub-parts

####################

mkdir -p ${output}

for f in $input/${namefile}
do
  max=`wc -l $f | grep -v "total" | awk '{print $1}'`
  n=$(( $max / $divide ))

  i=0
  while [ $i -lt $divide ]
  do
  rm -r ${output}/${i}/*
  mkdir -p ${output}/${i}
  echo in while $i
      ini=$(( $i * $n + 1 ))
      fin=$(( $ini + $n - 1 ))
      sed -n ${ini},${fin}p ${input}/${namefile} >> ${output}/${i}/${outputnamefile}
  i=$(($i + 1 ))
  done
done

echo $output

