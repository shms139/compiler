lexer grammar myLexer;
channels { ERROR }

/* ===================== DEFAULT (HTML) ===================== */
HTML_DOCTYPE: '<!DOCTYPE' .*? '>';
HTML_COMMENT: '<!--' .*? '-->' -> skip;

/* ---- Mode switches ---- */
STYLE_OPEN: '<style>' -> pushMode(CSS);
SCRIPT_OPEN: '<script>' -> pushMode(SCRIPT);
PYTHON_START: '{% python %}' -> pushMode(PYTHON);
JINJA_EXPR_START: '{{' -> pushMode(JINJA);
JINJA_STMT_START: '{%' -> pushMode(JINJA);
JINJA_COMMENT: '{#' .*? '#}' -> skip;

/* ---- HTML ---- */
HTML_TAG_START : '<' TAG_NAME -> pushMode(TAG);
HTML_TAG_CLOSE : '</' TAG_NAME HTML_WS? '>';
HTML_TEXT      : ~[<{\n]+ ;
HTML_WS        : [ \t\r\n]+ -> skip;
 TAG_NAME: [a-zA-Z][a-zA-Z0-9-]*;

/* ===================== TAG MODE ===================== */
mode TAG;
TAG_WS: [ \t\r\n]+ -> skip;
HTML_ATTR_NAME: [a-zA-Z_:][a-zA-Z0-9_:-]*;
EQUALS: '=';
HTML_ATTR_VALUE
    : '"' ~["\r\n]* '"'
    | '\'' ~['\r\n]* '\''
    ;
TAG_END : '>'  -> popMode;
SELF_CLOSE : '/>' -> popMode;

/* ===================== CSS MODE ===================== */
mode CSS;
CSS_STYLE_CLOSE: '</style>' -> popMode;
CSS_COMMENT: '/*' .*? '*/' -> skip;
CSS_LBRACE: '{';
CSS_RBRACE: '}';
CSS_COLON: ':';
CSS_SEMI: ';';
CSS_NUMBER: [0-9]+ ('.' [0-9]+)?;
CSS_UNIT: 'px' | 'em' | 'rem' | '%' | 'vh' | 'vw';
CSS_COLOR_HEX
    : '#' HEX HEX HEX (HEX HEX HEX)?
    ;
fragment HEX
    : [0-9a-fA-F]
    ;
CSS_COLOR_KEYWORD
     : 'red' | 'green' | 'blue' | 'black' | 'white' | 'yellow'
     ;
CSS_STRING: '"' (~["\r\n])* '"' | '\'' (~['\r\n])* '\'';

/* ---- CSS Selectors ---- */
CSS_ID_SELECTOR
    : '#' [a-zA-Z_][a-zA-Z0-9_-]*
    ;
CSS_CLASS_SELECTOR
    : '.' [a-zA-Z_][a-zA-Z0-9_-]*
    ;
CSS_IDENT: [a-zA-Z_-][a-zA-Z0-9_-]*;
CSS_WS: [ \t\r\n]+ -> skip;

/* ===================== SCRIPT MODE ===================== */
mode SCRIPT;

SCRIPT_CLOSE: '</script>' -> popMode;
SCRIPT_TEXT: .+?;

/* ===================== PYTHON MODE ===================== */
mode PYTHON;
 PYTHON_END: '{% endpython %}' -> popMode;
 /* Keywllords */
    PY_PRINT: 'print';
    PY_RETURN: 'return';
    /* Identifiers */
    PY_ID: [a-zA-Z_][a-zA-Z0-9_]*;
    /* Literals */
    PY_INT: [0-9]+;
    PY_FLOAT: [0-9]+ '.' [0-9]+;
    PY_STRING: '"' (~["\r\n])* '"' | '\'' (~['\r\n])* '\'';
    /* Operators */
    PY_ASSIGN: '='; PY_OP: '+' | '-' | '*' | '/';
    /* Symbols */
    PY_LPAREN: '('; PY_RPAREN: ')';
    /* Whitespace */
    PY_WS: [ \t\r\n]+ -> skip;
/* ===================== JINJA MODE ===================== */
mode JINJA;
/* ---- End ---- */
JINJA_EXPR_END: '}}' -> popMode;
JINJA_STMT_END: '%}' -> popMode;

/* ---- Keywords ---- */
JINJA_IF: 'if';
JINJA_ELSE: 'else';
JINJA_ELIF: 'elif';
JINJA_FOR: 'for';
JINJA_IN: 'in';
JINJA_ENDIF: 'endif';
JINJA_ENDFOR: 'endfor';

/* ---- Expressions ---- */
JINJA_ID: [a-zA-Z_][a-zA-Z0-9_]*;
JINJA_INT: [0-9]+;
JINJA_FLOAT: [0-9]+ '.' [0-9]+;
JINJA_STRING: '"' (~["\r\n])* '"' | '\'' (~['\r\n])* '\'';

JINJA_DOT: '.';
JINJA_COMMA: ',';
JINJA_LPAREN: '(';
JINJA_RPAREN: ')';

JINJA_ARITH_OP: '+' | '-' | '*' | '/' | '%';
JINJA_COMP_OP: '==' | '!=' | '<' | '>' | '<=' | '>=';
JINJA_BOOL_OP: 'and' | 'or' | 'not';

JINJA_WS: [ \t\r\n]+ -> skip;
