/* File generated by the BNF Converter (bnfc 2.9.4.1). */

/* Parser definition for use with ocamlyacc */

%{
open AbsStella
open Lexing
%}

%token KW_language KW_core KW_extend KW_with KW_fn KW_return KW_type KW_inline KW_throws KW_if KW_then KW_else KW_let KW_in KW_record KW_cons KW_false KW_true KW_succ KW_as KW_match KW_or KW_and KW_not KW_fix KW_fold KW_unfold KW_variant KW_Bool KW_Nat KW_Unit

%token SYMB1 /* µ */
%token SYMB2 /* , */
%token SYMB3 /* ; */
%token SYMB4 /* ( */
%token SYMB5 /* ) */
%token SYMB6 /* { */
%token SYMB7 /* } */
%token SYMB8 /* = */
%token SYMB9 /* : */
%token SYMB10 /* -> */
%token SYMB11 /* => */
%token SYMB12 /* <| */
%token SYMB13 /* |> */
%token SYMB14 /* [ */
%token SYMB15 /* ] */
%token SYMB16 /* < */
%token SYMB17 /* <= */
%token SYMB18 /* > */
%token SYMB19 /* >= */
%token SYMB20 /* == */
%token SYMB21 /* != */
%token SYMB22 /* + */
%token SYMB23 /* * */
%token SYMB24 /* List::head */
%token SYMB25 /* List::isempty */
%token SYMB26 /* List::tail */
%token SYMB27 /* Nat::pred */
%token SYMB28 /* Nat::iszero */
%token SYMB29 /* Nat::rec */
%token SYMB30 /* . */

%token TOK_EOF
%token <string> TOK_Ident
%token <char>   TOK_Char
%token <float>  TOK_Double
%token <int>    TOK_Integer
%token <string> TOK_String
%token <string> TOK_StellaIdent
%token <string> TOK_ExtensionName

%start pStellaIdent_list pProgram pLanguageDecl pExtension pExtensionName_list pExtension_list pDecl pDecl_list pLocalDecl pLocalDecl_list pAnnotation pAnnotation_list pParamDecl pParamDecl_list pReturnType pThrowType pExpr pExpr_list pMatchCase pMatchCase_list pOptionalTyping pPatternData pExprData pPattern pPattern_list pLabelledPattern pLabelledPattern_list pBinding pBinding_list pExpr1 pExpr2 pExpr3 pExpr4 pExpr5 pExpr6 pTypeT pType1 pType2 pType3 pTypeT_list pVariantFieldType pVariantFieldType_list pRecordFieldType pRecordFieldType_list pTyping
%type <AbsStella.stellaIdent list> pStellaIdent_list
%type <AbsStella.program> pProgram
%type <AbsStella.languageDecl> pLanguageDecl
%type <AbsStella.extension> pExtension
%type <AbsStella.extensionName list> pExtensionName_list
%type <AbsStella.extension list> pExtension_list
%type <AbsStella.decl> pDecl
%type <AbsStella.decl list> pDecl_list
%type <AbsStella.localDecl> pLocalDecl
%type <AbsStella.localDecl list> pLocalDecl_list
%type <AbsStella.annotation> pAnnotation
%type <AbsStella.annotation list> pAnnotation_list
%type <AbsStella.paramDecl> pParamDecl
%type <AbsStella.paramDecl list> pParamDecl_list
%type <AbsStella.returnType> pReturnType
%type <AbsStella.throwType> pThrowType
%type <AbsStella.expr> pExpr
%type <AbsStella.expr list> pExpr_list
%type <AbsStella.matchCase> pMatchCase
%type <AbsStella.matchCase list> pMatchCase_list
%type <AbsStella.optionalTyping> pOptionalTyping
%type <AbsStella.patternData> pPatternData
%type <AbsStella.exprData> pExprData
%type <AbsStella.pattern> pPattern
%type <AbsStella.pattern list> pPattern_list
%type <AbsStella.labelledPattern> pLabelledPattern
%type <AbsStella.labelledPattern list> pLabelledPattern_list
%type <AbsStella.binding> pBinding
%type <AbsStella.binding list> pBinding_list
%type <AbsStella.expr> pExpr1
%type <AbsStella.expr> pExpr2
%type <AbsStella.expr> pExpr3
%type <AbsStella.expr> pExpr4
%type <AbsStella.expr> pExpr5
%type <AbsStella.expr> pExpr6
%type <AbsStella.typeT> pTypeT
%type <AbsStella.typeT> pType1
%type <AbsStella.typeT> pType2
%type <AbsStella.typeT> pType3
%type <AbsStella.typeT list> pTypeT_list
%type <AbsStella.variantFieldType> pVariantFieldType
%type <AbsStella.variantFieldType list> pVariantFieldType_list
%type <AbsStella.recordFieldType> pRecordFieldType
%type <AbsStella.recordFieldType list> pRecordFieldType_list
%type <AbsStella.typing> pTyping

