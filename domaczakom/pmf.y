%{
    #include <stdlib.h>
    #include <stdio.h>

    struct Promjenjiva {
        char* id;
        int val;
    };

    void yyerror(const char* s);
    struct Promjenjiva tabela_simbola[50];
%}

%union {
    int int_value;
    char* ident;
    
}

%start S
%token <int_value>T_INT
%token T_SC
%token T_PLUS T_MINUS T_MULT T_DIV
%token T_LEFTP T_RIGHTP
%token <ident>T_ID
%token T_EQ
%token T_BOL
%token T_DK
%token T_STR
%token T_KOM
%token T_KOM2
%token T_IF
%token T_GR 
%token T_SM 
%token T_LEFTPR
%token T_RIGHTPR
%token T_ELSE
%token T_WHILE


%left T_PLUS T_MINUS
%left T_MULT T_DIV

%type <int_value>exp
%type <int_value>stat

%%

S: S stat                         { }
    |
;

stat: exp T_SC              { printf("%d\n", $1); }
    | T_ID T_EQ exp T_SC {}
    | quest {}  
    | whilep {}  
;

exp:
    exp T_PLUS exp          { $$ = $1 + $3; }
    | exp T_MINUS exp       { $$ = $1 - $3; }
    | exp T_MULT exp        { $$ = $1 * $3; }
    | exp T_DIV exp         { $$ = $1 / $3; }
    | T_LEFTP exp T_RIGHTP  { $$ = $2; }
    | T_INT                 { $$ = $1;}
    | T_ID                  { $$ = 0; }
    | T_BOL                 {$$=0;}
    | T_DK                  {$$=0;}
    | T_STR                 {$$=0;}
    
     
;

quest:

    T_IF T_LEFTP quest T_RIGHTP T_LEFTPR quest T_RIGHTPR T_ELSE T_IF T_LEFTP quest T_RIGHTP T_LEFTPR quest T_RIGHTPR

|   T_IF T_LEFTP quest T_RIGHTP T_LEFTPR quest T_RIGHTPR T_ELSE T_LEFTPR quest T_RIGHTPR

|   T_IF T_LEFTP quest T_RIGHTP T_LEFTPR quest T_RIGHTPR

|  exp
  


;

whilep:
    T_WHILE T_LEFTP exp T_RIGHTP T_LEFTPR exp T_RIGHTPR
;


     

%%

void yyerror(const char* s)
{
    printf("%s\n", s);
}

int main()
{
    int res = yyparse();
    if(res == 0)
    {
        printf("Ulaz je bio ispravan!\n");
    }
    else
    {
        printf("Ulaz nije bio ispravan!\n");
    }
    return 0;
}