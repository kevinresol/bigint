package;


class Base {
	macro function bigInt(ethis, v) return macro @:pos(v.pos) (($v:bigint.BigInt):Base.Wrapper);
}

abstract Expect<T>(Dynamic) {
	public macro function toEqualBigInt(ethis, v) return macro @:pos(v.pos) {
		var e = $ethis;
		var ev = (e.v:bigint.BigInt);
		var v = ($v:bigint.BigInt);
		${assert(v.pos)}
	}
	
	public macro function toBe(ethis, v) return macro @:pos(v.pos) {
		var e = $ethis;
		var ev = e.v;
		var v = $v;
		${assert(v.pos)}
	}
	
	static function assert(pos)
		return macro @:pos(pos) asserts.assert(
			e.negate == true ? ev != v : ev == v, 
			'negate: ' + e.negate + 
			', value: ' + Base.Expect.stringify(ev) + 
			', expected: ' + Base.Expect.stringify(v)+ 
			', value(type): ' + Type.typeof(ev) + 
			', expected(type): ' + Type.typeof(v) + 
			', ==: ' + (ev == v) + 
			', !=: ' + (ev != v)
		);
}

abstract Wrapper(Dynamic) {
	public macro function negate(ethis) return macro @:pos(ethis.pos) ($ethis:bigint.BigInt).negate();
	public macro function notEquals(ethis, v) return macro @:pos(v.pos) ($ethis:bigint.BigInt) != ($v:bigint.BigInt);
	public macro function greater(ethis, v) return macro @:pos(v.pos) ($ethis:bigint.BigInt) > ($v:bigint.BigInt);
	public macro function lesser(ethis, v) return macro @:pos(v.pos) ($ethis:bigint.BigInt) < ($v:bigint.BigInt);
	public macro function greaterOrEquals(ethis, v) return macro @:pos(v.pos) ($ethis:bigint.BigInt) >= ($v:bigint.BigInt);
	public macro function lesserOrEquals(ethis, v) return macro @:pos(v.pos) ($ethis:bigint.BigInt) <= ($v:bigint.BigInt);
	public macro function compareAbs(ethis, v) return macro @:pos(v.pos) ($ethis:bigint.BigInt).compareAbs($v);
	public macro function prev(ethis) return macro @:pos(ethis.pos) ($ethis:bigint.BigInt).prev();
	public macro function next(ethis) return macro @:pos(ethis.pos) ($ethis:bigint.BigInt).next();
	public macro function add(ethis, v) return macro @:pos(v.pos) (($ethis:bigint.BigInt) + ($v:bigint.BigInt):Base.Wrapper);
	public macro function plus(ethis, v) return macro @:pos(v.pos) (($ethis:bigint.BigInt) + ($v:bigint.BigInt):Base.Wrapper);
	public macro function subtract(ethis, v) return macro @:pos(v.pos) (($ethis:bigint.BigInt) - ($v:bigint.BigInt):Base.Wrapper);
	public macro function minus(ethis, v) return macro @:pos(v.pos) (($ethis:bigint.BigInt) - ($v:bigint.BigInt):Base.Wrapper);
	public macro function multiply(ethis, v) return macro @:pos(v.pos) (($ethis:bigint.BigInt) * ($v:bigint.BigInt):Base.Wrapper);
	public macro function times(ethis, v) return macro @:pos(v.pos) (($ethis:bigint.BigInt) * ($v:bigint.BigInt):Base.Wrapper);
	public macro function divide(ethis, v) return macro @:pos(v.pos) (($ethis:bigint.BigInt) / ($v:bigint.BigInt):Base.Wrapper);
	public macro function over(ethis, v) return macro @:pos(v.pos) (($ethis:bigint.BigInt) / ($v:bigint.BigInt):Base.Wrapper);
	public macro function mod(ethis, v) return macro @:pos(v.pos) (($ethis:bigint.BigInt) % ($v:bigint.BigInt):Base.Wrapper);
	public macro function pow(ethis, v) return macro @:pos(v.pos) ($ethis:bigint.BigInt).pow($v);
	public macro function modPow(ethis, v, m) return macro @:pos(v.pos) (($ethis:bigint.BigInt).modPow($v, $m):Base.Wrapper);
	public macro function modInv(ethis, v) return macro @:pos(v.pos) (($ethis:bigint.BigInt).modInv($v):Base.Wrapper);
	public macro function square(ethis) return macro @:pos(ethis.pos) (($ethis:bigint.BigInt).square():Base.Wrapper);
	public macro function abs(ethis) return macro @:pos(ethis.pos) (($ethis:bigint.BigInt).abs():Base.Wrapper);
	
	public macro function shiftRight(ethis, v) return macro @:pos(v.pos) (($ethis:bigint.BigInt).shiftRight($v):Base.Wrapper);
	public macro function shiftLeft(ethis, v) return macro @:pos(v.pos) (($ethis:bigint.BigInt).shiftLeft($v):Base.Wrapper);
	public macro function and(ethis, v) return macro @:pos(v.pos) (($ethis:bigint.BigInt).and($v):Base.Wrapper);
	public macro function or(ethis, v) return macro @:pos(v.pos) (($ethis:bigint.BigInt).or($v):Base.Wrapper);
	public macro function xor(ethis, v) return macro @:pos(v.pos) (($ethis:bigint.BigInt).xor($v):Base.Wrapper);
}