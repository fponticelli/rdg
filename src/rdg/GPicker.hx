package rdg;

class GPicker<T> implements IGenerator<T> {
  var list : Array<T>;
  var gen : GInt;
  public function new(list : Array<T>, ?generator : F) {
    this.list = list;
    this.gen  = new GInt(0, list.length, null == generator ? Math.random : generator);
  }

  public function generate()
    return list[gen.generate()];
}
