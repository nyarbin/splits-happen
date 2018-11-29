Ben Reis
908 967 4677
benjamin.e.reis@gmail.com

Written in D because I initially misread the scoring rules to be more complex than they actually
are, which would have made a static typing system and simple structs very useful, and because
testing and debugging is much more straightforward in D than in python, the language I would usually
turn to for a simple calculator-type program. While I was able to write a relatively
simple single-pass algorithm, I ultimately stuck with D because of the simplicity of testing.

The four tests specified in README.md have been set up to run on D's built-in unit testing feature;
unit testing and related code would not compile for a production build. With a more complicated
codebase the production build would also need to be tested; I have previously discovered bugs in the
production/optimized builds of standard D libraries that are not present in test builds. This
particular program doesn't use anything that could plausibly have such a bug, though, so it's less
necessary in this case. Note that the debug/testing version produces a great deal more text than
the production version, and does not need any input to run the tests.

To compile with unittests, coverage analysis (on input only) and debug printing::

   dmd -cov -unittest bowling.d

To compile without tests::

   dmd bowling.d

Run as::

   ./bowling LINE


Tested with 64-bit dmd compiler (v2.083.0) on linux.
