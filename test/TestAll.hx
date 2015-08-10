import utest.Runner;
import utest.ui.Report;

class TestAll {
  public static function main() {
    var runner = new Runner();
    runner.addCase(new rdg.TestGenerators());
    runner.addCase(new rdg.TestGen());
    runner.addCase(new rdg.util.TestArrays());

    var report = Report.create(runner);
    runner.run();
  }
}
