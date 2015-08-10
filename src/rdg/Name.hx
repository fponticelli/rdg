package rdg;

import rdg.data.Names;

class Name {
  public static function male(?gen : F) {
    var g = new GPicker(Names.males, gen);
    return function() return g.generate().name;
  }

  public static function female(?gen : F) {
    var g = new GPicker(Names.females, gen);
    return function() return g.generate().name;
  }

  public static function generator(?gen : F) {
    var g = new GPicker(Names.data, gen);
    return function() return g.generate().name;
  }

  public static function weightedMale(?gen : F) {
    var g = new GWeighted(Names.males, function(item, _) return item.population, gen);
    return function() return g.generate().name;
  }

  public static function weightedFemale(?gen : F) {
    var g = new GWeighted(Names.females, function(item, _) return item.population, gen);
    return function() return g.generate().name;
  }

  public static function weighted(?gen : F) {
    var g = new GWeighted(Names.data, function(item, _) return item.population, gen);
    return function() return g.generate().name;
  }
}
