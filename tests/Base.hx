package;

import bigint.*;

class Base {
	public function new() {}
	
	inline function describe(desc:String, f:Void->Void) f();
	inline function it(desc:String, f:Void->Void) f();
	
	inline function expect<T>(v:T) return new Expect(v);
	macro function bigInt(ethis, v);
}

typedef Exp<T> = {v:T, negate:Bool}

@:forward
abstract Expect<T>(Exp<T>) {
	public inline function new(v, ?negate) this = {v: v, negate: negate == true}
	public macro function toEqualBigInt(ethis, v);
	public macro function toBe(ethis, v);
	
	public inline function not() return new Expect(this.v, !this.negate);
	
	@:impl
	public static inline function toThrow(e:Exp<Void->Void>)
		return try {
			e.v();
			false;
		} catch(e:Dynamic) {
			true;
		}
	
	public static function stringify(v:Any):String {
		var s = Std.string(v);
		#if php
		if(s == '[object GMP]') return (v:BigInt).toString();
		#end
		return s;
		
	}
}

@:forward(add, toString, isPositive, isNegative, isZero, isUnit, isOdd, isEven, isDivisibleBy, isPrime, isProbablePrime, not, bitLength)
abstract Wrapper(BigInt) from BigInt to BigInt {
	public macro function negate(ethis);
	public macro function notEquals(ethis, v);
	public macro function greater(ethis, v);
	public macro function lesser(ethis, v);
	public macro function greaterOrEquals(ethis, v);
	public macro function lesserOrEquals(ethis, v);
	public macro function compareAbs(ethis, v);
	
	public macro function prev(ethis);
	public macro function next(ethis);
	public macro function add(ethis, v);
	public macro function plus(ethis, v);
	public macro function subtract(ethis, v);
	public macro function minus(ethis, v);
	public macro function multiply(ethis, v);
	public macro function times(ethis, v);
	public macro function divide(ethis, v);
	public macro function over(ethis, v);
	public macro function mod(ethis, v);
	public macro function pow(ethis, v);
	public macro function modPow(ethis, v, m);
	public macro function modInv(ethis, v, m);
	public macro function square(ethis);
	public macro function abs(ethis);
	
	public macro function shiftRight(ethis, v);
	public macro function shiftLeft(ethis, v);
	public macro function and(ethis, v);
	public macro function or(ethis, v);
	public macro function xor(ethis, v);
	
	
}