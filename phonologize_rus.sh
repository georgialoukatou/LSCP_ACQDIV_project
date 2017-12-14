#!/bin/sh
# Wrapper to take a single cleaned up transcript and phonologize it
# Alex Cristia alecristia@gmail.com 2015-10-26
# Modified by Laia Fibla laia.fibla.reixachs@gmail.com 2016-09-28 adapted to arg spanish
# Modified by Georgia Loukatou georgialoukatou@gmail.com 14-12-2017 adapted to russian

#########VARIABLES
#Variables to modify
LANGUAGE=$1 #language options: russian 
PATH_TO_CORPUS=$2
RES_FOLDER=$3

LC_ALL=C
#mkdir ${PATH_TO_CORPUS}/results

for ORTHO in ${PATH_TO_CORPUS}/clean_corpus.txt; do
	KEYNAME=$(basename "$ORTHO" .txt)

	#########
	if [ "$LANGUAGE" = "russian" ]
	   then
	  echo "recognized $LANGUAGE"
tr '[:upper:]' '[:lower:]'  < "$ORTHO"  |
	  sed 's/;eword//g'| 
	  sed 's/ $//g' | #
	  sed 's/^$//g' | #
	  sed 's/ʃ/S/g' |
	  sed 's/ʒ/3/g' |
	  sed 's/ɹ/R/g' |
	  sed 's/ŋ/N/g' |
	  sed 's/θ/V/g' |
	  sed 's/ʑ/Z/g' |
	  sed 's/ʐ/z/g' |	 
	  sed 's/ð/D/g' |
	  sed 's/β/v/g' |	 
     	  sed 's/ɽ/Q/g' |
	  sed 's/え/X/g' |
	  sed 's/ɭ/L/g' |
	  sed 's/ɘ/1/g' |
	  sed 's/oː/O/g' |
	  sed 's/uː/U/g' |
	  sed 's/eː/E/g' |
	  sed 's/ɜː/Y/g' |
	  sed 's/ɡ/g/g' |
	  sed 's/ɔː/0/g' |
	  sed 's/ɔ/W/g' |
	  sed 's/ɑː/A/g' |
	  sed 's/ɑ/B/g' |	  
     	  sed 's/iː/I/g' |
	  sed 's/ɐ/4/g' |
	  sed 's/ɔː/C/g' |
	  sed 's/ʌ/8/g' |
	  sed 's/ɛ/5/g' |
	  sed 's/ʊ/9/g' |
	  sed 's/ʲ/G/g' |
	  sed 's/ɒ/7/g' | 
	  sed 's/ɪ/6/g' | 
	  sed 's/ə/2/g' > $PATH_TO_CORPUS/intoperl.txt |

	  echo "syllabify-corpus.pl"
	  perl ./new-syllabify-corpus.pl russian $PATH_TO_CORPUS/intoperl.txt $PATH_TO_CORPUS/outofperl.txt .


	elif [ "$LANGUAGE" = "chintang" ]
		 then
		echo "recognized $LANGUAGE"
	tr '[:upper:]' '[:lower:]'  < "$ORTHO"  | #Spanish files have different encoding
		sed 's/ɨ̵ŋ/1H/g' |
		sed 's/ph/F/g' > ./intoperl.tmp

		echo "syllabify-corpus.pl"
		perl ./new-syllabify-corpus.pl russian intoperl.tmp outofperl.tmp $PATH_TO_SCRIPTS

	fi

		echo "removing blank lines"
		LANG=C LC_CTYPE=C LC_ALL=C
		sed 's/^\///g'  $PATH_TO_CORPUS/outofperl.txt |
		sed 's/^\///g' |
   		sed '/^ $/d'  |
                sed 's/।//g' |
                sed '/^[ ]*$/d'  |
                sed 's/^ //g'  |
                sed 's/^  //g' |
                sed 's/^ //g'  |
                sed 's/^\s//g'  |
		sed '/^ $/d'  |
		sed '/^[ ]*$/d'  |
		sed 's/^ //g'  |
		sed 's/?//g' |
		sed 's/।//g' |
		sed 's/\n//g' |
		sed 's/\.//g' |
 		sed 's/\,//g' |
		sed 's/^//g' |
		sed 's/=//g' |
		sed 's/(//g' |
		sed 's/)//g' |
		sed 's/#//g' |
		sed 's/\^//g' |
		sed 's/-/ /g' |
		#sed 's///g' |
		#sed 's/™//g' |
		sed 's/  / /g' |
		#sed 's/…//g' |
		sed 's/\!//g' |
		sed 's/_//g' |
		sed 's/://g' |
		sed 's/^\s//g' |
		sed 's/^\///g'  | #there aren't really any of these, this is just a cautionary measure
                sed 's/  / /g'|
                sed 's/  / /g'|
                sed 's/^\s//g' |
                sed 's/ \//\/ \//g'|
		sed 's/ $/\/ /g' |
                #sed 's/^\///g' |
                sed 's/^[ \t]*//g' |
                sed 's/^ //g' |
                sed 's/^\s//g'  |
		#sed 's/̌//g' |
		sed 's/^[[:space:]]//g' |
                sed 's/ /;eword/g' |
                sed 's/\//;esyll/g'|
                sed 's/;esyll ;esyll/;esyll/g' |
                #sed 's/ /;eword/g' |
                sed -e 's/\(.\)/\1 /g'  |
                sed 's/; e w o r d/ ;eword /g' |
                sed 's/; e s y l l/ ;esyll /g'|
                #sed 's/\// ;esyll /g'|
                sed 's/;eword $/;esyll ;eword$/g'|
                sed 's/  / /g'|
                sed 's/;eword ;esyll/;esyll ;eword/g'|
                sed 's/;esyll ;eword ;esyll/;esyll ;eword/g' |
                tr -s ' '  |
                sed 's/;esyll ;eword ;esyll/;esyll ;eword/g' |
                sed 's/^;esyll ;eword//g' |
                sed 's/^ ;esyll ;eword//g' |
                sed 's/^  ;esyll ;eword//g' |
                sed 's/^ //g' |
		sed 's/ɡ/g/g' > $PATH_TO_CORPUS/tmp.txt
		

		mv $PATH_TO_CORPUS/tmp.txt ${RES_FOLDER}/${KEYNAME}-tags.txt
		

	#echo "creating gold version"
	
	sed 's/;esyll//g'  < ${RES_FOLDER}/${KEYNAME}-tags.txt |
		tr -d ' ' |
		sed 's/;eword/ /g' > ${RES_FOLDER}/${KEYNAME}-gold.txt

done

