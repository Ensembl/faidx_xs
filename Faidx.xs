#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include <stdio.h>

void print_hello()
{
  printf( "Hello World\n" ) ;
}

MODULE = Faidx		PACKAGE = Faidx		

void
print_hello()




