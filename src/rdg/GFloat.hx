package rdg;

class GFloat implements IGenerator<Float>
{
	var gen : F;
	var start : Float;
	var end : Float;
	public function new(start : Float, end : Float, ?gen : F)
	{
		if(start > end)
		{
			var t = start;
			start = end;
			end = t;
		}
		this.start = start;
		this.end = end;
		this.gen = null == gen ? Math.random : gen;
	}

	public function generate()
	{
		return gen() * (end - start) + start;
	}
}