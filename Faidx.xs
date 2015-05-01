#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include <stdio.h>

#include "htslib/faidx.h"
#ifndef Newx
#  define Newx(v,n,t) New(0,v,n,t)
#endif


void print_hello()
{
  printf( "Hello World from the Faidx XS module\n" ) ;
}

// Code is written to use a blessed int pointer to this strut as an object
// You cannot use Data::Dumper to inspect the Faidx object. Sorry
typedef struct 
{
  char* path;
  faidx_t* index;
} Faidx ;


SV* new(const char * classname, const char * path) 
{
  Faidx   * faidx;
  SV      * obj;
  SV      * obj_ref;
  faidx_t * fai;
  
  Newx(faidx, 1, Faidx);
  
  fai = fai_load(path);
  faidx->path = savepv(path);
  faidx->index = fai;
  printf( "Making New Object\n" ) ;
  obj = newSViv((IV)faidx);
  obj_ref = newRV_noinc(obj);
  printf( "obj address %p\n", &obj ) ;
  sv_bless(obj_ref, gv_stashpv(classname, GV_ADD));
  SvREADONLY_on(obj);

  return obj_ref;
}


void get_sequence(SV* obj, SV* location, SV** seq, int* seq_len) 
{
  faidx_t *fai;
  char* char_seq;
  
  *seq = newSVpvn("",0);
  *seq_len = 0;
  
  fai = ((Faidx*)SvIV(SvRV(obj)))->index;
  //Fetch sequence
  printf( "get_sequence:Going to fetch sequence\n" ) ;
  /* char *fai_fetch(const faidx_t *fai, const char *reg, int *len); */
  char_seq = fai_fetch(fai, SvPV(location, PL_na), seq_len);
  printf( "\tget_sequence: Sequence obtained in XS function is:%s\n", char_seq ) ;

  //Push into a SV
  sv_catpv(*seq, char_seq);
  //Free the buffer created by faidx
  free(char_seq);
}


int has_sequence(SV* obj, SV* location) 
{
  printf( "has_sequence called\n" ) ;
  printf( "\tobj address %p\n", &obj ) ;

  int has_seq=-1 ;
  printf( "\tfor location:%s\n",SvPV(location, PL_na) ) ;
  has_seq = faidx_has_seq(((Faidx*)SvIV(SvRV(obj)))->index, SvPV(location, PL_na));
  printf( "\thas_seq:%d\n", has_seq ) ;
  return has_seq;
}

int length(SV* obj, char* identifier)
{
    printf( "length() called\n" ) ;
    printf( "\tobj address %p\n", &obj ) ;
    printf( "\tfor seq with ID:%s\n", identifier ) ;
    int length = 22456 ; /* dummy number for now */
    faidx_t *fai = ((Faidx*)SvIV(SvRV(obj)))->index ;
    
    /* int faidx_seq_len(const faidx_t *fai, const char *seq);*/
    length = faidx_seq_len(fai, identifier) ;
    printf( "length calculated as %d\n", length ) ;
    return length ;
}


void DESTROY(SV* obj) 
{
  Faidx* faidx = (Faidx*)SvIV(SvRV(obj));
  Safefree(faidx->path);
  fai_destroy(faidx->index);
  Safefree(faidx);
}


MODULE = Faidx		PACKAGE = Faidx		

void
print_hello()


SV*
new(classname, path)
  char* classname
  char* path


void
get_sequence(obj, location, OUTLIST seq, OUTLIST length) 
  SV* obj
  SV* location  
  SV* seq
  int length = NO_INIT


void
get_sequence_no_length(obj, location, OUTLIST seq) 
  SV* obj
  SV* location  
  SV* seq
CODE:
  int seq_len=0 ;
  get_sequence(obj, location, &seq, &seq_len) ;


int
has_sequence(obj, location)
  SV* obj
  SV* location


int 
length(obj, identifier)
  SV* obj
  char* identifier


void
DESTROY(obj)
  SV* obj




