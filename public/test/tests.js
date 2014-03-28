var assert = chai.assert;

suite('Operaciones Aritmeticas', function(){
  test('Asignacion', function(){
    valor = pl0.parse("ocho = 8 .")
    assert.equal(valor[0].type, "=")
    assert.equal(valor[0].left.type, "ID")
    assert.equal(valor[0].left.value, "ocho")
    assert.equal(valor[0].right.type, "NUM")
    assert.equal(valor[0].right.value, "8") 
  });

  test('Suma', function(){
    valor = pl0.parse("Suma = 8+ 9 .")
    assert.equal(valor[0].right.type, "+")
  });

  test('Suma', function(){
    valor = pl0.parse("Resta = 5 -19 .")
    assert.equal(valor[0].right.type, "-")
  });

  test('Multiplicación', function(){
    valor = pl0.parse("Multiplicación = 4 *3 .")
    assert.equal(valor[0].right.type, "*") 
  });

  test('División', function(){
    valor = pl0.parse("Division = 4/4 .")
    assert.equal(valor[0].right.type, "/")
  });
});


suite('Funciones', function(){
  test('Call', function(){
    valor = pl0.parse("CALL funcion(parametros) .")
    assert.equal(valor[0].type, "CALL")
  });

  test('If', function(){
    valor = pl0.parse("IF 4 THEN variable = 5 .")
    assert.equal(valor[0].type, "IF")
  });

  test('If Else', function(){
    valor = pl0.parse("IF 7 THEN variable = a ELSE variable = b .")
    assert.equal(valor[0].type, "IFELSE")
  });

  test('While', function(){
    valor = pl0.parse("WHILE 1 DO i = i+1 .")
    assert.equal(valor[0].type, "WHILE")
  });

  test('Begin', function(){
    valor = pl0.parse("BEGIN variable = a; variable = b END .")
    assert.equal(valor[0].type, "BEGIN")
  });
});

