package rdg;

import rdg.data.InternetPopulations;

class InternetPopulation
{
	public static function generator(?gen : F)
	{
		var g = new GPicker(InternetPopulations.data, gen);
		return function() return g.generate().name;
	}

	public static function weighted(?gen : F)
	{
		var g = new GWeighted(InternetPopulations.data, function(item, _) return item.population, gen);
		return function() return g.generate().name;
	}

	public static function weightedByPercentageUsers(?gen : F)
	{
		var g = new GWeighted(InternetPopulations.data, function(item, _) return item.percent, gen);
		return function() return g.generate().name;
	}
}