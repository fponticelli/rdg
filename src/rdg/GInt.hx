package rdg;

class GInt implements IGenerator<Int> {
  var start : Int;
  var end : Int;
  var gen : F;
  public function new(start : Int, end : Int, ?generator : F) {
    if(start > end) {
      var t = start;
      start = end;
      end = t;
    }
    this.start = start;
    this.end   = end;
    this.gen   = null == generator ? Math.random : generator;
  }

  public function generate()
    return start + Math.floor((end - start) * gen());
}
