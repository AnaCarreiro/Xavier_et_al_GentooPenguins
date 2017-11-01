#!/bin/bash

###Script to prepare reads###

#software used: cutadapt

####################################################################################################################################################################################

###Start of commands###

####################################################################################################################################################################################


###Demultiplex by 12S, 16S and 18S###

echo "Demultiplexing by Forward "

cutadapt -g file:Foward_barcodes.fasta -o {name}.fasta All_reads.fasta -e 0.1


###Demultiplex by Old and Fresh###

echo "Demultiplexing by Reverse primer and Filtering"

cutadapt -a file:Reverse_barcodes_12S.fasta -o 12SFish.{name}.fasta 12SFish.fasta -e 0.1 --minimum-length 240 --maximum-length 269

cutadapt -a file:Reverse_barcodes_16S.fasta -o 16SEuph.{name}.fasta 16SEuph.fasta -e 0.1 --minimum-length 100 --maximum-length 128

cutadapt -a file:Reverse_barcodes_18S.fasta -o 18SBilSS.{name}.fasta 18SBilSS.fasta -e 0.1 --minimum-length 180 --maximum-length 201


echo "Finished"




