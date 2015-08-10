package rdg.util;

class Arrays  {
  public static function scanf<T>(arr : Array<T>, weightf : T -> Int -> Float, incremental = true) : Float -> Null<T> {
    var tot = 0.0,
      weights = [];
    if(incremental) {
      for(i in 0...arr.length) {
        weights[i] = (tot += weightf(arr[i], i));
      }
    } else {
      for(i in 0...arr.length) {
        weights[i] = weightf(arr[i], i);
      }
      tot = weights[weights.length-1];
    }

    function scan(v : Float, start : Int, end : Int) {
      if(start == end)
        return arr[start];
      var mid   = Math.floor((end - start) / 2) + start,
        value = weights[mid];
      if(v < value)
        return scan(v, start, mid);
      else
        return scan(v, mid+1, end);
    }

    return function(v : Float) {
      if(v < 0 || v > tot) // out of range
        return null;
      return scan(v, 0, weights.length - 1);
    }
  }

  public static function max<T>(arr : Array<T>, extractf : T -> Int -> Float) {
    var max = Math.NEGATIVE_INFINITY,
      v;
    for(i in 0...arr.length) {
      if((v = extractf(arr[i], i)) > max)
        max = v;
    }
    return max;
  }

  public static function sum<T>(arr : Array<T>, extractf : T -> Int -> Float) {
    var sum = 0.0;
    for(i in 0...arr.length)
      sum += extractf(arr[i], i);
    return sum;
  }
}
