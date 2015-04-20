use strict;
use warnings;

use Faidx ;

Faidx::print_hello() ;

my $fasta = "t/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.I.fa.gz" ;
my $location = "I:90-200" ;
my $index = Faidx->new($fasta);

my $seq = "" ;
my $length = 0 ;
my $hs = $index->has_sequence($location);
print( "HAS SEQUENCE:$hs\n" ) ;

($seq, $length) = $index->get_sequence($location);
warn $seq;
warn $length;



