use strict;
use warnings;

use Faidx ;

Faidx::print_hello() ;

#test on a yeast item
print ("\n\n********TEST 1******\n") ;
my $fasta = "t/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.I.fa.gz" ;
my $location = "I:1-100" ;

my $index = Faidx->new($fasta);

my $seq = "" ;
my $length = 0 ;
my $hs = $index->has_sequence($location);

($seq, $length) = $index->get_sequence($location);
print( "$location GET SEQUENCE(seq):$seq\n" ) ;
print( "$location GET SEQUENCE(length):$length\n" ) ;

$length = $index->length($location) ;
print( "$location:LENGTH(length):$length\n" ) ;

$length = $index->length("I") ;
print( "I:LENGTH(I):$length\n" ) ;


#test on human sequence
print ("\n\n********TEST 2******\n") ;
$fasta = "/nfs/users/nfs_r/rn6/myscratch9/vep_htslib/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz" ;
$location = "22:2000-2133" ;

$index = Faidx->new($fasta);

$seq = "" ;
$length = 0 ;

print("\n***TEST \$seq, \$length" ) ;
($seq, $length) = $index->get_sequence($location);
print( "$location GET SEQUENCE(seq):$seq\n" ) ;
print( "$location GET SEQUENCE(length):$length\n" ) ;

print("\n***TEST \@single\n" ) ;
my @single = $index->get_sequence($location);
print( "$location GET SEQUENCE(s): $single[0]\n" ) ;
print( "$location GET SEQUENCE(length): $single[1]\n" ) ;

print("\n***TEST \$single\n" ) ;
my $single = $index->get_sequence($location);
print( "\nWhat does it print?\n$single\n" ) ;



$length = $index->length("22") ;
print( "$location:LENGTH(length 22):$length\n" ) ;









