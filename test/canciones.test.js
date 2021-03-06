var chai = require("chai");
var assert = chai.assert;
var should = chai.should();
var expect = chai.expect();
const Cancion = require("../src/Canciones/Cancion");
const CancionController = require("../src/Canciones/CancionController");

describe("Crear una cancion", function () {
  it("Las canciones deben crearse correctamente", function () {
    var nueva_cancion = new Cancion("1", "nombre", "grupo", "letra");
    assert.equal(
      nueva_cancion.to_string(),
      "1, nombre, grupo, letra",
      "Correcto"
    );
  });
});

describe("Consultar una cancion", function () {
  it("Las canciones deben consultarse correctamente", function () {
    var controlador = new CancionController();
    controlador.addCancion("1", "nombre2", "grupo", "letra");
    controlador.addCancion("2", "nombre2", "grupo2", "letra2");

    assert.equal(
      controlador.getCancion("nombre2","grupo"),
      "1, nombre2, grupo, letra",
      "Correcto"
    ); 
    
  });
});
