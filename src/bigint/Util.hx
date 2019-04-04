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
				var a = [for (i in 0...t) BigInt.fromInt(i + 2)];
				return millerRabinTest(n, a);
			case v: return v;
		}
	}
	
	public static function isProbablePrime(v:BigInt, iterations = 5) {
		var isPrime = isBasicPrime(v);
		if (isPrime != null) return isPrime;
		var n = v.abs();
		var a = [for(i in 0...iterations) randBetween(BigInt.TWO, n.subtract(BigInt.TWO))];
		return millerRabinTest(n, a);
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
	
	public static function modInv(v:BigInt, o:BigInt):BigInt {
		var g = BigInt.gcd(v, o);
		if(g.neq(BigInt.ONE)) throw 'Inverse doesn\'t exist';
		var m = v.modPow(o.subtract(BigInt.TWO), o);
		return v.isNegative() ? m.subtract(o) : m;
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
	
	public static function randBetween(a:BigInt, b:BigInt) {
		var range:Int = b - a;
		if(range > 1 << 30) range = 1 << 30;
		return a.add(Std.random(range));
		
		// var low = BigInt.min(a, b), high = BigInt.max(a, b);
		// var range = high.subtract(low).add(BigInt.ONE);
		// if (range.isSmall) return low.add(Math.floor(Math.random() * range));
		// var digits = toBase(range, BASE).value;
		// var result = [], restricted = true;
		// for (var i = 0; i < digits.length; i++) {
		// 	var top = restricted ? digits[i] : BASE;
		// 	var digit = truncate(Math.random() * top);
		// 	result.push(digit);
		// 	if (digit < top) restricted = false;
		// }
		// return low.add(Integer.fromArray(result, BASE, false));
    }
	
	public static function toBase(n:BigInt, base:BigInt) {
		if (base.isZero()) {
			if (n.isZero()) return { value: [0], isNegative: false };
			throw "Cannot convert nonzero numbers to base 0.";
		}
		
		if (base.eq(BigInt.MINUS_ONE)) {
			if (n.isZero()) return { value: [0], isNegative: false };
			if (n.isNegative())
				return {
					value: {
						var v = [];
						for(i in 0...-n.toInt()) {
							v.push(1);
							v.push(0);
						}
						v;
					},
					isNegative: false
				};
			
			var v = [];
			for(i in 0...n.toInt() - 1) {
				v.push(0);
				v.push(1);
			}
			v.unshift(1);
			
			return {
				value: v,
				isNegative: false
			};
		}

		var neg = false;
		if (n.isNegative() && base.isPositive()) {
			neg = true;
			n = n.abs();
		}
		if (base.isUnit()) {
			if (n.isZero()) return { value: [0], isNegative: false };

			return {
				value: [for(i in 0...n.toInt()) 1],
				isNegative: neg
			};
		}
		var out = [];
		var left = n, divmod;
		while (left.isNegative() || left.compareAbs(base) >= 0) {
			divmod = left.divmod(base);
			left = divmod.quotient;
			var digit = divmod.remainder;
			if (digit.isNegative()) {
				digit = base.subtract(digit).abs();
				left = left.next();
			}
			out.push(digit.toInt());
		}
		out.push(left.toInt());
		out.reverse();
		return { value: out, isNegative: neg };
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