%type <AbsStella.stellaIdent list> stellaIdent_list
%type <AbsStella.program> program
%type <AbsStella.languageDecl> languageDecl
%type <AbsStella.extension> extension
%type <AbsStella.extensionName list> extensionName_list
%type <AbsStella.extension list> extension_list
%type <AbsStella.decl> decl
%type <AbsStella.decl list> decl_list
%type <AbsStella.localDecl> localDecl
%type <AbsStella.localDecl list> localDecl_list
%type <AbsStella.annotation> annotation
%type <AbsStella.annotation list> annotation_list
%type <AbsStella.paramDecl> paramDecl
%type <AbsStella.paramDecl list> paramDecl_list
%type <AbsStella.returnType> returnType
%type <AbsStella.throwType> throwType
%type <AbsStella.expr> expr
%type <AbsStella.expr list> expr_list
%type <AbsStella.matchCase> matchCase
%type <AbsStella.matchCase list> matchCase_list
%type <AbsStella.optionalTyping> optionalTyping
%type <AbsStella.patternData> patternData
%type <AbsStella.exprData> exprData
%type <AbsStella.pattern> pattern
%type <AbsStella.pattern list> pattern_list
%type <AbsStella.labelledPattern> labelledPattern
%type <AbsStella.labelledPattern list> labelledPattern_list
%type <AbsStella.binding> binding
%type <AbsStella.binding list> binding_list
%type <AbsStella.expr> expr1
%type <AbsStella.expr> expr2
%type <AbsStella.expr> expr3
%type <AbsStella.expr> expr4
%type <AbsStella.expr> expr5
%type <AbsStella.expr> expr6
%type <AbsStella.typeT> typeT
%type <AbsStella.typeT> type1
%type <AbsStella.typeT> type2
%type <AbsStella.typeT> type3
%type <AbsStella.typeT list> typeT_list
%type <AbsStella.variantFieldType> variantFieldType
%type <AbsStella.variantFieldType list> variantFieldType_list
%type <AbsStella.recordFieldType> recordFieldType
%type <AbsStella.recordFieldType list> recordFieldType_list
%type <AbsStella.typing> typing

%type <int> int
%type <AbsStella.stellaIdent> stellaIdent
%type <AbsStella.extensionName> extensionName

%%

