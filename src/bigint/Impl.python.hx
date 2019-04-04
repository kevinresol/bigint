package bigint;

import python.lib.Math as NativeMath;
import python.internal.UBuiltins as Global;

using bigint.Common;

abstract Impl(Int) from Int to Int {
	public static final ZERO:Impl = 0;
	public static final ONE:Impl = 1;
	public static final TWO:Impl = 2;
	public static final TEN:Impl = 10;
	public static final MINUS_ONE:Impl = -1;
	public static final MINUS_TWO:Impl = -2;
	public static final MINUS_TEN:Impl = -10;
	
	public static inline function fromString(v:String):Impl return Global.int(v.expandScientificNotation());
	public static inline function fromInt(v:Int):Impl return v;
	public static inline function fromFloat(v:Float):Impl return Global.int(v);
	
	public inline function toInt():Int return this;
	public inline function toFloat():Float return this;
	
	public inline function sign():Int return this == 0 ? 0 : this > 0 ? 1 : -1;
	public inline function isPositive():Bool return this > 0;
	public inline function isNegative():Bool return this < 0;
	public inline function isEven():Bool return this % 2 == 0;
	public inline function isOdd():Bool return !isEven();
	public inline function isZero():Bool return this == 0;
	public inline function isOne():Bool return this == 1;
	public inline function isUnit():Bool return this == 1 || this == -1;
	public inline function isPrime():Bool return Common.isPrime(this);
	public inline function isProbablePrime(iterations:Int):Bool return Common.isProbablePrime(this, iterations);
	public inline function isDivisibleBy(o:Impl):Bool return Common.isDivisibleBy(this, o);
	
	public inline function negate():Impl return -this;
	
	public inline function shiftRight(o:Impl):Impl return o.isNegative() ? this << -o : this >> o;
	public inline function shiftLeft(o:Impl):Impl return o.isNegative() ? this >> -o : this << o;
	public inline function not():Impl return ~this;
	public inline function and(o:Impl):Impl return this & o;
	public inline function or(o:Impl):Impl return this | o;
	public inline function xor(o:Impl):Impl return this ^ o;
	
	public inline function eq(o:Impl):Bool return this == o;
	public inline function neq(o:Impl):Bool return this != o;
	public inline function gt(o:Impl):Bool return this > o.toInt();
	public inline function lt(o:Impl):Bool return this < o.toInt();
	public inline function gte(o:Impl):Bool return this >= o.toInt();
	public inline function lte(o:Impl):Bool return this <= o.toInt();
	public inline function add(o:Impl):Impl return this + o.toInt();
	public inline function subtract(o:Impl):Impl return this - o.toInt();
	public inline function multiply(o:Impl):Impl return this * o.toInt();
	public inline function divide(o:Impl):Impl {
		var m:Impl = python.Syntax.code('({0} // {1})', abs(), o.abs());
		return sign() == o.sign() ? m : m.negate();
	}
	public function mod(o:Impl):Impl {
		var m:Impl = python.Syntax.code('({0} % {1})', this, o.abs());
		return isNegative() && m.neq(ZERO) ? m.subtract(o.abs()) : m;
	}
	
	public inline function abs():Impl return python.Syntax.code('abs({0})', this);
	public inline function prev():Impl return this - 1;
	public inline function next():Impl return this + 1;
	public inline function compare(o:Impl):Int return this > o.toInt() ? 1 : this < o.toInt() ? -1 : 0;
	public inline function compareAbs(o:Impl):Int return abs().compare(o.abs());
	
	public static inline function max(a:Impl, b:Impl):Impl return a.toInt() > b.toInt() ? a : b;
	public static inline function min(a:Impl, b:Impl):Impl return a.toInt() < b.toInt() ? a : b;
	public static inline function gcd(a:Impl, b:Impl):Impl return (cast NativeMath).gcd(a, b); // TODO math.gcd only available since python 3.5
	public static inline function lcm(a:Impl, b:Impl):Impl return Common.lcm(a, b);
	
	public function bitLength():Int return python.Syntax.code('{0}.bit_length()', this);
	public function pow(o:Impl):Impl {
		return switch Common.prepow(this, o) {
			case null: return python.Syntax.code('({0} ** {1})', this, o);
			case v: v;
		}
	}
	public inline function divmod(o:Impl):{quotient:Impl, remainder:Impl} return {quotient: divide(o), remainder: mod(o)}
	
	public inline function modPow(o:Impl, m:Impl):Impl return python.Syntax.code('pow({0}, {1}, {2})', this, o, m);
	public inline function modInv(o:Impl):Impl return Common.modInv(this, o);
	public inline function square():Impl return python.Syntax.code('pow({0}, 2)', this);
	public inline function toString():String return Global.str(this);
}
