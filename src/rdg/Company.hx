package rdg;

import rdg.data.Companies;

class Company {
  public static function generator(?gen : F) : Void -> String {
    var g = new GPicker(Companies.data, gen);
    return function() return g.generate().name;
  }

  public static function weightedOnRevenues(?gen : F) {
    var g = new GWeighted(Companies.data, function(item : { revenues : Float, profits : Float, name : String }, _) return item.revenues, gen);
    return function() return g.generate().name;
  }

  public static function weightedOnProfits(?gen : F) {
    var min = 0.0;
    for(item in Companies.data)
      if(item.profits < min)
        min = item.profits;
    var g = new GWeighted(Companies.data, function(item : { revenues : Float, profits : Float, name : String }, _) return item.profits - min, gen);
    return function() return g.generate().name;
  }
}
