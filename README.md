Work in progress

# Big Integer
[![Build Status](https://travis-ci.com/kevinresol/bigint.svg?branch=master)](https://travis-ci.com/kevinresol/bigint)

### Blog Post

- http://www.kevinresol.com/2019-04-05/approaches-utilize-haxe-targets/

### Supported targets

- Java via `java.math.BigInteger` in Java's standard library.
- JavaScript via the `big-integer` npm package. (or add `-lib embed-js` to embed the library code).
- Python via native integer (python has unlimited integer size). Requires python 3.5+ for the `math.gcd` method.
- PHP via the GMP extension.


### TODO
- [ ] Pure Haxe implementation