pStellaIdent_list : stellaIdent_list TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pProgram : program TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pLanguageDecl : languageDecl TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pExtension : extension TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pExtensionName_list : extensionName_list TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pExtension_list : extension_list TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pDecl : decl TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pDecl_list : decl_list TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pLocalDecl : localDecl TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pLocalDecl_list : localDecl_list TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pAnnotation : annotation TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pAnnotation_list : annotation_list TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pParamDecl : paramDecl TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pParamDecl_list : paramDecl_list TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pReturnType : returnType TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pThrowType : throwType TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pExpr : expr TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pExpr_list : expr_list TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pMatchCase : matchCase TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pMatchCase_list : matchCase_list TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pOptionalTyping : optionalTyping TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pPatternData : patternData TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pExprData : exprData TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pPattern : pattern TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pPattern_list : pattern_list TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pLabelledPattern : labelledPattern TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pLabelledPattern_list : labelledPattern_list TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pBinding : binding TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pBinding_list : binding_list TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pExpr1 : expr1 TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pExpr2 : expr2 TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pExpr3 : expr3 TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pExpr4 : expr4 TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pExpr5 : expr5 TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pExpr6 : expr6 TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pTypeT : typeT TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pType1 : type1 TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pType2 : type2 TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pType3 : type3 TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pTypeT_list : typeT_list TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pVariantFieldType : variantFieldType TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pVariantFieldType_list : variantFieldType_list TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pRecordFieldType : recordFieldType TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pRecordFieldType_list : recordFieldType_list TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

pTyping : typing TOK_EOF { $1 }
  /* Delete this error clause to get a Parsing.Parse_error exception instead: */
  | error { raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) }
  ;

stellaIdent_list : /* empty */ { []  }
  | stellaIdent { (fun x -> [x]) $1 }
  | stellaIdent SYMB2 stellaIdent_list { (fun (x,xs) -> x::xs) ($1, $3) }
  ;

program : languageDecl extension_list decl_list { AProgram ($1, $2, $3) }
  ;

languageDecl : KW_language KW_core SYMB3 { LanguageCore  }
  ;

extension : KW_extend KW_with extensionName_list { AnExtension $3 }
  ;

extensionName_list : /* empty */ { []  }
  | extensionName { (fun x -> [x]) $1 }
  | extensionName SYMB2 extensionName_list { (fun (x,xs) -> x::xs) ($1, $3) }
  ;

extension_list : /* empty */ { []  }
  | extension SYMB3 extension_list { (fun (x,xs) -> x::xs) ($1, $3) }
  ;

decl : annotation_list KW_fn stellaIdent SYMB4 paramDecl_list SYMB5 returnType throwType SYMB6 decl_list KW_return expr SYMB3 SYMB7 { DeclFun ($1, $3, $5, $7, $8, $10, $12) }
  | KW_type stellaIdent SYMB8 typeT { DeclTypeAlias ($2, $4) }
  ;

decl_list : /* empty */ { []  }
  | decl decl_list { (fun (x,xs) -> x::xs) ($1, $2) }
  ;

localDecl : decl { ALocalDecl $1 }
  ;

localDecl_list : /* empty */ { []  }
  | localDecl SYMB3 localDecl_list { (fun (x,xs) -> x::xs) ($1, $3) }
  ;

annotation : KW_inline { InlineAnnotation  }
  ;

annotation_list : /* empty */ { []  }
  | annotation annotation_list { (fun (x,xs) -> x::xs) ($1, $2) }
  ;

paramDecl : stellaIdent SYMB9 typeT { AParamDecl ($1, $3) }
  ;

paramDecl_list : /* empty */ { []  }
  | paramDecl { (fun x -> [x]) $1 }
  | paramDecl SYMB2 paramDecl_list { (fun (x,xs) -> x::xs) ($1, $3) }
  ;

returnType : /* empty */ { NoReturnType  }
  | SYMB10 typeT { SomeReturnType $2 }
  ;

throwType : /* empty */ { NoThrowType  }
  | KW_throws typeT_list { SomeThrowType $2 }
  ;

expr : KW_if expr KW_then expr KW_else expr { If ($2, $4, $6) }
  | KW_let stellaIdent SYMB8 expr KW_in expr { Let ($2, $4, $6) }
  | expr1 {  $1 }
  ;

expr_list : /* empty */ { []  }
  | expr { (fun x -> [x]) $1 }
  | expr SYMB2 expr_list { (fun (x,xs) -> x::xs) ($1, $3) }
  ;

