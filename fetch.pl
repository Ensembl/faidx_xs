# Copyright [1999-2016] Wellcome Trust Sanger Institute and the EMBL-European Bioinformatics Institute
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# A basis for quick testing and example code on using FAIDX
#

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
$fasta = "Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz" ;
$location = "2:44000-45133" ;

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



$length = $index->length("2") ;
print( "$location:LENGTH(length 2):$length\n" ) ;
