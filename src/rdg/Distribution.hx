package rdg;

class Distribution
{
//	public static inline var TWO_PI = 6.283185307179586477;
//	public static inline var E      = 2.718281828459045235;
//	public static inline var LN10   = 2.302585092994046;

	public static function equation(eq : Float -> Float, ?gen : F)
	{
		if(null == gen)
			gen = Math.random;
		return function()
		{
			return eq(gen());
		}
	}

	public static function normalDistribution(samples = 4, ?gen : F) : Void -> Float
	{
		if(null == gen)
			gen = Math.random;
		return function()
		{
			var c = 0.0;
			for(i in 0...samples)
				c += gen();
			return c / samples;
		}
	}

	public static function sin(?gen : F) : Void -> Float
	{
		if(null == gen)
			gen = Math.random;
		return function()
		{
			return gen() * Math.PI;
		}
	}
}