grammar Calculator;

// Parser rules
expr : term ('+' term)*;
term : factor ('*' factor)* ;
factor : NUMBER | '(' expr ')' ;


// Lexer rules
NUMBER : [0-9]+ ;
WS: [ \t\n\r]+ -> skip;
