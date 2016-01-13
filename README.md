# Faidx version 1.1

This is a Perl XS interface into the FAIDX component of htslib.

This interface has now been integrated into Bio-HTS which is available from https://github.com/Ensembl/Bio-HTS or on CPAN at http://search.cpan.org/dist/Bio-DB-HTS/ (v1.04). The FAIDX functionality is in Bio::DB::HTS::Faidx. Bio-HTS is where future maintenance and additional updates will occur.

## INSTALLATION

To install this module type the following:
```
perl Makefile.PL
make
make test
make install
```

## DEPENDENCIES

This module requires these other modules and libraries:

HTSLIB available from http://htslib.org


## COPYRIGHT AND LICENCE

This library is based on the Apache License Version 2.0
http://www.apache.org/licenses/

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.14.2 or,
at your option, any later version of Perl 5 you may have available.
