
use Faidx ;
use strict ;
use warnings ;

Faidx::print_hello() ;

my $fasta = "t/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.I.fa.gz" ;
my $index = Faidx->new($fasta);

my @seq_id_list = $index->get_all_sequence_ids();
my $seq_count = 0 ;
for my $seq (@seq_id_list)
{
  $seq_count++ ;
  print "$0:sequence id:$seq_count:".$seq."\n" ;
}


$fasta = "/home/rishi/data/faidx/Xiphophorus_maculatus.Xipmac4.4.2.dna_rm.toplevel.fa.gz" ;
$index = Faidx->new($fasta);
@seq_id_list = $index->get_all_sequence_ids();
$seq_count = 0 ;
for my $seq (@seq_id_list)
{
  $seq_count++ ;
  print "$0:sequence id:$seq_count:".$seq."\n" ;
}
