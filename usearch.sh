#!/bin/bash
###Script for OTUs clustering###

#software used: Usearch

software=~/bin

usearch= $software/usearch10.0.240

####################################################################################################################################################################################
###Start of commands###
####################################################################################################################################################################################
###Uniques###
echo "Identifying Uniques"

$usearch -fastx_uniques merged12S.fas -fastaout uniques12S.fasta -relabel Uniq -sizeout
$usearch -fastx_uniques merged16S.fas -fastaout uniques16S.fasta -relabel Uniq -sizeout
$usearch -fastx_uniques merged18S.fas -fastaout uniques18S.fasta -relabel Uniq -sizeout

##OTU's##
echo "Clustering OTUs"

#For 12S is a 97% clustering - UPARSE algorithm

echo "12S"

$usearch -cluster_otus uniques12S.fasta -minsize 2 -otus otus12S.fasta -relabel Otu

$usearch -usearch_global merged12S.fas -db otus12S.fasta -strand plus -id 0.97 -otutabout otutable12S.txt


#For 16S and 18S is a 99% clustering - UNOISE algorithm
echo "16S"

$usearch -unoise3 uniques16S.fasta -zotus otus100_16S.fasta -minsize 4

$usearch -sortbylength zotus100_16S.fasta -fastaout zotus100_16S-len.fasta

$usearch -cluster_smallmem zotus100_16S-len.fasta -id 0.99 -relabel Zotus -centroids zotus_16S.fasta 

$usearch -usearch_global merged16S.fas -db zotus_16S.fasta -strand plus -id 0.97 -otutabout zotutable_16S.txt
echo "18S"

$usearch -unoise3 uniques18S.fasta -zotus zotus100_18S.fasta -minsize 4

$usearch -sortbylength zotus100_18S.fasta -fastaout zotus100_18S-len.fasta

$usearch -cluster_smallmem zotus100_18S-len.fasta -id 0.99 -relabel Zotus -centroids zotus_18S.fasta 

$usearch -usearch_global merged18S.fas -db zotus_18S.fasta -strand plus -id 0.97 -otutabout zotutable_18S.txt

echo "finished"