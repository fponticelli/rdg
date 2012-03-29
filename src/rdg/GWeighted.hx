package rdg;

import rdg.util.Arrays;

// TODO this can be implemented to be a lot faster by storing the incremental weights and accessing the array randomly
class GWeighted<T> implements IGenerator<T>
{
	var total : Float;
	var gen : F;
	var scanner : Float -> T;
	public function new(items : Array<T>, weightf : T -> Int -> Float, ?gen : F)
	{
		total    = Arrays.sum(items,   weightf);
		scanner  = Arrays.scanf(items, weightf);
		this.gen = null == gen ? Math.random : gen;
	}

	public function generate()
	{
		return scanner(gen()*total);
	}
}