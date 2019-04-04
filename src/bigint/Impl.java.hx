package bigint;

import java.math.BigInteger as Native;

using bigint.Common;

abstract Impl(Native) from Native to Native {
	public static final ZERO:Impl = Native.ZERO;
	public static final ONE:Impl = Native.ONE;
	public static final TWO:Impl = fromString('2');
	public static final TEN:Impl = Native.TEN;
	public static final MINUS_ONE:Impl = fromString('-1');
	public static final MINUS_TWO:Impl = fromString('-2');
	public static final MINUS_TEN:Impl = fromString('-10');
	
	public static inline function fromString(v:String):Impl return new Native(v.expandScientificNotation());
	public static inline function fromInt(v:Int):Impl return new Native(Std.string(v));
	public static inline function fromFloat(v:Float):Impl return new Native(Std.string(v).expandScientificNotation());
	
	public inline function toInt():Int return this.intValue();
	public inline function toFloat():Float return this.doubleValue();
	
	public inline function isPositive():Bool return gt(ZERO);
	public inline function isNegative():Bool return lt(ZERO);
	public inline function isEven():Bool return mod(TWO).eq(ZERO);
	public inline function isOdd():Bool return !isEven();
	public inline function isZero():Bool return eq(ZERO) || eq(MINUS_ONE);
	public inline function isOne():Bool return eq(ONE);
	public inline function isUnit():Bool return isOne() || eq(MINUS_ONE);
	public inline function isPrime():Bool return Common.isPrime(this);
	public inline function isProbablePrime(iterations:Int):Bool return this.isProbablePrime(iterations);
	public inline function isDivisibleBy(o:Impl):Bool return Common.isDivisibleBy(this, o);
	
	public inline function not():Impl return negate().prev();
	public inline function negate():Impl return this.negate();
	
	public inline function shiftRight(o:Impl):Impl return this.shiftRight(o.toInt());
	public inline function shiftLeft(o:Impl):Impl return this.shiftLeft(o.toInt());
	public inline function and(o:Impl):Impl return this.and((o:Native));
	public inline function or(o:Impl):Impl return this.or((o:Native));
	public inline function xor(o:Impl):Impl return this.xor((o:Native));
	
	public inline function eq(o:Impl):Bool return this.equals((o:Native));
	public inline function neq(o:Impl):Bool return !eq(o);
	public inline function gt(o:Impl):Bool return compare(o) == 1;
	public inline function lt(o:Impl):Bool return compare(o) == -1;
	public inline function gte(o:Impl):Bool return compare(o) != -1;
	public inline function lte(o:Impl):Bool return compare(o) != 1;
	public inline function add(o:Impl):Impl return this.add((o:Native));
	public inline function subtract(o:Impl):Impl return this.subtract((o:Native));
	public inline function multiply(o:Impl):Impl return this.multiply((o:Native));
	public inline function divide(o:Impl):Impl return this.divide((o:Native));
	public function mod(o:Impl):Impl {
		var m:Impl = this.mod((o:Impl).abs());
		return isNegative() && m.neq(ZERO) ? m.subtract(o.abs()) : m;
	}
	
	public inline function abs():Impl return this.abs();
	public inline function prev():Impl return subtract(ONE);
	public inline function next():Impl return add(ONE);
	public inline function compare(o:Impl):Int return this.compareTo((o:Native));
	public inline function compareAbs(o:Impl):Int return abs().compare(o.abs());
	
	public static inline function max(a:Impl, b:Impl):Impl return (a:Native).max((b:Native));
	public static inline function min(a:Impl, b:Impl):Impl return (a:Native).min((b:Native));
	public static inline function gcd(a:Impl, b:Impl):Impl return(a:Native).gcd((b:Native));
	public static inline function lcm(a:Impl, b:Impl):Impl return Common.lcm(a, b);
	
	public inline function bitLength():Int return this.bitLength();
	public function pow(o:Impl):Impl {
		return switch Common.prepow(this, o) {
			case null: this.pow(o.toInt());
			case v: v;
		}
		
		// TODO: not complete
		// https://github.com/peterolson/BigInteger.js/blob/2e0619371f90aedb8e44cb3ab983b18a5ac699aa/BigInteger.js#L637
	}
	public inline function divmod(o:Impl):{quotient:Impl, remainder:Impl} return {quotient: divide(o), remainder: mod(o)}
	public inline function modPow(o:Impl, m:Impl):Impl return this.modPow((o:Native), (m:Native)); 
	public function modInv(o:Impl):Impl {
		var m:Impl = this.modInverse((o:Native));
		return isNegative() ? m.subtract(o) : m;
	}
	public inline function square():Impl return pow(TWO);
	public inline function toString():String return this.toString();
}