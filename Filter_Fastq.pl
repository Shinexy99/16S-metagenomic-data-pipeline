#!usr/bin/perl
###############
###############
############################################################################################################
##reference split_libraries_fastq.py -i SRR5075804_1.fastq 
##                                  --sample_ids SRR5075806 
##                                                          -o slout_not_multiplexed_q20/ 
##                                                          -q 19 --phred_offset 33 
##                                                          --barcode_type 'not-barcoded'
##############################################################################
$exe=`which split_libraries_fastq.py`;
if(!$exe)
    {
              die "you need to check if your join_paired_ends.py added into the Environment Path\n";
    }
                      else{chomp($exe);}
#                      ##############################################################################
#                      ##############################################################################
                      die "Usage:\nperl 02.filtered_fastq.pl [fq] [ID]\nPlease Check your input files\n" unless $#ARGV==1;
                      my ($fq,$id)=@ARGV;
                      `mkdir -p $id` unless -e "$id";
                      open O,">$id/filtered_fastq.sh";
                      print O "$exe -i $fq --sample_ids $id -o filtered_Q20/ -q 19 --phred_offset 33 --barcode_type 'not-barcoded'\n";
                      print O "mv filtered_Q20/seqs.fna $id.fna\n";
                      print O "mv filtered_Q20/split_library_log.txt $id.split.log\n";
                      print O "adjust_seq_orientation.py -i $id.fna\n";
                      print O "identify_chimeric_seqs.py -i $id\_rc.fna -m usearch61 -o $id\_checked_chimeras/ -r /opt/Pipeline/Database/gg_13_8_otus/rep_set/97_otus.fasta\n";
                      print O "filter_fasta.py -f $id\_rc.fna -o $id.filtered.fna -s $id\_checked_chimeras/chimeras.txt -n\n";
                      #print O "cat *.filtered.fna >all.fna\n";
                      print O "rm -rf filtered_Q20\n";
                      close O;
                      chdir "$id";
                      system ('sh filtered_fastq.sh');
                      `rm -rf filtered_fastq.sh`;
