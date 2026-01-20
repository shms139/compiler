parser grammar myParser;
options { tokenVocab=myLexer; }

/* ===================== ROOT ===================== */
template
    : doctype? node* EOF
    ;

node
    : htmlNode
    | jinjaNode
    | styleNode
//    | scriptNode
    ;
/* ===================== HTML ===================== */
doctype: HTML_DOCTYPE;
htmlNode
    : normalHtmlElement
    | selfClosingHtmlElement
    | HTML_TEXT
    ;

normalHtmlElement
    : openTag     node* closeTag
    ;

selfClosingHtmlElement
    : HTML_TAG_START attribute* SELF_CLOSE
    ;

openTag
    : HTML_TAG_START attribute* TAG_END
    ;

closeTag
    : HTML_TAG_CLOSE
    ;

attribute
    : HTML_ATTR_NAME (EQUALS HTML_ATTR_VALUE)?
    ;

/* ===================== STYLE ===================== */
styleNode
    : STYLE_OPEN  CSS_STYLE_CLOSE
    ;

cssBlock
    : cssSelector CSS_LBRACE cssDeclaration* CSS_RBRACE
    ;

cssSelector
    : CSS_ID_SELECTOR      # idSelector
    | CSS_CLASS_SELECTOR   # classSelector
    | CSS_IDENT            # tagSelector    ;

cssDeclaration
    : CSS_IDENT CSS_COLON cssValue CSS_SEMI
    ;

cssValue
    : CSS_COLOR_HEX
    | CSS_COLOR_KEYWORD
    | CSS_NUMBER CSS_UNIT?
    | CSS_STRING
    | CSS_IDENT
    ;

/* ===================== SCRIPT ===================== */
//scriptNode
//    : SCRIPT_OPEN SCRIPT_TEXT* SCRIPT_CLOSE
//    ;

/* ===================== JINJA ===================== */
jinjaNode
    : jinjaExpression
    | jinjaStatement
    ;

jinjaExpression
    : JINJA_EXPR_START expression? JINJA_EXPR_END
    ;

jinjaStatement
    : jinjaIfStatement
    | jinjaForStatement
    ;

jinjaIfStatement
    : JINJA_STMT_START JINJA_IF expression JINJA_STMT_END
      node*
      (JINJA_STMT_START JINJA_ELSE JINJA_STMT_END node*)?
      JINJA_STMT_START JINJA_ENDIF JINJA_STMT_END
    ;

jinjaForStatement
    : JINJA_STMT_START JINJA_FOR JINJA_ID JINJA_IN expression JINJA_STMT_END
      node*
      JINJA_STMT_START JINJA_ENDFOR JINJA_STMT_END
    ;

expression
    : primary (operator primary)*
    ;

primary
    : JINJA_ID (JINJA_DOT JINJA_ID)*
    | JINJA_INT
    | JINJA_FLOAT
    | JINJA_STRING
    | JINJA_LPAREN expression JINJA_RPAREN
    ;

operator
    : JINJA_ARITH_OP
    | JINJA_COMP_OP
    | JINJA_BOOL_OP
    ;