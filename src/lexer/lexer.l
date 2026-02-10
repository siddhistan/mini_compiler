%{
    #include<stdio.h>
    int yylex(void);
%}

%x COMMENT  

%%

"//".*                      ;

"/*"        { BEGIN(COMMENT); }

<COMMENT>"*/"  { BEGIN(INITIAL); }

<COMMENT>.|\n  ;   /* ignore everything inside comment */

     
    int|float|char|return|double|if|else|while  {printf("Keywords:\t %s\n",yytext);}

    printf|scanf|cin|cout                      {printf("I/O Identifiers:\t %s\n",yytext);}

    [a-zA-Z][a-zA-Z0-9]*    {printf("Identifiers:\t %s\n",yytext);}

    [();,{}]                       {printf("Separators:\t %s\n",yytext);}

    -?([0-9]*\.[0-9]+|\.[0-9]+)        {printf("Floating point numbers:\t %s\n",yytext);}

    -?[0-9]+                {printf("Integer numbers:\t %s\n",yytext);}

    "<<"|">>"                {printf(" Stream operators:\t %s\n",yytext);}

    "&&"|"||"    { printf("Logical operators:\t %s\n", yytext); }

    "=="|"<="|">="|"!="      {printf("multi character Operators:\t %s\n",yytext);}

    "&"|"|"      { printf("Bitwise Operators:\t %s\n", yytext); }

    [=><!]                  {printf("single character Operators:\t %s\n",yytext);}

    [+\-*/%]                {printf("Arithmetic Operators:\t %s\n",yytext);}

    [0-9]+[0-9a-zA-Z]+    ;

    [ \n\t\r]+               ;    

    .                     { printf("Unknown character:\t %s\n",yytext); }


%%



int main(int argc, char *argv[])
{
   extern FILE *yyin;

   if(argc<2)
   {
      printf("Usage: %s <input_file>\n",argv[0]);
      return 1;
   }

   yyin=fopen(argv[1],"r");

   if(!yyin)
   {
     printf("File can't be opened %s\n",argv[1]);
     return 1;
   }

   yylex();

   return 0;
}

int yywrap()
{
    return 1;

}
