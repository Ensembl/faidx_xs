
void print_hello() ;
SV* new( char* classname, char* path ) ;
void get_sequence( SV* obj, SV* location, SV* seq, int length ) ;
void get_sequence_no_length( SV* obj, SV* location, SV* seq ) ;
int has_sequence( SV* obj, SV* location ) ;
int length( SV* obj, char* identifier ) ;
void DESTROY(SV* obj) ;


