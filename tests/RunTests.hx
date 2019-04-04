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
  var count = 0;
  override function report(v:tink.testrunner.Reporter.ReportType) {
    return switch v {
      case CaseStart(_):  
        count = 0;
        super.report(v);
      case Assertion(assertion) if(tink.core.Outcome.OutcomeTools.isSuccess(assertion.holds)):
        count++;
        tink.core.Future.NOISE;
      case CaseFinish(_):
        println(formatter.success(indent('+ $count assertion(s) passed', 4)));
        super.report(v);
      case _: super.report(v);
    }
  }
}