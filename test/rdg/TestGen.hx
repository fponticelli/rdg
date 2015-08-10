package rdg;

import utest.Assert;

class TestGen {
  public function new() { }

  static function thirdGenerator() return 1 / 3;
  static function halfGenerator() return 0.5;
  static function minGenerator() return 0.0;
  static function maxGenerator() return 0.999999999999;

  static var altGenerator = (function() {
    var max = false;
    return function() {
      var v = max ? maxGenerator() : minGenerator();
      max = !max;
      return v;
    }
  })();

  public function testInt() {
    var gen = Gen.int(1, 6, altGenerator);

    Assert.equals(1, gen());
    Assert.equals(6, gen());
  }

  public function testDecimal() {
    var gen = Gen.float(0, 3, halfGenerator);
    Assert.equals(1.5, gen());

    gen = Gen.float(0, 1, 1, thirdGenerator);
    Assert.equals(0.3, gen());

    gen = Gen.float(0, 1, 2, thirdGenerator);
    Assert.equals(0.33, gen());

    gen = Gen.float(0, 1, -1, thirdGenerator);
    Assert.floatEquals(0.3333333333, gen());
  }

  public function testEmptyObject() {
    var gen = Gen.object();
    Assert.same({}, gen());
  }

  // public function testComplexObject() {
  //   var gen = Gen.object(function(ob) {
  //     ob.field("name", Gen.pick(["Franco", "Sandro", "Sergio"], altGenerator))
  //       .fieldMap("age",  function(o) {
  //         return switch (o.name)
  //         {
  //           case "Franco": 39;
  //           case "Sandro": 41;
  //           case "Sergio": 42;
  //           default:       null;
  //         };
  //       })
  //     ob.field("scores", Gen.array(1, 3, Gen.int(0, 5, altGenerator), altGenerator))
  //     ;
  //   });
  //
  //   var a = gen();
  //   Assert.same({
  //     name   : "Franco",
  //     age    : 39,
  //     scores : [0, 5, 0]
  //   }, a);
  //
  //   a = gen();
  //   Assert.same({
  //     name : "Sergio",
  //     age    : 42,
  //     scores : [5]
  //   }, a);
  // }

  public function testArray() {
    var gen = Gen.array(5, 5, Gen.int(5, 5));
    Assert.same([5,5,5,5,5], gen());

    gen = Gen.array(1, 5, Gen.int(5, 5), altGenerator);
    Assert.same([5], gen());
    Assert.same([5,5,5,5,5], gen());
  }
}
