package ;

import tink.unit.*;
import tink.testrunner.*;
import bigint.*;

// Tests are ported from: https://github.com/peterolson/BigInteger.js/blob/master/spec/spec.js

class RunTests {
  static function main() {
    Runner.run(TestBatch.make([
      new Test(),
    ])).handle(Runner.exit);
  }
}