matchCase : pattern SYMB11 expr { AMatchCase ($1, $3) }
  ;

matchCase_list : /* empty */ { []  }
  | matchCase { (fun x -> [x]) $1 }
  | matchCase SYMB3 matchCase_list { (fun (x,xs) -> x::xs) ($1, $3) }
  ;

optionalTyping : /* empty */ { NoTyping  }
  | SYMB9 typeT { SomeTyping $2 }
  ;

patternData : /* empty */ { NoPatternData  }
  | SYMB8 pattern { SomePatternData $2 }
  ;

exprData : /* empty */ { NoExprData  }
  | SYMB8 expr { SomeExprData $2 }
  ;

pattern : SYMB12 stellaIdent patternData SYMB13 { PatternVariant ($2, $3) }
  | SYMB6 pattern_list SYMB7 { PatternTuple $2 }
  | KW_record SYMB6 labelledPattern_list SYMB7 { PatternRecord $3 }
  | SYMB14 pattern_list SYMB15 { PatternList $2 }
  | KW_cons SYMB4 pattern SYMB2 pattern SYMB5 { PatternCons ($3, $5) }
  | KW_false { PatternFalse  }
  | KW_true { PatternTrue  }
  | int { PatternInt $1 }
  | KW_succ SYMB4 pattern SYMB5 { PatternSucc $3 }
  | stellaIdent { PatternVar $1 }
  | SYMB4 pattern SYMB5 {  $2 }
  ;

pattern_list : /* empty */ { []  }
  | pattern { (fun x -> [x]) $1 }
  | pattern SYMB2 pattern_list { (fun (x,xs) -> x::xs) ($1, $3) }
  ;

labelledPattern : stellaIdent SYMB8 pattern { ALabelledPattern ($1, $3) }
  ;

labelledPattern_list : /* empty */ { []  }
  | labelledPattern { (fun x -> [x]) $1 }
  | labelledPattern SYMB2 labelledPattern_list { (fun (x,xs) -> x::xs) ($1, $3) }
  ;

binding : stellaIdent SYMB8 expr { ABinding ($1, $3) }
  ;

binding_list : /* empty */ { []  }
  | binding { (fun x -> [x]) $1 }
  | binding SYMB2 binding_list { (fun (x,xs) -> x::xs) ($1, $3) }
  ;

expr1 : expr2 SYMB16 expr2 { LessThan ($1, $3) }
  | expr2 SYMB17 expr2 { LessThanOrEqual ($1, $3) }
  | expr2 SYMB18 expr2 { GreaterThan ($1, $3) }
  | expr2 SYMB19 expr2 { GreaterThanOrEqual ($1, $3) }
  | expr2 SYMB20 expr2 { Equal ($1, $3) }
  | expr2 SYMB21 expr2 { NotEqual ($1, $3) }
  | expr2 {  $1 }
  ;

expr2 : expr2 KW_as typeT { TypeAsc ($1, $3) }
  | KW_fn SYMB4 paramDecl_list SYMB5 SYMB6 KW_return expr SYMB3 SYMB7 { Abstraction ($3, $7) }
  | SYMB6 expr_list SYMB7 { Tuple $2 }
  | KW_record SYMB6 binding_list SYMB7 { Record $3 }
  | SYMB12 stellaIdent exprData SYMB13 { Variant ($2, $3) }
  | KW_match expr1 SYMB6 matchCase_list SYMB7 { Match ($2, $4) }
  | SYMB14 expr_list SYMB15 { List $2 }
  | expr2 SYMB22 expr3 { Add ($1, $3) }
  | expr2 KW_or expr3 { LogicOr ($1, $3) }
  | expr3 {  $1 }
  ;

expr3 : expr3 SYMB23 expr4 { Multiply ($1, $3) }
  | expr3 KW_and expr4 { LogicAnd ($1, $3) }
  | expr4 {  $1 }
  ;

