package bigint;

using bigint.Util;

abstract Impl(Native) from Native to Native {
	public static final ZERO:Impl = Native.const(0);
	public static final ONE:Impl = Native.const(1);
	public static final TWO:Impl = Native.const(2);
	public static final TEN:Impl = Native.const(10);
	public static final MINUS_ONE:Impl = Native.const(-1);
	public static final MINUS_TWO:Impl = Native.const(-2);
	public static final MINUS_TEN:Impl = Native.const(-10);
	
	public static inline function fromString(v:String):Impl return new Native(v);
	public static inline function fromInt(v:Int):Impl return new Native(v);
	public static inline function fromFloat(v:Float):Impl return new Native(v);
	
	public inline function toInt():Int return cast this.toJSNumber();
	public inline function toFloat():Float return this.toJSNumber();
	
	public inline function isPositive():Bool return this.isPositive();
	public inline function isNegative():Bool return this.isNegative();
	public inline function isEven():Bool return this.isEven();
	public inline function isOdd():Bool return this.isOdd();
	public inline function isZero():Bool return this.isZero();
	public inline function isOne():Bool return eq(ONE);
	public inline function isUnit():Bool return this.isUnit();
	public inline function isPrime():Bool return this.isPrime();
	public inline function isProbablePrime(iterations:Int):Bool return this.isProbablePrime(iterations);
	public inline function isDivisibleBy(o:Impl):Bool return this.isDivisibleBy(o);
	
	public inline function negate():Impl return this.negate();
	
	public inline function shiftRight(o:Impl):Impl return this.shiftRight(o);
	public inline function shiftLeft(o:Impl):Impl return this.shiftLeft(o);
	public inline function not():Impl return this.not();
	public inline function and(o:Impl):Impl return this.and(o);
	public inline function or(o:Impl):Impl return this.or(o);
	public inline function xor(o:Impl):Impl return this.xor(o);
	
	public inline function eq(o:Impl):Bool return this.eq(o);
	public inline function neq(o:Impl):Bool return this.neq(o);
	public inline function gt(o:Impl):Bool return this.gt(o);
	public inline function lt(o:Impl):Bool return this.lt(o);
	public inline function gte(o:Impl):Bool return this.geq(o);
	public inline function lte(o:Impl):Bool return this.leq(o);
	public inline function add(o:Impl):Impl return this.add(o);
	public inline function subtract(o:Impl):Impl return this.subtract(o);
	public inline function multiply(o:Impl):Impl return this.multiply(o);
	public inline function divide(o:Impl):Impl return this.divide(o);
	public inline function mod(o:Impl):Impl return this.mod(o);
	
	public inline function abs():Impl return this.abs();
	public inline function prev():Impl return this.prev();
	public inline function next():Impl return this.next();
	public inline function compare(o:Impl):Int return this.compareTo(o);
	public inline function compareAbs(o:Impl):Int return this.compareAbs(o);
	
	public static inline function max(a:Impl, b:Impl):Impl return Native.max(a, b);
	public static inline function min(a:Impl, b:Impl):Impl return Native.min(a, b);
	public static inline function gcd(a:Impl, b:Impl):Impl return Native.gcd(a, b);
	public static inline function lcm(a:Impl, b:Impl):Impl return Native.lcm(a, b);
	
	public inline function bitLength():Int return this.bitLength();
	public inline function pow(o:Impl):Impl return this.pow(o);
	public inline function divmod(o:Impl):{quotient:Impl, remainder:Impl} return this.divmod(o);
	
	public inline function modPow(o:Impl, m:Impl):Impl return this.modPow(o, m); 
	public inline function modInv(o:Impl):Impl return this.modInv(o); 
	public inline function square():Impl return this.square();
	public inline function toString():String return this.toString();
	
	
}

#if embed_js
@:native('bigInt')
#else
@:jsRequire('big-integer')
#end
private extern class Native {
	@:selfCall
	function new(v:Any);
	
	#if embed_js
	private static function __init__():Void {
		embed.Js.from('http://cdnjs.cloudflare.com/ajax/libs/big-integer/1.6.43/BigInteger.min.js');
	}
	#end
	
	public static inline function const(i:Int):Native return js.Syntax.code('{0}[{1}]', Native, i);
	
	static function fromArray(digits:Array<Int>, base:Int, ?isNegative:Bool):Native;
	static function gcd(a:Any, b:Any):Native;
	static function isInstance(x:Any):Native;
	static function lcm(a:Any, b:Any):Native;
	static function max(a:Any, b:Any):Native;
	static function min(a:Any, b:Any):Native;
	static function randBetween(min:Any, max:Any):Native;
	
	function abs():Native;
	function add(number:Any):Native;
	function and(number:Any):Native;
	function bitLength():Int;
	function compare(number:Any):Int;
	function compareAbs(number:Any):Int;
	function compareTo(number:Any):Int;
	function divide(number:Any):Native;
	function divmod(number:Any):{quotient:Native, remainder:Native};
	function eq(number:Any):Bool;
	function equals(number:Any):Bool;
	function geq(number:Any):Bool;
	function greater(number:Any):Bool;
	function greaterOrEquals(number:Any):Bool;
	function gt(number:Any):Bool;
	function isDivisibleBy(number:Any):Bool;
	function isEven():Bool;
	function isNegative():Bool;
	function isOdd():Bool;
	function isPositive():Bool;
	function isPrime():Bool;
	function isProbablePrime(iterations:Int):Bool;
	function isUnit():Bool;
	function isZero():Bool;
	function leq(number:Any):Bool;
	function lesser(number:Any):Bool;
	function lesserOrEquals(number:Any):Bool;
	function lt(number:Any):Bool;
	function minus(number:Any):Native;
	function mod(number:Any):Native;
	function modInv(mod:Any):Native;
	function modPow(exp:Any, mod:Any):Native;
	function multiply(number:Any):Native;
	function negate():Native;
	function neq(number:Any):Bool;
	function next():Native;
	function not():Native;
	function notEquals(number:Any):Bool;
	function or(number:Any):Native;
	function over(number:Any):Native;
	function plus(number:Any):Native;
	function pow(number:Any):Native;
	function prev():Native;
	function remainder(number:Any):Native;
	function shiftLeft(n:Any):Native;
	function shiftRight(n:Any):Native;
	function square():Native;
	function subtract(number:Any):Native;
	function times(number:Any):Native;
	function toArray(radix:Any):Array<Any>;
	function toJSNumber():Float;
	function xor(number:Any):Native;
	function toString():String;
}