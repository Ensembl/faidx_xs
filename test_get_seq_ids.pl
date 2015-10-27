
use Faidx ;
use strict ;
use warnings ;

Faidx::print_hello() ;

my $fasta = "t/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.I.fa.gz" ;
my $location = "I:1-100" ;
my $index = Faidx->new($fasta);

$index->get_all_sequence_ids();
