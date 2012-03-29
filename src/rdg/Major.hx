package rdg;

import rdg.data.Majors;
import rdg.GPicker;

class Major
{
	public static function major(?gen : F)
	{
		return new GPicker(Majors.data, gen).generate;
	}

	public static function majorBySchool(school : String, ?gen : F)
	{
		return new GPicker(Majors.majorsBySchool(school), gen).generate;
	}

	public static function majorByDegree(degree : String, ?gen : F)
	{
		return new GPicker(Majors.majorsByDegree(degree), gen).generate;
	}

	public static function majorBySchoolAndDegree(school : String, degree : String, ?gen : F)
	{
		return new GPicker(Majors.majorsBySchoolAndDegree(school, degree), gen).generate;
	}

	public static function school(?gen : F)
	{
		return new GPicker(Majors.schools(), gen).generate;
	}

	public static function degree(?gen : F)
	{
		return new GPicker(Majors.degrees(), gen).generate;
	}

	public static function schoolByDegree(degree : String, ?gen : F)
	{
		return new GPicker(Majors.schoolsByDegree(degree), gen).generate;
	}

	public static function degreeBySchool(school : String, ?gen : F)
	{
		return new GPicker(Majors.degreesBySchool(school), gen).generate;
	}
}