package bigint;

using bigint.Common;

abstract Impl(Gmp) from Gmp to Gmp {
	public static final ZERO:Impl = fromInt(0);
	public static final ONE:Impl = fromInt(1);
	public static final TWO:Impl = fromInt(2);
	public static final TEN:Impl = fromInt(10);
	public static final MINUS_ONE:Impl = fromInt(-1);
	public static final MINUS_TWO:Impl = fromInt(-2);
	public static final MINUS_TEN:Impl = fromInt(-10);
	
	public static inline function fromString(v:String):Impl return Gmp.gmp_init(v.trimLeadingZeroes().expandScientificNotation());
	public static inline function fromInt(v:Int):Impl return Gmp.gmp_init(v);
	public static inline function fromFloat(v:Float):Impl return Gmp.gmp_init(php.Syntax.code('(int){0}', v));
	
	public inline function toInt():Int return Gmp.gmp_intval(this);
	public inline function toFloat():Float return Gmp.gmp_intval(this);
	
	public inline function isPositive():Bool return gt(ZERO);
	public inline function isNegative():Bool return lt(ZERO);
	public inline function isEven():Bool return mod(TWO).eq(ZERO);
	public inline function isOdd():Bool return !isEven();
	public inline function isZero():Bool return eq(ZERO) || eq(MINUS_ONE);
	public inline function isOne():Bool return eq(ONE);
	public inline function isUnit():Bool return isOne() || eq(MINUS_ONE);
	public inline function isPrime():Bool return Common.isPrime(this);
	public inline function isProbablePrime(iterations:Int):Bool return Common.isProbablePrime(this, iterations);
	public inline function isDivisibleBy(o:Impl):Bool return Common.isDivisibleBy(this, o);
	
	public inline function not():Impl return negate().prev();
	public inline function negate():Impl return Gmp.gmp_neg(this);
	
	inline function rshift(o:Int):Impl return Gmp.gmp_div(this, Gmp.gmp_pow(TWO, o));
	inline function lshift(o:Int):Impl return Gmp.gmp_mul(this, Gmp.gmp_pow(TWO, o));
	inline function pshift(v:Impl, o:Impl):Impl return v.isNegative() && v.isOdd() ? o.prev() : o;
	public inline function shiftRight(o:Impl):Impl return pshift(this, o.isNegative() ? lshift(-o.toInt()) : rshift(o.toInt()));
	public inline function shiftLeft(o:Impl):Impl return pshift(this, o.isNegative() ? rshift(-o.toInt()) : lshift(o.toInt()));
	public inline function and(o:Impl):Impl return Gmp.gmp_and(this, o);
	public inline function or(o:Impl):Impl return Gmp.gmp_or(this, o);
	public inline function xor(o:Impl):Impl return Gmp.gmp_xor(this, o);
	
	public inline function eq(o:Impl):Bool return compare(o) == 0;
	public inline function neq(o:Impl):Bool return !eq(o);
	public inline function gt(o:Impl):Bool return compare(o) > 0;
	public inline function lt(o:Impl):Bool return compare(o) < 0;
	public inline function gte(o:Impl):Bool return compare(o) >= 0;
	public inline function lte(o:Impl):Bool return compare(o) <= 0;
	public inline function add(o:Impl):Impl return Gmp.gmp_add(this, o);
	public inline function subtract(o:Impl):Impl return Gmp.gmp_sub(this, o);
	public inline function multiply(o:Impl):Impl return Gmp.gmp_mul(this, o);
	public inline function divide(o:Impl):Impl return Gmp.gmp_div(this, o);
	public function mod(o:Impl):Impl {
		var m:Impl = Gmp.gmp_mod(this, o);
		return isNegative() && m.neq(ZERO) ? m.subtract(o.abs()) : m;
	}
	
	public inline function abs():Impl return Gmp.gmp_abs(this);
	public inline function prev():Impl return subtract(ONE);
	public inline function next():Impl return add(ONE);
	public inline function compare(o:Impl):Int return Gmp.gmp_cmp(this, o);
	public inline function compareAbs(o:Impl):Int return abs().compare(o.abs());
	
	public static inline function max(a:Impl, b:Impl):Impl return a.gt(b) ? a : b;
	public static inline function min(a:Impl, b:Impl):Impl return a.lt(b) ? a : b;
	public static inline function gcd(a:Impl, b:Impl):Impl return Gmp.gmp_gcd(a, b);
	public static inline function lcm(a:Impl, b:Impl):Impl return Common.lcm(a, b); // if php >= 7.3: return Gmp.gmp_lcm(a, b);
	
	public inline function bitLength():Int return Common.bitLength(this);
	public function pow(o:Impl):Impl {
		return switch Common.prepow(this, o) {
			case null: Gmp.gmp_pow(this, o.toInt());
			case v: v;
		}
		
		// TODO: not complete
		// https://github.com/peterolson/BigInteger.js/blob/2e0619371f90aedb8e44cb3ab983b18a5ac699aa/BigInteger.js#L637
	}
	public inline function divmod(o:Impl):{quotient:Impl, remainder:Impl} return {quotient: divide(o), remainder: mod(o)}
	public inline function modPow(o:Impl, m:Impl):Impl return Gmp.gmp_powm(this, o, m);
	public function modInv(o:Impl):Impl {
		var m:Impl = Gmp.gmp_invert(this, o);
		return isNegative() ? m.subtract(o) : m;
	}
	public inline function square():Impl return pow(TWO);
	public inline function toString():String return Gmp.gmp_strval(this);
}