expr4 : expr4 SYMB4 expr_list SYMB5 { Application ($1, $3) }
  | expr5 {  $1 }
  ;

expr5 : KW_cons SYMB4 expr SYMB2 expr SYMB5 { ConsList ($3, $5) }
  | SYMB24 SYMB4 expr SYMB5 { Head $3 }
  | SYMB25 SYMB4 expr SYMB5 { IsEmpty $3 }
  | SYMB26 SYMB4 expr SYMB5 { Tail $3 }
  | KW_succ SYMB4 expr SYMB5 { Succ $3 }
  | KW_not SYMB4 expr SYMB5 { LogicNot $3 }
  | SYMB27 SYMB4 expr SYMB5 { Pred $3 }
  | SYMB28 SYMB4 expr SYMB5 { IsZero $3 }
  | KW_fix SYMB4 expr SYMB5 { Fix $3 }
  | SYMB29 SYMB4 expr SYMB2 expr SYMB2 expr SYMB5 { NatRec ($3, $5, $7) }
  | KW_fold SYMB14 typeT SYMB15 expr6 { Fold ($3, $5) }
  | KW_unfold SYMB14 typeT SYMB15 expr6 { Unfold ($3, $5) }
  | expr6 {  $1 }
  ;

expr6 : expr6 SYMB30 stellaIdent { DotRecord ($1, $3) }
  | expr6 SYMB30 int { DotTuple ($1, $3) }
  | KW_true { ConstTrue  }
  | KW_false { ConstFalse  }
  | int { ConstInt $1 }
  | stellaIdent { Var $1 }
  | SYMB4 expr SYMB5 {  $2 }
  ;

typeT : KW_fn SYMB4 typeT_list SYMB5 SYMB10 typeT { TypeFun ($3, $6) }
  | SYMB1 stellaIdent SYMB30 typeT { TypeRec ($2, $4) }
  | type1 {  $1 }
  ;

type1 : type2 SYMB22 type2 { TypeSum ($1, $3) }
  | type2 {  $1 }
  ;

type2 : SYMB6 typeT_list SYMB7 { TypeTuple $2 }
  | KW_record SYMB6 recordFieldType_list SYMB7 { TypeRecord $3 }
  | KW_variant SYMB12 variantFieldType_list SYMB13 { TypeVariant $3 }
  | SYMB14 typeT SYMB15 { TypeList $2 }
  | type3 {  $1 }
  ;

type3 : KW_Bool { TypeBool  }
  | KW_Nat { TypeNat  }
  | KW_Unit { TypeUnit  }
  | stellaIdent { TypeVar $1 }
  | SYMB4 typeT SYMB5 {  $2 }
  ;

typeT_list : /* empty */ { []  }
  | typeT { (fun x -> [x]) $1 }
  | typeT SYMB2 typeT_list { (fun (x,xs) -> x::xs) ($1, $3) }
  ;

variantFieldType : stellaIdent optionalTyping { AVariantFieldType ($1, $2) }
  ;

variantFieldType_list : /* empty */ { []  }
  | variantFieldType { (fun x -> [x]) $1 }
  | variantFieldType SYMB2 variantFieldType_list { (fun (x,xs) -> x::xs) ($1, $3) }
  ;

recordFieldType : stellaIdent SYMB9 typeT { ARecordFieldType ($1, $3) }
  ;

recordFieldType_list : /* empty */ { []  }
  | recordFieldType { (fun x -> [x]) $1 }
  | recordFieldType SYMB2 recordFieldType_list { (fun (x,xs) -> x::xs) ($1, $3) }
  ;

typing : expr SYMB9 typeT { ATyping ($1, $3) }
  ;

int :  TOK_Integer  { $1 };
stellaIdent : TOK_StellaIdent { StellaIdent ($1)};
extensionName : TOK_ExtensionName { ExtensionName ($1)};
