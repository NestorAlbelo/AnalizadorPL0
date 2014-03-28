var assert = chai.assert;

suite('Operaciones Aritmeticas', function(){
  test('Asignacion', function(){
    valor = pl0.parse("ocho = 8 .")
    assert.equal(valor[0].type, "=")
    assert.equal(valor[0].left.type, "ID")
    assert.equal(valor[0].left.value, "ocho")
    assert.equal(valor[0].right.value.type, "NUMBER")
    assert.equal(valor[0].right.value.value, "8") 
  });

  test('Suma', function(){
    valor = pl0.parse("Suma = 8+ 9 .")
    assert.equal(valor[0].right.type, "+")
  });

  test('Resta', function(){
    valor = pl0.parse("Resta = 5 -19 .")
    assert.equal(valor[0].right.type, "-")
  });

  test('Multiplicacion', function(){
    valor = pl0.parse("Multiplicacion = 4 *3 .")
    assert.equal(valor[0].right.value.type, "*") 
  });

  test('División', function(){
    valor = pl0.parse("Division = 4/4 .")
    assert.equal(valor[0].right.value.type, "/")
  });
});


suite('Funciones', function(){
  test('Call', function(){
    valor = pl0.parse("call funcion(parametros) .")
    assert.equal(valor[0].type, "CALL")
  });

  test('If', function(){
    valor = pl0.parse("if a == 4 then variable = 5 .")
    assert.equal(valor[0].type, "IF")
  });

  test('If Else', function(){
    valor = pl0.parse("if a == 7 then variable = a else variable = b .")
    assert.equal(valor[0].type, "IFELSE")
  });

  test('While', function(){
    valor = pl0.parse("while a == 1 do i = i+1 .")
    assert.equal(valor[0].type, "WHILE")
  });

  test('Begin', function(){
    valor = pl0.parse("begin variable = a; variable = b end.")
    assert.equal(valor[0].type, "BEGIN")
  });
});

