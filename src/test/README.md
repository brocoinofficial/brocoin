# Unit tests

The sources in this directory are unit test cases. Boost includes a
unit testing framework, and since Brocoin Core already uses Boost, it makes
sense to simply use this framework rather than require developers to
configure some other framework (we want as few impediments to creating
unit tests as possible).

The build system is set up to compile an executable called `test_brocoin`
that runs all of the unit tests. The main source file is called
`setup_common.cpp`.

### Compiling/running unit tests

Unit tests will be automatically compiled if dependencies were met in `./configure`
and tests weren't explicitly disabled.

After configuring, they can be run with `make check`.

To run the brocoind tests manually, launch `src/test/test_brocoin`. To recompile
after a test file was modified, run `make` and then run the test again. If you
modify a non-test file, use `make -C src/test` to recompile only what's needed
to run the brocoind tests.

To add more brocoind tests, add `BOOST_AUTO_TEST_CASE` functions to the existing
.cpp files in the `test/` directory or add new .cpp files that
implement new `BOOST_AUTO_TEST_SUITE` sections.

To run the brocoin-qt tests manually, launch `src/qt/test/test_brocoin-qt`

To add more brocoin-qt tests, add them to the `src/qt/test/` directory and
the `src/qt/test/test_main.cpp` file.

### Running individual tests

test_brocoin has some built-in command-line arguments; for
example, to run just the getarg_tests verbosely:

    test_brocoin --log_level=all --run_test=getarg_tests

... or to run just the doubledash test:

    test_brocoin --run_test=getarg_tests/doubledash

Run `test_brocoin --help` for the full list.

### Adding test cases

To add a new unit test file to our test suite you need
to add the file to `src/Makefile.test.include`. The pattern is to create
one test file for each class or source file for which you want to create
unit tests. The file naming convention is `<source_filename>_tests.cpp`
and such files should wrap their tests in a test suite
called `<source_filename>_tests`. For an example of this pattern,
see `uint256_tests.cpp`.

### Logging and debugging in unit tests

To write to logs from unit tests you need to use specific message methods
provided by Boost. The simplest is `BOOST_TEST_MESSAGE`.

For debugging you can launch the test_brocoin executable with `gdb`or `lldb` and
start debugging, just like you would with brocoind:

```bash
gdb src/test/test_brocoin
```
