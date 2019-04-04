package ;

import tink.unit.*;
import tink.testrunner.*;
import bigint.*;

// Tests are ported from: https://github.com/peterolson/BigInteger.js/blob/master/spec/spec.js

class RunTests {
  static function main() {
    Runner.run(
      TestBatch.make([
        new Test(),
      ])
      , new FilterReporter() // comment out this line to show full report
    ).handle(Runner.exit);
  }
}

// skip reporting success cases
class FilterReporter extends tink.testrunner.Reporter.BasicReporter {
  override function report(v:tink.testrunner.Reporter.ReportType) {
    return switch v {
      case Assertion(assertion) if(tink.core.Outcome.OutcomeTools.isSuccess(assertion.holds)): tink.core.Future.NOISE;
      case _: super.report(v);
    }
  }
}