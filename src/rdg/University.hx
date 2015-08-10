package rdg;

import rdg.data.Universities;
import rdg.GPicker;

class University {
  public static function generator(?gen : F)
    return new GPicker(Universities.data, gen).generate;

  public static function nameGenerator(?gen : F) {
    var g = new GPicker(Universities.data, gen).generate;
    return function() return g().name;
  }
}
