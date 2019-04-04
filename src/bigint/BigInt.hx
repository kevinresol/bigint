package bigint;

@:forward
abstract BigInt(Impl) from Impl to Impl {
	
	public static final ZERO:BigInt = Impl.ZERO;
	public static final ONE:BigInt = Impl.ONE;
	public static final TWO:BigInt = Impl.TWO;
	public static final TEN:BigInt = Impl.TEN;
	public static final MINUS_ONE:BigInt = Impl.MINUS_ONE;
	public static final MINUS_TWO:BigInt = Impl.MINUS_TWO;
	public static final MINUS_TEN:BigInt = Impl.MINUS_TEN;
	
	@:from public static inline function fromString(v:String):BigInt return Impl.fromString(v);
	@:from public static inline function fromInt(v:Int):BigInt return Impl.fromInt(v);
	@:from public static inline function fromFloat(v:Float):BigInt return Impl.fromFloat(v);
	
	@:to public inline function toInt():Int return this.toInt();
	@:to public inline function toFloat():Float return this.toFloat();
	
	public inline function isPositive():Bool return this.isPositive();
	public inline function isNegative():Bool return this.isNegative();
	public inline function isEven():Bool return this.isEven();
	public inline function isOdd():Bool return this.isOdd();
	public inline function isZero():Bool return this.isZero();
	public inline function isOne():Bool return this.isOne();
	public inline function isUnit():Bool return this.isUnit();
	public inline function isPrime():Bool return this.isPrime();
	public inline function isProbablePrime(iterations:Int = 5):Bool return this.isProbablePrime(iterations);
	public inline function isDivisibleBy(o:BigInt):Bool return this.isDivisibleBy(o);
	
	public inline function abs():BigInt return this.abs();
	public inline function prev():BigInt return this.prev();
	public inline function next():BigInt return this.next();
	public inline function compare(o:BigInt):Int return this.compare(o);
	public inline function compareAbs(o:BigInt):Int return this.compareAbs(o);
	
	public static inline function max(a:BigInt, b:BigInt):BigInt return Impl.max(a, b);
	public static inline function min(a:BigInt, b:BigInt):BigInt return Impl.min(a, b);
	public static inline function gcd(a:BigInt, b:BigInt):BigInt return Impl.gcd(a, b);
	public static inline function lcm(a:BigInt, b:BigInt):BigInt return Impl.lcm(a, b);
	
	public inline function bitLength():Int return this.bitLength();
	public inline function pow(o:BigInt):BigInt return this.pow(o);
	public inline function divmod(o:BigInt):{quotient:BigInt, remainder:BigInt} return this.divmod(o);
	
	public inline function modPow(o:BigInt, m:BigInt):BigInt return this.modPow(o, m);
	public inline function modInv(o:BigInt):BigInt return this.modInv(o);
	public inline function square():BigInt return this.square();
	
	@:op(!A) public inline function not():BigInt return this.not();
	@:op(-A) public inline function negate():BigInt return this.negate();
	
	@:op(A>>B) public inline function shiftRight(o:BigInt):BigInt return this.shiftRight(o);
	@:op(A<<B) public inline function shiftLeft(o:BigInt):BigInt return this.shiftLeft(o);
	@:op(A&B) public inline function and(o:BigInt):BigInt return this.and(o);
	@:op(A|B) public inline function or(o:BigInt):BigInt return this.or(o);
	@:op(A^B) public inline function xor(o:BigInt):BigInt return this.xor(o);
	
	@:op(A==B) public inline function eq(o:BigInt):Bool return this.eq(o);
	@:op(A!=B) public inline function neq(o:BigInt):Bool return this.neq(o);
	@:op(A>B) public inline function gt(o:BigInt):Bool return this.gt(o);
	@:op(A<B) public inline function lt(o:BigInt):Bool return this.lt(o);
	@:op(A>=B) public inline function gte(o:BigInt):Bool return this.gte(o);
	@:op(A<=B) public inline function lte(o:BigInt):Bool return this.lte(o);
	@:op(A+B) public inline function add(o:BigInt):BigInt return this.add(o);
	@:op(A-B) public inline function subtract(o:BigInt):BigInt return this.subtract(o);
	@:op(A*B) public inline function multiply(o:BigInt):BigInt return this.multiply(o);
	@:op(A/B) public inline function divide(o:BigInt):BigInt return this.divide(o);
	@:op(A%B) public inline function mod(o:BigInt):BigInt return this.mod(o);
	
	@:op(A==B) public inline function eqInt(o:Int):Bool return eq(o);
	@:op(A!=B) public inline function neqInt(o:Int):Bool return neq(o);
	@:op(A>B) public inline function gtInt(o:Int):Bool return gt(o);
	@:op(A<B) public inline function ltInt(o:Int):Bool return lt(o);
	@:op(A>=B) public inline function gteInt(o:Int):Bool return gte(o);
	@:op(A<=B) public inline function lteInt(o:Int):Bool return lte(o);
	@:op(A+B) public inline function addInt(o:Int):BigInt return add(o);
	@:op(A-B) public inline function subtractInt(o:Int):BigInt return subtract(o);
	@:op(A*B) public inline function multiplyInt(o:Int):BigInt return multiply(o);
	@:op(A/B) public inline function divideInt(o:Int):BigInt return divide(o);
	@:op(A%B) public inline function modInt(o:Int):BigInt return mod(o);
}