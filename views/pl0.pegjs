/*
 * Classic example grammar, which recognizes simple arithmetic expressions like
 * "2*(3+4)". The parser generated from this grammar then AST.
 */

{
  var tree = function(f, r) {
    if (r.length > 0) {
      var last = r.pop();
      var result = 
{        type:  last[0],
        left: tree(f, r),
        right: last[1]
      };
    }
    else {
      var result = f;
    }
    return result;
  }
}

program = b:block PUNTO {return b;}

block = constantes:(const)? variables:(var)? procedure:(procs)* stat:statement{
	var bloque = [];
	if(const) bloque = bloque.concat(const);
	if(var) bloque = bloque.concat(var);
	if(procedure) bloque = bloque.concat(procedure);
	bloque = bloque.concat([s]);
	return bloque;
}

st     = i:ID ASSIGN e:exp{ 
             return {
               type: '=', 
               left: i, 
               right: e
             }; 
          }

       / CALL i:ID arg: (LEFTPAR a:argumentos RIGHTPAR)?{
       	  if(argumentos){
               return {
                 type: "CALL", 
                 arguments: arg, 
                 value: i
               };
	  }
          else {
               return {
                 type: "CALL", 
                 value: i
               };
             }
         }

       / BEGIN stat1: st stat2:(PUNTOCOMA s:st {return s;})* 'END' {
             return { 
               type: "BEGIN",
               value: [stat1].concat(stat2)
             };
         }

       / IF e:exp THEN st:st ELSE sf:st{
             return {
               type: 'IFELSE',
               c:  e,
               st: st,
               sf: sf,
             };
         }

       / IF e:exp THEN st:st {
             return {
               type: 'IF',
               c:  e,
               st: st
             };
         }

       / WHILE c: condicion DO s:statement {
             return {
               type:"WHILE", 
               condition: c, 
               stat: s
             };
         }

condicion = ODD e: exp {
              return {
                  type: "ODD",
                  expresion: e
              };
            }
            /exp1: exp o:OP exp2: exp {
              return {
                  type:op,
                  left: exp1,
                  right: exp2 
              };
            }

//expression = [ "+"|"-"] term { ("+"|"-") term}.
exp    = t:(symbol:ADD? t1: term { 
            if(symbol){
              return {
                type: symbol, 
                value:t1
              };
            }   
            else{
              return{
                value: t1
              };
            }
        } 
       /r:(ADD term)* { 
              return {tree(t,r)}; 
        }

exp    = t:(term)   
term   = f:factor r:(MUL factor)* { return tree(f,r); }

factor = NUMBER
       / ID
       / LEFTPAR t:exp RIGHTPAR   { return t; }

_ = $[ \t\n\r]*


//Constantes
//---------------------------------------------------------
const = fijo: constFijo opcional: (constOpcional)* PUNTOCOMA {
	return [fijo].concat(opcional);
}
constFijo = CONST i:ID ASSIGN n:NUM {return {type: '=', left: i, right: n};}  
constOpcional = _ ',' _ CONST i:ID ASSIGN n:NUM {return {type: '=', left: i, right: n};}


//Variables
//---------------------------------------------------------
var = VAR v1:ID v2:(COMA i:ID {return i;})* PUNTOCOMA {return [v1].concat(v2);}


//Procedure
//---------------------------------------------------------
procedure = PROCEDURE i:ID LEFTPAR arg:argumentos? RIGHTPAR PUNTOCOMA b:block PUNTOCOMA{
	if(arg) {return type: "PROCEDURE", value: i, parameters: arg, block: b}
	else {return type: "PROCEDURE", value: i, block: b}
}
argumentos = arg1:ID arg2:(COMA i:ID {return i;})* {return [arg1].concat(arg2);}

//------------------------------------------------------------

PUNTOCOMA= _ ';' _
COMA	   = _ ',' _
PUNTO	   = _ '.' _
LEFTPAR  = _"("_
RIGHTPAR = _")"_
IF       = _ "if" _
THEN     = _ "then" _
ELSE     = _ "else" _
CONST    = _ "const" _
VAR      = _ "var" _
PROCEDURE= _ "procedure" _
CALL     = _ "call" _
BEGIN    = _ "begin" _
END      = _ "end" _
WHILE    = _ "while" _
DO       = _ "do" _
ODD      = _ "odd" _
ID       = _ id:$([a-zA-Z_][a-zA-Z_0-9]*) _ { 
              return { type: 'ID', value: id }; 
            }
OP       = _ o:$([<>!=]'=' | [<>#]) _ {return o;}
ASSIGN   = _ op:'=' _  { return op; }
ADD      = _ op:[+-] _ { return op; }
MUL      = _ op:[*/] _ { return op; }
NUMBER   = _ digits:$[0-9]+ _ { 
              return { type: 'NUM', value: parseInt(digits, 10) }; 
            }
