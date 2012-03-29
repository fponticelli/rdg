package rdg;

class Gen
{
	public static function int(min : Int, max : Int, ?gen : F)
	{
		return new GInt(min, max + 1, gen).generate;
	}

	public static function bool(trues = 0.5, ?gen : F)
	{
		return new GBool(trues, gen).generate;
	}

	public static function float(min : Float, max : Float, ?decimals = -1, ?gen : F)
	{
		var f = new GFloat(min, max, gen).generate;
		if(decimals >= 0)
		{
			var gd = new GDecimal(f, decimals);
			f = gd.generate;
		}
		return f;
	}

	public static function object<T>(?handler : GObject<T> -> Void)
	{
		var ob = new GObject();
		if(null != handler)
			handler(ob);
		return ob.generate;
	}

	public static function array<T>(min : Int, ?max : Int, valuegen : Void -> T, ?rangegen : F)
	{
		if(null == max)
			max = min;
		var range = int(min, max, rangegen);
		return function()
		{
			var result = [];
			for(i in 0...range())
				result.push(valuegen());
			return result;
		}
	}

	public static function list<T>(min : Int, max : Int, valuegen : Void -> T, ?rangegen : F)
	{
		var range = int(min, max, rangegen);
		return function()
		{
			var result = new List();
			for(i in 0...range())
				result.add(valuegen());
			return result;
		}
	}

	public static function date(min : Date, max : Date, periodicity = "hour", ?gen : F)
	{
		var start = min.getTime(),
			end   = max.getTime(),
			float = float(start, end, gen);
		return function()
		{
			var d = Date.fromTime(float());
			switch(periodicity)
			{
				case "ms", "millisecond" : return d;
				case "second":             return new Date(d.getFullYear(), d.getMonth(), d.getDate(), d.getHours(), d.getMinutes(), d.getSeconds());
				case "minute":             return new Date(d.getFullYear(), d.getMonth(), d.getDate(), d.getHours(), d.getMinutes(), 0);
				case "hour":               return new Date(d.getFullYear(), d.getMonth(), d.getDate(), d.getHours(), 0, 0);
				case "day":                return new Date(d.getFullYear(), d.getMonth(), d.getDate(), 0, 0, 0);
				case "month":              return new Date(d.getFullYear(), d.getMonth(), 1, 0, 0, 0);
				case "year":               return new Date(d.getFullYear(), 0, 1, 0, 0, 0);
				default:
					return throw Std.format("invalid periodicity '$periodicity'");
			}
		}
	}

	public static function pick<T>(values : Array<T>, ?gen : F)
	{
		return new GPicker(values, gen).generate;
	}

	public static function pickWeighted<TIn, TOut>(values : Array<TIn>, weightf : TIn -> Int -> Float, ?extractf : TIn -> TOut, ?gen : F)
	{
		// since weighted generators are heavy we cache them
		if(null == extractf)
			extractf = cast function(o, _) return o;
		var g = new GWeighted(values, weightf, gen).generate;
		return function()
		{
			return extractf(g());
		};
	}

	public static function sequence(start = 1, ?end : Int)
	{
		var v = start - 1;
		return function()
		{
			v++;
			if(null != end && v > end)
				v = start - 1;
			return v;
		}
	}

	public static function map<TIn, TOut>(f : Void -> TIn, m : TIn -> TOut) : Void -> TOut
	{
		return function() return m(f());
	}

	static var chars = ["0","1","2","3","4","5","6","7","8","9","A","B","D","E","F","G","H","J","K","M","N","P","Q","R","T","U","V","W","Y"];
	public static function UID(len = 10, ?gen : F)
	{
		var r = Gen.pick(chars, gen);
		return function()
		{
			var buf = new StringBuf();
			for(i in 0...len)
				buf.add(r());
			return buf.toString();
		}
	}
}