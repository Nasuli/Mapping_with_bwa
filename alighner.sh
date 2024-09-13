#!/bin/bash
mkdir ./Results
#aligning reads to genomes
cat list_of_samples.txt | while read line; do
	NAME=`echo $line | tr "." " " | awk '{print $1}'`
	echo "work with sample $i"
	if [ ! -f "Results/$NAME-2units_apr_24.sorted.bam" ]; then
		echo "Folder $NAME-2units_apr_24 does not exist. Do aligning..."
		bwa aln -t 12 ./MpDNV_updated_refs_apr_24/MpDNV_113-130_2units_apr_24.fna raw_reads/$line > $NAME-2units_apr_24.sai
		bwa samse ./MpDNV_updated_refs_apr_24/MpDNV_113-130_2units_apr_24.fna $NAME-2units_apr_24.sai raw_reads/$line > $NAME-2units_apr_24.sam
		samtools sort -@ 12 $NAME-2units_apr_24.sam -o $NAME-2units_apr_24.sorted.bam
		samtools index $NAME-2units_apr_24.sorted.bam
		rm $NAME-2units_apr_24.sam $NAME-2units_apr_24.sai
		mv $NAME-2units_apr_24.* ./Results/ 
	else
		echo "We already have this file: Results/$NAME-2units_apr_24"
	fi
done