@:phpGlobal
extern class Gmp {
	static function gmp_abs(a:Gmp):Gmp;
	static function gmp_add(a:Gmp, b:Gmp):Gmp;
	static function gmp_and(a:Gmp, b:Gmp):Gmp;
	static function gmp_binomial():Gmp;
	static function gmp_clrbit():Gmp;
	static function gmp_cmp(a:Gmp, b:Gmp):Int;
	static function gmp_com():Gmp;
	static function gmp_div_q(a:Gmp, b:Gmp):Gmp;
	static function gmp_div_qr(a:Gmp, b:Gmp):Array<Gmp>;
	static function gmp_div_r(a:Gmp, b:Gmp):Gmp;
	static function gmp_div(a:Gmp, b:Gmp):Gmp;
	static function gmp_divexact(a:Gmp, b:Gmp):Gmp;
	static function gmp_export():Gmp;
	static function gmp_fact():Gmp;
	static function gmp_gcd(a:Gmp, b:Gmp):Gmp;
	static function gmp_gcdext():Gmp;
	static function gmp_hamdist():Gmp;
	static function gmp_import():Gmp;
	static function gmp_init(n:Any, ?b:Any):Gmp;
	static function gmp_intval(n:Gmp):Int;
	static function gmp_invert(a:Gmp, b:Gmp):Gmp;
	static function gmp_jacobi():Gmp;
	static function gmp_kronecker():Gmp;
	static function gmp_lcm(a:Gmp, b:Gmp):Gmp;
	static function gmp_legendre():Gmp;
	static function gmp_mod(a:Gmp, b:Gmp):Gmp;
	static function gmp_mul(a:Gmp, b:Gmp):Gmp;
	static function gmp_neg(a:Gmp):Gmp;
	static function gmp_nextprime():Gmp;
	static function gmp_or(a:Gmp, b:Gmp):Gmp;
	static function gmp_perfect_power():Gmp;
	static function gmp_perfect_square():Gmp;
	static function gmp_popcount():Gmp;
	static function gmp_pow(a:Gmp, b:Int):Gmp;
	static function gmp_powm(a:Gmp, b:Gmp, c:Gmp):Gmp;
	static function gmp_prob_prime():Gmp;
	static function gmp_random_bits():Gmp;
	static function gmp_random_range():Gmp;
	static function gmp_random_seed():Gmp;
	static function gmp_random():Gmp;
	static function gmp_root():Gmp;
	static function gmp_rootrem():Gmp;
	static function gmp_scan0():Gmp;
	static function gmp_scan1():Gmp;
	static function gmp_setbit():Gmp;
	static function gmp_sign(a:Gmp):Int;
	static function gmp_sqrt(a:Gmp):Gmp;
	static function gmp_sqrtrem():Gmp;
	static function gmp_strval(a:Gmp):php.NativeString;
	static function gmp_sub(a:Gmp, b:Gmp):Gmp;
	static function gmp_testbit():Gmp;
	static function gmp_xor(a:Gmp, b:Gmp):Gmp;
}