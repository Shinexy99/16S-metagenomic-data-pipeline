#!usr/bin/perl
#################
#################
#################
my $exe=`which pick_open_reference_otus.py`;
if(!$exe)
     {
              die "Please Check if your pick_open_reference_otus.py installed\nOR Please Add it to your enviroment path\n";
                       }
                       chomp($exe);
                       my ($in,$out)=@ARGV;
                       $paraments="/opt/Pipeline/Database/16S.uc_fast_params.txt";
                       if(!$paraments)
                           {
                                   die "Please Check if the paraments file exit\n";
                                       }
                                       die "please check your input files\n[input fasta] [out put dir]\n" unless $#ARGV==1;
                                       open O,">pick_open_reference_otus.sh";
                                       print O "$exe -i $in -o $out -p $paraments -f\n";
                                      # print O "split_otu_table_by_taxonomy.py -i $out/otu_table_mc2_w_tax_no_pynast_failures.biom -L 3 -o $out/PROFILE/\n";
                                      # print O "summarize_taxa.py -i $out/otu_table_mc2_w_tax_no_pynast_failures.biom -o $out/PROFILE/\n";
                                      # print O "biom convert -i $out/otu_table_mc2_w_tax_no_pynast_failures.biom -o $out/Out.OTUs.profile --to-tsv --header-key taxonomy\n";
                                       close O;
                                       `sh pick_open_reference_otus.sh`;
                                       `rm -rf pick_open_reference_otus.sh`;
