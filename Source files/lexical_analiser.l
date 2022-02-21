/*Option to know where the error occurred*/
%option yylineno

%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>
    #include "y.tab.h"

    /*Values and Counts*/
    int year_value    = 0;      int year_counter    = 0;
    int integer_value = 0;      int int_counter     = 0;
    float float_value = 0.0;    int float_counter   = 0;

    int tittle_counter = 0;
    int id_counter     = 0;
    int signal_counter = 0;
    int space_counter  = 0;

%}
    /*Regras*/
symposium   "SYMPOSIUM"|"Symposium"|"symposium"
year        [2][0-9][0-9][0-9]
int         -?[1-9][0-9]*
float       [0-9]+"."[0-9]*
signals     ";"|","|"{"|"}"|"("|")"|"["|"]"|"+"|"-"|"/"|":"|"^"|"~"|"%"|"<"|">"
id          "Antigripine"|"Analgesico"|"Antibiotico"|"Antiflamatorio"|"Acetalilico"|"Moment"|"Paracetamol"|"Roche"|"Bial"|"Aga"|"Agb"|"Fabc"|"Fabt"|"Faba"|"Fabh"|"Qualquer"
string      [A-Z][a-z]+
space       [ \t\n]
commentary  "/-"[^-]*"-/"|"/-"[^\n]*

%%
    /*Intro*/
{symposium}             {tittle_counter++; printf("Times: %d | Found SYMPOSIUM: %s\n", tittle_counter, yytext); return SYMP;                                 }
{year}                  {year_counter++; year_value = atoi(yytext); printf("Times: %d | Found Year: %d\n", year_counter, year_value); return YEAR;           }

    /*Id's*/
{id}                    {id_counter++; printf("Times: %d | Found ID: %s\n", id_counter, yytext); return ID;                                                  }

    /*numbers*/
{float}                 {float_counter++; float_value = atof(yytext); printf("Times: %d | Found Float: %f\n", float_counter, float_value); return FLOAT;     }

{int}|{string}          {int_counter++; integer_value = atoi(yytext); printf("Times: %d | Found Integer: %d\n", int_counter, integer_value);return INTEGER;  }

    /*delimiters and blank spaces*/
{signals}               {signal_counter++; printf("Times: %d | Found Signals: %s\n", signal_counter, yytext); return(yytext[0]);                             }
{space}                 {space_counter++; printf("Times: %d | Found Spaces\n", space_counter);                                                               }

    /*Comentary*/
{commentary}|{space}    {printf("Commentary: %s\n", yytext);                                                                                                 }

%%

int yywrap(void)
{
    return 1;
}
