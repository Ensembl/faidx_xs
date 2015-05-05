use strict;
use warnings;

use Faidx ;

Faidx::print_hello() ;

my $fasta = "t/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.I.fa.gz" ;
my $location = "I" ;
my $index = Faidx->new($fasta);

my $seq = "" ;
my $length = 0 ;
my $hs = $index->has_sequence($location);
print( "$location HAS SEQUENCE:$hs\n" ) ;

($seq, $length) = $index->get_sequence($location);
print( "$location GET SEQUENCE(seq):$seq\n" ) ;
print( "$location GET SEQUENCE(length):$length\n" ) ;

$length = $index->length("I") ;
print( "I:LENGTH(length):$length\n" ) ;



#now test on other sequences
print ("\n\n********TEST 2******\n") ;
$fasta = "/lustre/scratch109/ensembl/rn6/vep_tutorial/homo_sapiens/79_GRCh38/22/31000001-32000000.gz" ;
$location = "22:31000001-31000201" ;
my $index2 = Faidx->new($fasta);

$seq = "" ;
$length = 0 ;

$length = $index2->length("22") ;
print( "chr22:LENGTH(length):$length\n" ) ;







