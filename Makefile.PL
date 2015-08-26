use 5.014002;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Faidx',
    VERSION_FROM      => 'lib/Faidx.pm', # finds $VERSION
    PREREQ_PM         => {}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Faidx.pm', # retrieve abstract from module
       AUTHOR         => 'Rishi Nag <rishi@ebi.ac.uk>') : ()),
    LIBS              => ['-L../htslib/ -lhts  -lz'], 
    DEFINE            => '-g -Wall -O2 -D_FILE_OFFSET_BITS=64 -D_LARGEFILE64_SOURCE -D_CURSES_LIB=1 ', 
    INC               => '-I.  -I../htslib', 

);
