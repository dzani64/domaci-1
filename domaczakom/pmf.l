%{
    #include "pmf.tab.h"
    #include <string.h>
%}

%%

0|[1-9][0-9]*   { 
                    yylval.int_value = atoi(yytext);
                    return T_INT;  
                }
[a-z]+|[a-z]+[0-9]+    { 
                    yylval.ident = (char*)strdup(yytext);
                    
                    return T_ID; 
                }
"TRUE"|"FALSE"            {return T_BOL;}

[1-9][0-9]*"."[0-9]*|[1-9][0-9]*"."[0-9]*"e""+"[0-9]*     {return T_DK; }
"'"[a-z]+"'"    {return T_STR;}

"//"[a-z]*[0-9]* {return T_KOM;}
"/*"[a-z]*[0-9]*"*/" {return T_KOM2;}
"IF"            {return T_IF;}
"ELSE"          {return T_ELSE;}
"WHILE"         {return T_WHILE;}

";"             { return T_SC; }
"+"             { return T_PLUS; }
"-"             { return T_MINUS; }
"*"             { return T_MULT; }
"/"             { return T_DIV; }
"("             { return T_LEFTP; }
")"             { return T_RIGHTP; }
"{"             {return T_LEFTPR;}
"}"             {return T_RIGHTPR;}
"="             { return T_EQ; }
"<"             {return T_SM;}
">"             {return T_GR;}
[ \t\r\n]       { /* Ne radimo nista - ignorisemo bjeline */ }


.               { return yytext[0]; }

%%