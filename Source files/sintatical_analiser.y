%{
	#include <stdio.h>
	#include <stdlib.h> 
	int yylex(void);
  	int yyerror(const char *s);
  	int success = 1;
%}

    /*Tokens*/
%token SYMP YEAR ID FLOAT INTEGER 


%%
    /*Analyser Starts Here*/
Symposium       : SYMP ':' Year     //Verify
                	'[' Types ']'
               		'[' Meds ']'
                ;
Types           : Name              //Verify if it's a Name
                | Types ',' Name    //Syntaxe
                ;
Meds            : Med               //""
                | Meds ';' Med
                ;
Med             : '(' Name ',' Number ',' NameC ',' Pill ',' Pr ',' //Syntaxe
                            '{' Fabs '}' ',' '{' MedEq '}'
                  ')'
                ;
Fabs            : Fab
                | Fabs ',' Fab
                ;
MedEq           : MedEq1
                | MedEq ',' MedEq1
                ;
MedEq1          : Name '-' Fab
                ;
    /*Definitions*/
Year            : YEAR
                ;
Name            : ID
                ;
NameC           : ID
                ;
Pill            : ID
                ;
Fab             : ID
                ;
Pr              : FLOAT
                ;
Number          : INTEGER
                ;
%%
int yyerror(const char *msg)
{
   extern int yylineno;
   printf("\nParsing FAILED -> Line Number: %d - %s\n", yylineno, msg);
   success = 0;

    return 0;
}

int main()
{
   yyparse();
   if(success){
        printf("\nPARSING SUCCESS!\n");
    }
    return 0;
}
