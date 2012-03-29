package rdg.util;

import utest.Assert;

class TestArrays
{
	public function new() { }

	public function testScan()
	{
		var values = [{ v : "A", w : 10.0 }, { v : "B", w : 10.0 }, { v : "C", w : 10.0 }, { v : "D", w : 10.0 }, { v : "E", w : 20.0 }];

		var f = Arrays.scanf(values, function(o : { w : Float, v : String }, _) return o.w);

		Assert.equals(null, f(-1));
		Assert.equals("A",  f(5).v);
		Assert.equals("B",  f(10).v);
		Assert.equals("B",  f(15).v);
		Assert.equals("C",  f(20).v);
		Assert.equals("C",  f(25).v);
		Assert.equals("D",  f(30).v);
		Assert.equals("D",  f(35).v);
		Assert.equals("E",  f(40).v);
		Assert.equals("E",  f(50).v);
		Assert.equals("E",  f(55).v);
		Assert.equals("E",  f(60).v);
		Assert.equals(null, f(61));
	}
}