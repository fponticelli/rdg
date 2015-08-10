package rdg;

import rdg.data.Countries;

class Country {
  public static function generator(?gen : F) {
    var g = new GPicker(Countries.data, gen);
    return function() return g.generate().name;
  }

  public static function weighted(?gen : F) {
    var g = new GWeighted(Countries.data, function(item, _) return item.population, gen);
    return function() return g.generate().name;
  }
}
