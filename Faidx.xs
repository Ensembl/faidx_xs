#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include <stdio.h>

#include "htslib/faidx.h"
#ifndef Newx
#  define Newx(v,n,t) New(0,v,n,t)
#endif

#define Inline_Stack_Vars dXSARGS
#define Inline_Stack_Items items
#define Inline_Stack_Item(x) ST(x)
#define Inline_Stack_Reset sp = mark
#define Inline_Stack_Push(x) XPUSHs(x)
#define Inline_Stack_Done PUTBACK
#define Inline_Stack_Return(x) XSRETURN(x)
#define Inline_Stack_Void XSRETURN(0)

#define INLINE_STACK_VARS Inline_Stack_Vars
#define INLINE_STACK_ITEMS Inline_Stack_Items
#define INLINE_STACK_ITEM(x) Inline_Stack_Item(x)
#define INLINE_STACK_RESET Inline_Stack_Reset
#define INLINE_STACK_PUSH(x) Inline_Stack_Push(x)
#define INLINE_STACK_DONE Inline_Stack_Done
#define INLINE_STACK_RETURN(x) Inline_Stack_Return(x)
#define INLINE_STACK_VOID Inline_Stack_Void

#define inline_stack_vars Inline_Stack_Vars
#define inline_stack_items Inline_Stack_Items
#define inline_stack_item(x) Inline_Stack_Item(x)
#define inline_stack_reset Inline_Stack_Reset
#define inline_stack_push(x) Inline_Stack_Push(x)
#define inline_stack_done Inline_Stack_Done
#define inline_stack_return(x) Inline_Stack_Return(x)
#define inline_stack_void Inline_Stack_Void

void print_hello()
{
  printf( "Hello World\n" ) ;
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
  
  obj = newSViv((IV)faidx);
  obj_ref = newRV_noinc(obj);
  sv_bless(obj_ref, gv_stashpv(classname, GV_ADD));
  SvREADONLY_on(obj);

  return obj_ref;
}

void get_sequence(SV* obj, SV* location) 
{
  SV* seq;
  int seq_len;
  faidx_t *fai;
  char* char_seq;
  
  Inline_Stack_Vars;
  
  seq = newSVpvn("",0);
  seq_len = 0;
  
  fai = ((Faidx*)SvIV(SvRV(obj)))->index;
  //Fetch sequence
  char_seq = fai_fetch(fai, SvPV(location, PL_na), &seq_len);
  //Push into a SV
  sv_catpv(seq, char_seq);
  //Free the buffer created by faidx
  free(char_seq);
  
  Inline_Stack_Reset;
  //Make sure you always do the sv_2mortal() otherwise memory leaks happen!
  Inline_Stack_Push(sv_2mortal(seq));
  Inline_Stack_Push(sv_2mortal(newSVuv(seq_len)));
  Inline_Stack_Done;
}

int has_sequence(SV* obj, SV* sequence) 
{
  int has_seq;
  has_seq = faidx_has_seq(((Faidx*)SvIV(SvRV(obj)))->index, SvPV(sequence, PL_na));
  return has_seq;
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




