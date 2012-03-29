package rdg;

import rdg.data.CommunityColleges;
import rdg.GPicker;

class CommunityCollege
{
	public static function generator(?gen : F)
	{
		return new GPicker(CommunityColleges.data, gen).generate;
	}

	public static function nameGenerator(?gen : F)
	{
		var g = new GPicker(CommunityColleges.data, gen).generate;
		return function() return g().name;
	}
}