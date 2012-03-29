package rdg;

using StringTools;

class FullName
{
	static function execute(pattern = "{name} {surname}", n : Void -> String, s : Void -> String)
	{
		return function() {
			return format(pattern, n(), s());
		};
	}

	public static function male(pattern = "{name} {surname}", ?gen : F)
	{
		return execute(pattern, Name.male(gen), Surname.generator(gen));
	}

	public static function female(pattern = "{name} {surname}", ?gen : F)
	{
		return execute(pattern, Name.female(gen), Surname.generator(gen));
	}

	public static function generator(pattern = "{name} {surname}", ?gen : F)
	{
		return execute(pattern, Name.generator(gen), Surname.generator(gen));
	}

	public static function weightedMale(pattern = "{name} {surname}", ?gen : F)
	{
		return execute(pattern, Name.weightedMale(gen), Surname.weighted(gen));
	}

	public static function weightedFemale(pattern = "{name} {surname}", ?gen : F)
	{
		return execute(pattern, Name.weightedFemale(gen), Surname.weighted(gen));
	}

	public static function weightedGenerator(pattern = "{name} {surname}", ?gen : F)
	{
		return execute(pattern, Name.weighted(gen), Surname.weighted(gen));
	}

	static function format(pattern : String, name : String, surname : String)
	{
		return pattern.replace("{name}", name).replace("{surname}", surname);
	}
}