
use Faidx ;
use strict ;
use warnings ;

Faidx::print_hello() ;

my $fasta = "t/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.I.fa.gz" ;
my $index = Faidx->new($fasta);
$index->get_all_sequence_ids();


$fasta = "/home/rishi/data/faidx/Xiphophorus_maculatus.Xipmac4.4.2.dna_rm.toplevel.fa.gz" ;
$index = Faidx->new($fasta);
$index->get_all_sequence_ids();
