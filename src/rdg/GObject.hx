package rdg;

class GObject<T> implements IGenerator<T> {
  var fields : Array<Dynamic -> Void>;
  var temps : Array<String>;
  public function new() {
    fields = [];
    temps  = [];
  }

  public function field(name : String, ?condition : T -> Bool, ?conditionv : Void -> Bool) : GField<T> {
    var f = new GFieldGenerate(this, name, (null != condition ? condition : (null != conditionv ? (function(_) return conditionv()) : null)));
    fields.push(f.generate);
    return f;
  }

  public function temp(name : String, ?condition : T -> Bool, ?conditionv : Void -> Bool) : GField<T> {
    temps.push(name);
    return field(name, condition, conditionv);
  }

  public function generate() : T {
    var ob : Dynamic = {};
    for(gen in fields)
      gen(ob);
    for(temp in temps)
      Reflect.deleteField(ob, temp);
    return ob;
  }
}

class GFieldGenerate<T> extends GField<T> {
  public function generate(ob)
    return _generate(ob);
}

class GField<T> {
  var obj : GObject<T>;
  var name : String;
  var gmap : Map<String, Void -> Dynamic>;
  var conditionf : T -> Bool;
  public function new(obj : GObject<T>, name : String, conditionf : T -> Bool) {
    this.obj = obj;
    this.name = name;
    this.gmap = new Map();
    this.conditionf = conditionf;
  }

  public function value(v : Dynamic) {
    _generate = function(o) if(condition(o)) Reflect.setField(o, name, v);
    return obj;
  }

  public function gen(f : Void -> Dynamic) {
    _generate = function(o) if(condition(o)) Reflect.setField(o, name, f());
    return obj;
  }

  public function map(f : Dynamic -> Dynamic) {
    _generate = function(o) if(condition(o)) Reflect.setField(o, name, f(o));
    return obj;
  }

  public function mapValue(field : String, f : Dynamic -> Dynamic) {
    _generate = function(o) if(condition(o)) Reflect.setField(o, name, f(Reflect.field(o, field)));
    return obj;
  }

  public function remove() {
    _generate = function(o) if(condition(o)) Reflect.deleteField(o, name);
    return obj;
  }

  function condition(o) return null == conditionf ? true : conditionf(o);

  static function fieldKey(v : Dynamic) return "F:" + v;
  public function mapField(field : String, f : Dynamic -> (Void -> Dynamic)) {
    _generate = function(o) {
      if(!condition(o))
        return;
      var v = Reflect.field(o, field),
        k = fieldKey(v),
        g = gmap.get(k);
      if(g == null)
        gmap.set(fieldKey(v), g = f(v));
      Reflect.setField(o, name, g());
    }
    return obj;
  }

  static function fieldsKey(v : Array<Dynamic>) return "S:" + v.join("|");
  public function mapFields(fields : Array<String>, f : Array<Dynamic> -> (Void -> Dynamic)) {
    _generate = function(o) {
      if(!condition(o))
        return;
      var values = [];
      for(field in fields)
        values.push(Reflect.field(o, field));
      var k = fieldsKey(values),
        g = gmap.get(k);
      if(g == null)
        gmap.set(k, g = f(values));
      Reflect.setField(o, name, g());
    }
    return obj;
  }

  var _generate : Dynamic -> Void;
}
