#!/bin/sh
# Wrapper to take a single cleaned up transcript and phonologize it
# Alex Cristia alecristia@gmail.com 2015-10-26
# Modified by Laia Fibla laia.fibla.reixachs@gmail.com 2016-09-28 adapted to arg spanish
# Modified by Georgia Loukatou georgialoukatou@gmail.com 2017-04-02 adapted to chintang, japanese 


#########VARIABLES
#Variables to modify
LANGUAGE=$1
PATH_TO_SCRIPTS=$2
RES_FOLDER=$3

LC_ALL=C

for ORTHO in ${RES_FOLDER}/divided_corpus.txt; do
	KEYNAME=$(basename "$ORTHO" .txt)

	#########
	if [ "$LANGUAGE" = "Japanese" ]
	   then
	  echo "recognized $LANGUAGE"
tr '[:upper:]' '[:lower:]' < "$ORTHO"  | 
	  sed 's/ $//g' | #
	  sed 's/^$//g' | #
	 sed 's/_PRES//g'|
         sed 's/_IMP//g'|
          sed 's/_ADV//g'|
           sed 's/_SGER//g'|
           sed 's/_NEG//g'|
           sed 's/_POL//g'|
           sed 's/_CONN//g'|
           sed 's/_PAST//g'|
           sed 's/_COND//g'|
           sed 's/_PASS//g' |
           sed 's/_QUOT//g'|
           sed 's/_CAUS//g'|
           sed 's/&PRE//g' |
           sed 's/&PRES//g' |
           sed 's/&IMP//g'|
           sed 's/&ADV//g'|
           sed 's/&SGER//g'|
           sed 's/&NEG//g' |
           sed  's/&POL//g' |
           sed 's/&CONN//g' |
           sed 's/&PAST//g'|
           sed 's/&COND//g'|
           sed 's/&PASS//g' |
           sed 's/&QUOT//g' |
    	   sed 's/&CAUS//g' |
          sed 's/NA//g' |
	  sed 's/ch/C/g' | #
	  sed 's/tt/T/g' |
	  sed 's/kk/K/g' |
	  sed 's/gg/G/g' |
	  sed 's/ss/S/g' |
	  sed 's/nn/N/g' |
	  sed 's/pp/P/g' |
	 # sed 's/NA//g' |
	  sed 's/ʃ/J/g' |
	  sed 's/ŋ/H/g' |
	  sed 's/sy/W/g' |
	  sed 's/zy/Q/g' |
	  sed 's/ty/D/g' |
	  sed 's/ɽ/R/g' |
	  sed 's/ʒ/3/g' |
	  sed 's/え/X/g' |
	  sed 's/θ/V/g' |
	  sed 's/my/M/g' |
	  sed 's/ry/R/g' |
	  sed 's/dy/9/g' |
	  sed 's/gy/B/g' |
	  sed 's/hy/F/g' |
	  sed 's/ny/L/g' |
	  sed 's/sh/Z/g' |
	  sed 's/aa/A/g' |
	  sed 's/ii/I/g' |
	  sed 's/ee/E/g' |
	  sed 's/oo/O/g' |
	  sed 's/uu/U/g' |
	  sed 's/ai/7/g' |
	  sed 's/oi/4/g' |
	  sed 's/au/5/g' |
	  sed 's/ɘ/1/g' |
	  sed 's/o:/O/g' |
	  sed 's/u:/U/g' |
	  sed 's/e:/E/g' |
	  sed 's/a:/A/g' |
	  sed 's/i:/I/g' |
	  sed 's/ei/E/g' |
	  sed 's/^\s//g' |
	  sed 's/ə/2/g' > $RES_FOLDER/intoperl.tmp

	  echo "syllabify-corpus.pl"
	  perl $PATH_TO_SCRIPTS/new-syllabify-corpus.pl $LANGUAGE $RES_FOLDER/intoperl.tmp $RES_FOLDER/outofperl.tmp $PATH_TO_SCRIPTS


	elif [ "$LANGUAGE" = "Chintang" ]
		 then
		echo "recognized $LANGUAGE"
	tr '[:upper:]' '[:lower:]'  < "$ORTHO"  | 
		sed 's/jh/9/g' |
		sed 's/̟c/c/g' |
		sed 's/ɨ̵ŋ/1H/g' |
		sed 's/ǃ//g'  |
		sed 's/ɨ/1/g' |
		sed 's/̌à/a/g' |
		sed 's/u̪/u/g'|
		sed 's/[àãâāåà]/a/g' |
		sed 's/ei/2/g' |
		sed 's/ai/3/g' |
		sed 's/oi/4/g' |
		sed 's/ui/5/g' |
		sed 's/au/6/g' |
		sed 's/1i/7/g' |
		sed 's/ñ/N/g' |
		sed 's/aa/a/g' |
		sed 's/ee/e/g' |
		sed 's/oo/o/g' |
		sed 's/ii/i/g' |
		sed 's/uu/u/g' |
		sed 's/[ā]/a/g' |
		sed 's/[ũùûùü]/u/g' |
		sed 's/[ôò]/o/g' |
		sed 's/[èẽë]/e/g' |
		sed 's/[ĩīĩ]/i/g' |
		#sed 's/jh//g' |
		sed 's/kk/K/g' |
		sed 's/tt/T/g' | # substitute all ch by tS	
		sed 's/cc/C/g' |
		sed 's/bb/B/g' |
		sed 's/ss/S/g' |
		sed 's/nn/N/g' |
		sed 's/ñ/N/g' |
		sed 's/mm/M/g' |
		sed 's/jj/J/g' |
		sed 's/lh/L/g' | # substitute the spanish rr by 5
		sed 's/gh/G/g' | # substitue the initial r for R
		sed 's/pp/P/g' | # substitue the initial r for R
		sed 's/dh/D/g' |
		sed 's/ḍ/D/g' |
		sed 's/ch/Y/g' |
		#sed 's/jh/Ζ/g' |
		sed 's/bh/V/g' | # removing h
		sed 's/kh/Q/g' |
		sed 's/th/X/g' |
		sed 's/ʔ/q/g' |
		sed 's/ṽ/w/g' |
		sed 's/ŋ/H/g' |
		sed 's/�/W/g' |
		sed 's/m̄/m/g' |
		sed 's//W/g' |
		sed 's/Ḧ/H/g' |
		sed 's/Ë/e/g' |
		sed 's/ɲ/N/g' |
		sed 's/hAA̴/ha/g' |
		sed 's/¨//g'  |
		sed 's/Œ ñ//g' |
		sed 's/Œ £//g' |
		sed 's/‡ • §//g' |
		sed 's/̵//g'  |
		sed 's/̪//g'  |
		sed 's/~//g'  |
		sed 's/ʌ//g'  |
		sed 's/˜//g'  |
		sed 's/।//g'  |
		sed 's/̴̴//g'  |
		sed 's/"//g'  |
		sed 's/̴//g'  |
		sed 's/±//g'  |
		sed 's/lUɡE//g' |
		sed 's/IɡIMA//g' |
		sed 's/iɡiMa//g' |
		sed 's/hu̪i/hui/g' |
		sed 's/hãǃ/ha/g' |
		sed 's/ɨ̵ŋ/1H/g' |
		sed 's/luɡe//g' |
		sed 's/ph/F/g' > $RES_FOLDER/intoperl.tmp

		echo "syllabify-corpus.pl"
		perl $PATH_TO_SCRIPTS/new-syllabify-corpus.pl $LANGUAGE $RES_FOLDER/intoperl.tmp $RES_FOLDER/outofperl.tmp $PATH_TO_SCRIPTS

	fi

		echo "removing blank lines"
		LANG=C LC_CTYPE=C LC_ALL=C
		sed '/^$/d' $RES_FOLDER/outofperl.tmp |
		sed 's/_PRES//g'|
		sed 's/_IMP//g'|
		sed 's/_ADV//g'| 
		sed 's/_SGER//g'|
		sed 's/_NEG//g'|
		sed 's/_POL//g'|
		sed 's/_CONN//g'|
		sed 's/_PAST//g'|
		sed 's/_COND//g'|
		sed 's/_PASS//g' |
		sed 's/_QUOT//g'| 
		sed 's/_CAUS//g'| 
		sed 's/&PRE//g' |
		sed 's/&PRES//g' |
		sed 's/&IMP//g'| 
		sed 's/&ADV//g'|
		sed 's/&SGER//g'| 
		sed 's/&NEG//g' |
		sed  's/&POL//g' | 
		sed 's/&CONN//g' |
		sed 's/&PAST//g'|
		sed 's/&COND//g'|
		sed 's/&PASS//g' | 
		sed 's/&QUOT//g' |
		sed 's/&CAUS//g' | 
		sed 's/NA//g' |
		sed 's/\^//g' | 
		sed "s/\'//g" |
		sed 's/)//g' |
		sed  's/(//g' |
		sed 's/&//g' | 
		sed '/^ $/d'  |
		sed 's/।//g' |
		sed '/^[ ]*$/d'  |
		sed 's/^ //g'  |
		sed 's/^  //g' |		
		sed 's/^ //g'  |
		sed 's/^\s//g'  |		
		sed 's/?//g' |
		sed 's/\n//g' |
		sed 's/^//g' |
		sed 's/«a/a/g' |
		sed 's/å/a/g' |
		sed 's/\.//g' |
 		sed 's/\,//g' |
 		sed 's/̌//g' |
 		sed 's/‡//g' |
 		sed 's/§//g' |
 		sed 's/̟//g' |
		sed 's/^//g' |
		sed 's/=//g' |
		sed 's/-//g' |
		sed 's/™//g' |
		sed 's/ü//g' |
		sed 's/  / /g' |
		sed 's/…//g' |
		sed 's/\!//g' |
		sed 's/_//g' |
		#sed 's/\'//g' |		
		sed 's/://g' |
		sed 's/a?//g' |
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
                sed 's/^[[:space:]]//g'	|	
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
		sed 's/^;esyll ;eword//g' > $RES_FOLDER/tmp.tmp
	
		mv $RES_FOLDER/tmp.tmp ${RES_FOLDER}/clean_corpus-tags.txt

	echo "creating gold versions"

		sed -e 's/;esyll//g' -e 's/?//g' < ${RES_FOLDER}/clean_corpus-tags.txt |
		tr -d ' ' |
		sed -e's/;eword/ /g'  -e 's/?//g' > ${RES_FOLDER}/clean_corpus-gold.txt


done



echo "end"
