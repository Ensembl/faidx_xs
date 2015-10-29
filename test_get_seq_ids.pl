
use Faidx ;
use strict ;
use warnings ;

Faidx::print_hello() ;

my $fasta = "t/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.I.fa.gz" ;
my $index = Faidx->new($fasta);
my @seq_id_list = $index->get_all_sequence_ids();

local $| = 1;

print( "$0: ") ;
print scalar @seq_id_list ;
print( " seq ids found\n" ) ;


for my $seq (@seq_id_list)
{
  print "$0:sequence id found:".$seq."\n" ;
}


$fasta = "/home/rishi/data/faidx/Xiphophorus_maculatus.Xipmac4.4.2.dna_rm.toplevel.fa.gz" ;
$index = Faidx->new($fasta);
my $seq_id_list = $index->get_all_sequence_ids();
print( "$0: ") ;
print scalar @{$seq_id_list} ;
print( " seq ids found\n" ) ;

my $seq_count = 0 ;
for my $seq (@{$seq_id_list})
{
  $seq_count++ ;
  print "$0:sequence id $seq_count found:".$seq."\n" ;
}


my @seq_id_list_array = $index->get_all_sequence_ids_array();
$seq_count = 0 ;
for my $seq (@seq_id_list_array)
{
  $seq_count++ ;
  print "$0:sequence id from array $seq_count found:".$seq."\n" ;
}
