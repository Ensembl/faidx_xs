/*
 * This file was generated automatically by ExtUtils::ParseXS version 2.2210 from the
 * contents of Faidx.xs. Do not edit this file, edit Faidx.xs instead.
 *
 *	ANY CHANGES MADE HERE WILL BE LOST! 
 *
 */

#line 1 "Faidx.xs"
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


#line 129 "Faidx.c"
#ifndef PERL_UNUSED_VAR
#  define PERL_UNUSED_VAR(var) if (0) var = var
#endif

#ifndef PERL_ARGS_ASSERT_CROAK_XS_USAGE
#define PERL_ARGS_ASSERT_CROAK_XS_USAGE assert(cv); assert(params)

/* prototype to pass -Wmissing-prototypes */
STATIC void
S_croak_xs_usage(pTHX_ const CV *const cv, const char *const params);

STATIC void
S_croak_xs_usage(pTHX_ const CV *const cv, const char *const params)
{
    const GV *const gv = CvGV(cv);

    PERL_ARGS_ASSERT_CROAK_XS_USAGE;

    if (gv) {
        const char *const gvname = GvNAME(gv);
        const HV *const stash = GvSTASH(gv);
        const char *const hvname = stash ? HvNAME(stash) : NULL;

        if (hvname)
            Perl_croak(aTHX_ "Usage: %s::%s(%s)", hvname, gvname, params);
        else
            Perl_croak(aTHX_ "Usage: %s(%s)", gvname, params);
    } else {
        /* Pants. I don't think that it should be possible to get here. */
        Perl_croak(aTHX_ "Usage: CODE(0x%"UVxf")(%s)", PTR2UV(cv), params);
    }
}
#undef  PERL_ARGS_ASSERT_CROAK_XS_USAGE

#ifdef PERL_IMPLICIT_CONTEXT
#define croak_xs_usage(a,b)	S_croak_xs_usage(aTHX_ a,b)
#else
#define croak_xs_usage		S_croak_xs_usage
#endif

#endif

/* NOTE: the prototype of newXSproto() is different in versions of perls,
 * so we define a portable version of newXSproto()
 */
#ifdef newXS_flags
#define newXSproto_portable(name, c_impl, file, proto) newXS_flags(name, c_impl, file, proto, 0)
#else
#define newXSproto_portable(name, c_impl, file, proto) (PL_Sv=(SV*)newXS(name, c_impl, file), sv_setpv(PL_Sv, proto), (CV*)PL_Sv)
#endif /* !defined(newXS_flags) */

#line 181 "Faidx.c"

XS(XS_Faidx_print_hello); /* prototype to pass -Wmissing-prototypes */
XS(XS_Faidx_print_hello)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 0)
       croak_xs_usage(cv,  "");
    {

	print_hello();
    }
    XSRETURN_EMPTY;
}


XS(XS_Faidx_new); /* prototype to pass -Wmissing-prototypes */
XS(XS_Faidx_new)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 2)
       croak_xs_usage(cv,  "classname, path");
    {
	char*	classname = (char *)SvPV_nolen(ST(0));
	char*	path = (char *)SvPV_nolen(ST(1));
	SV *	RETVAL;

	RETVAL = new(classname, path);
	ST(0) = RETVAL;
	sv_2mortal(ST(0));
    }
    XSRETURN(1);
}


XS(XS_Faidx_get_sequence); /* prototype to pass -Wmissing-prototypes */
XS(XS_Faidx_get_sequence)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 2)
       croak_xs_usage(cv,  "obj, location");
    {
	SV*	obj = ST(0);
	SV*	location = ST(1);

	get_sequence(obj, location);
    }
    XSRETURN_EMPTY;
}


XS(XS_Faidx_has_sequence); /* prototype to pass -Wmissing-prototypes */
XS(XS_Faidx_has_sequence)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 2)
       croak_xs_usage(cv,  "obj, sequence");
    {
	SV*	obj = ST(0);
	SV*	sequence = ST(1);
	int	RETVAL;
	dXSTARG;

	RETVAL = has_sequence(obj, sequence);
	XSprePUSH; PUSHi((IV)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_Faidx_DESTROY); /* prototype to pass -Wmissing-prototypes */
XS(XS_Faidx_DESTROY)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 1)
       croak_xs_usage(cv,  "obj");
    {
	SV*	obj = ST(0);

	DESTROY(obj);
    }
    XSRETURN_EMPTY;
}

#ifdef __cplusplus
extern "C"
#endif
XS(boot_Faidx); /* prototype to pass -Wmissing-prototypes */
XS(boot_Faidx)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
#if (PERL_REVISION == 5 && PERL_VERSION < 9)
    char* file = __FILE__;
#else
    const char* file = __FILE__;
#endif

    PERL_UNUSED_VAR(cv); /* -W */
    PERL_UNUSED_VAR(items); /* -W */
#ifdef XS_APIVERSION_BOOTCHECK
    XS_APIVERSION_BOOTCHECK;
#endif
    XS_VERSION_BOOTCHECK ;

        newXS("Faidx::print_hello", XS_Faidx_print_hello, file);
        newXS("Faidx::new", XS_Faidx_new, file);
        newXS("Faidx::get_sequence", XS_Faidx_get_sequence, file);
        newXS("Faidx::has_sequence", XS_Faidx_has_sequence, file);
        newXS("Faidx::DESTROY", XS_Faidx_DESTROY, file);
#if (PERL_REVISION == 5 && PERL_VERSION >= 9)
  if (PL_unitcheckav)
       call_list(PL_scopestack_ix, PL_unitcheckav);
#endif
    XSRETURN_YES;
}

