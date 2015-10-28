
use Faidx ;
use strict ;
use warnings ;

Faidx::print_hello() ;

my $fasta = "t/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.I.fa.gz" ;
my $index = Faidx->new($fasta);
my @seq_id_list = $index->get_all_sequence_ids();
print scalar @seq_id_list ;
print( " seq ids found\n" ) ;


for my $seq (@seq_id_list)
{
  print "sequence id found:".$seq."\n" ;
}


$fasta = "/home/rishi/data/faidx/Xiphophorus_maculatus.Xipmac4.4.2.dna_rm.toplevel.fa.gz" ;
$index = Faidx->new($fasta);
@seq_id_list = $index->get_all_sequence_ids();
print scalar @seq_id_list ;
print( " seq ids found\n" ) ;
