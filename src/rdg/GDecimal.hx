package rdg;

class GDecimal implements IGenerator<Float> {
  var floatf : Void -> Float;
  var decimals : Int;
  public function new(floatf : Void -> Float, decimals : Int) {
    this.floatf = floatf;
    this.decimals = decimals;
  }

  public function generate() {
    var parts = ("" + floatf()).split(".");
    if(decimals == 0)
      return Std.parseFloat(parts[0]);
    else
      return Std.parseFloat(parts[0] + "." + parts[1].substr(0, decimals));
  }
}
