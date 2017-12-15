#!/bin/bash

#Georgia Loukatou, georgialoukatou@gmail.com, 14-12-2017 


LANGUAGE=$1
LEVEL=$2
ROOT=$3

DIR="${ROOT}/${1}/${2}"
RES="${DIR}/results"

i=0 #To change if Japanese, Russian

######
for SEGMENT in $DIR/concatenate/*
do
echo $SEGMENT

i=$(expr $i + 1)

#results with all TP versions separately
sed "s/$/,FTP_rel,$i/g" < $SEGMENT/results/eval.ftp_rel.txt > $SEGMENT/results/eval.ftp_rel_typeadded.txt
sed "s/$/,BTP_rel,$i/g" < $SEGMENT/results/eval.btp_rel.txt > $SEGMENT/results/eval.btp_rel_typeadded.txt
sed "s/$/,BTP_abs,$i/g" < $SEGMENT/results/eval.btp_abs.txt > $SEGMENT/results/eval.btp_abs_typeadded.txt
sed "s/$/,FTP_abs,$i/g" < $SEGMENT/results/eval.ftp_abs.txt > $SEGMENT/results/eval.ftp_abs_typeadded.txt

#at the same file all TP results for each subpart
cat ${SEGMENT}/results/eval.*typeadded.txt >> ${SEGMENT}/results/eval.tp_typeadded.txt

#take only token fscores
sed -e  's/\s/,/g' -e '/^token_fscore/!d' < $SEGMENT/results/eval.tp_typeadded.txt > $SEGMENT/results/temp0.csv

#remove all other information and add language, algorithm, level
cut -d, -f1 --complement < $SEGMENT/results/temp0.csv > $SEGMENT/results/temp1.csv
sed "s/^/$LANGUAGE,TPs,$LEVEL,/g" < $SEGMENT/results/temp1.csv > $SEGMENT/results/eval.tp_type.csv


##############################
#AG results(old wordseg)
sed -e  's/\s/,/g' -e '/token/d' -e "s/$/AGu,$i/g" -e "s/^/$LANGUAGE,AGu,$LEVEL,/g" < $SEGMENT/results/AGu/cfgold-res.txt >$SEGMENT/results/eval.ag_typeadded.txt
cut -d, -f5-9 --complement < $SEGMENT/results/eval.ag_typeadded.txt > $SEGMENT/results/eval.ag_type.csv


#######################
#DiBS results(new)
sed "s/$/,dibs,$i/g" < $SEGMENT/results/eval.dibs.txt >> $SEGMENT/results/eval.dibs_typeadded.txt
sed -e  's/\s/,/g' -e '/^token_fscore/!d' < $SEGMENT/results/eval.dibs_typeadded.txt > $SEGMENT/results/dibstemp0.csv
cut -d, -f1 --complement < $SEGMENT/results/dibstemp0.csv > $SEGMENT/results/dibstemp1.csv
sed "s/^/$LANGUAGE,dibs,$LEVEL,/g" < $SEGMENT/results/dibstemp1.csv > $SEGMENT/results/eval.dibs_type.csv
done

#add TP scores of all subparts in a results folder at $DIR
mkdir $DIR/results
cat $DIR/concatenate/*/results/eval.tp_type.csv >> $DIR/results/all_eval.tp_type.csv
cat $DIR/concatenate/*/results//eval.ag_typeadded.csv >> ${RES}/all_eval.AGu_type.csv
cat $DIR/concatenate/*/results//eval.dibs_type.csv >> ${RES}/all_eval.dibs_type.csv


#results with average TP versions

#cat ${SEGMENT}/results/eval.*tp_*.txt >> ${SEGMENT}/results/temp.txt
#sed -e  's/\s/,/g' -e '/^token_fscore/!d' < $SEGMENT/results/temp.txt > $SEGMENT/results/temp.csv
#cut -d, -f1 --complement < $SEGMENT/results/temp.csv > $SEGMENT/results/temp1.csv
#awk '{s+=$1} {av=0} {av=s/4} END {print av}' < $SEGMENT/results/temp1.csv  > $SEGMENT/results/temp2.csv # use this if you want the average of TPs versions
#sed "s/^/$LANGUAGE,TPs,$LEVEL,/g" < $SEGMENT/results/temp2.csv > $SEGMENT/results/eval.tp.csv
#done
#cat $DIR/concatenate/*/results/eval.tp.csv >> $DIR/results/all_eval.tp.csv

#statistics
#sed '/^\(corpus entropy\|words token\/types\|words tokens\/utt\|syllables tokens\/word\|syllables tokens\/utt\|syllables token\/types\|phones tokens\/utt\|phones tokens\/syllable\|phones tokens\/word\|phones token\/types\)/!d' < $SEGMENT/descript_regression.txt
#sed -i -e 's/s e/s_e/g' -e 's/s t/s_t/g' $SEGMENT/descript_regression.txt
#sed -i  's/\s/,/g' $SEGMENT/descript_regression.txt
#cut -d, -f1 --complement < $SEGMENT/descript_regression.txt > $SEGMENT/descript_regression2.txt
#echo $(cat $SEGMENT/descript_regression2.txt) >> $SEGMENT/rows.txt
#sed -i 's/\s/,/g'  $SEGMENT/rows.txt

#baseline_syllables
#cat ${SEGMENT}/results/eval.baseline_syll.txt >> $DIR/temps.txt
#sed -e  's/\s/,/g' -e '/^token_fscore/!d' < $DIR/temps.txt > $DIR/temps.csv
#cut -d, -f1 --complement < $DIR/temps.csv > $DIR/temp1s.csv
#sed "s/^/$LANGUAGE,base_syll,$LEVEL,/g" < $DIR/temp1s.csv > $DIR/eval.baseline_syll.csv
#done
#cat $DIR/concatenate/*/results/eval.baseline.csv >> $DIR/results/all_eval.baseline.csv


#merge all
cat ${RES}/all_eval*type.csv >> ${RES}/merged_eval_${LANGUAGE}_${LEVEL}.csv
cp ${ROOT}/Chintang/utterance/results/merged_eval_${LANGUAGE}_${LEVEL}.csv ${ROOT}/
