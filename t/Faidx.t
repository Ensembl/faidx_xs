# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Faidx.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;

use Test::More tests => 4 ;
BEGIN { use_ok('Faidx') } ;

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

ok(1) ;
Faidx::print_hello() ;
ok(1) ;

my $fasta = "t/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.I.fa.gz" ;
my $location = "I:1-100" ;
my $index = Faidx->new($fasta);

my $seq = "" ;
my $length = 0 ;
($seq, $length) = $index->get_sequence($location);
warn $seq;
warn $length;

ok(1) ;


