package bigint;

using StringTools;

class Util {
	
	public static function expandScientificNotation(v:String) {
		return switch v.toLowerCase().split('e') {
			case [d]: d;
			case [d, e]:
				switch d.split('.') {
					case [v]: v + ''.rpad('0', Std.parseInt(e));
					case [d, f]: d + f.rpad('0', Std.parseInt(e));
					case _: throw 'Invalid value';
				}
			case _: throw 'Invalid value';
		}
	}
	
	public static function isDivisibleBy(v:BigInt, o:BigInt):Bool {
		if (o.isZero()) return false;
		if (o.isUnit()) return true;
		if (o.compareAbs(2) == 0) return v.isEven();
		return v.mod(o).isZero();
	}
	
	public static function isPrime(v:BigInt):Bool {
		switch isBasicPrime(v) {
			case null:
				var n = v.abs();
				var bits = n.bitLength();
				if (bits <= 64)
					return millerRabinTest(n, [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37]);
				var logN = Math.log(2) * bits;
				
				var strict = true; // TODO: make this configurable
				var t = Math.ceil((strict == true) ? (2 * Math.pow(logN, 2)) : logN);
				var a = [];
				for (i in 0...t) {
					a.push(BigInt.fromInt(i + 2));
				}
				return millerRabinTest(n, a);
			case v: return v;
		}
	}
	
	public static function isBasicPrime(v:BigInt):Null<Bool> {
		var n = v.abs();
		if (n.isUnit()) return false;
		if (n.eq(2) || n.eq(3) || n.eq(5)) return true;
		if (n.isEven() || n.isDivisibleBy(3) || n.isDivisibleBy(5)) return false;
		if (n.lt(49)) return true;
		return null;
	}
	
	public static function prepow(v:BigInt, e:BigInt):BigInt {
		if(e.eq(BigInt.ZERO)) return BigInt.ONE;
		if(v.eq(BigInt.ZERO)) return BigInt.ZERO;
		if(v.eq(BigInt.ONE)) return BigInt.ONE;
		if(v.eq(BigInt.MINUS_ONE)) return e.isEven() ? BigInt.ONE : BigInt.MINUS_ONE;
		if(e.isNegative()) return BigInt.ZERO;
		return null;
	}
	
	public static function lcm(a:BigInt, b:BigInt):BigInt {
		var a = a.abs();
		var b = b.abs();
		return a.divide(BigInt.gcd(a, b)).multiply(b);
	}
	
	public static function millerRabinTest(n:BigInt, a:Array<BigInt>) {
		var nPrev = n.prev(),
			b = nPrev,
			r = 0;
		while (b.isEven()) {
			b = b.divide(BigInt.TWO);
			r++;
		}
		for (i in 0...a.length) {
			if (n.lt(a[i])) continue;
			var x = a[i].modPow(b, n);
			if (x.isUnit() || x.eq(nPrev)) continue;
			
			var cont = false;
			var d = r - 1;
			while(d != 0) {
				x = x.square().mod(n);
				if (x.isUnit()) return false;
				if (x.eq(nPrev)) {
					cont = true;
					break;
				}
				d--;
			}
			if(cont) continue;
			return false;
		}
		return true;
	}
	
	// public static function integerLogarithm(value:BigInt, base:BigInt):{p:BigInt, e:Int} {
	// 	if (!base.isNegative()) {
	// 		var tmp = integerLogarithm(value, base.square(base));
	// 		var p = tmp.p;
	// 		var e = tmp.e;
	// 		var t = p.multiply(base);
	// 		return t.compare(value) <= 0 ? { p: t, e: e * 2 + 1 } : { p: p, e: e * 2 };
	// 	}
	// 	return { p: BigInt.ONE, e: 0 };
	// }
}