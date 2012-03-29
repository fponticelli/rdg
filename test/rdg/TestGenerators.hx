package rdg;

import utest.Assert;

class TestGenerators
{
	public function new() { }

	function decimalsGenerator(step : Float)
	{
		var value = -step;
		return function()
		{
			value += step;
			if(value == 1)
				value = 0;
			return value;
		}
	}

	public function testInt()
	{
		var ints = new GInt(5, 10, decimalsGenerator(0.2));

		Assert.equals(5, ints.generate());
		Assert.equals(6, ints.generate());
		Assert.equals(7, ints.generate());
		Assert.equals(8, ints.generate());
		Assert.equals(9, ints.generate());
	}

	public function testPicker()
	{
		var pick = new GPicker(["a", "b", "c", "d"], decimalsGenerator(0.25));

		Assert.equals("a", pick.generate());
		Assert.equals("b", pick.generate());
		Assert.equals("c", pick.generate());
		Assert.equals("d", pick.generate());
	}

	public function testWeighterPicker()
	{
		var pick = new GWeighted(
			[
				{ value : "a", weight : 1.0 },
				{ value : "b", weight : 2.0 },
				{ value : "c", weight : 3.0 },
				{ value : "d", weight : 4.0 }
			],
			function(item, _) return item.weight,
			decimalsGenerator(0.1));

		Assert.equals("a", pick.generate().value);
		Assert.equals("b", pick.generate().value);
		Assert.equals("b", pick.generate().value);
		Assert.equals("c", pick.generate().value);
		Assert.equals("c", pick.generate().value);
		Assert.equals("c", pick.generate().value);
		Assert.equals("d", pick.generate().value);
		Assert.equals("d", pick.generate().value);
		Assert.equals("d", pick.generate().value);
		Assert.equals("d", pick.generate().value);
	}

	public function testEmails()
	{
		var generate = Email.generator(),
			emails = [];
		var test = ~/@[^.]+\./;
		for(i in 0...200)
		{
			var value = generate();
			Assert.isTrue(test.match(value), "test not passed for " + value);
		}
	}
}