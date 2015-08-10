package rdg;

class GBool implements IGenerator<Bool> {
  var gen : F;
  var trues : Float;
  public function new(trues = 0.5, gen : F) {
    this.gen = null == gen ? Math.random : gen;
    this.trues = trues;
  }

  public function generate()
    return gen() < trues;
}
