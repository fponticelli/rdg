package rdg;

import rdg.data.Surnames;

class Surname {
  public static function generator(?gen : F) : Void -> String {
    var g = new GPicker(Surnames.data, gen);
    return function() return g.generate().name;
  }

  public static function weighted(?gen : F) {
    var g = new GWeighted(Surnames.data, function(item, _) return item.population, gen);
    return function() return g.generate().name;
  }
}
