## Master branch

## Version 0.7.0 (Jul 23, 2013)

* kill all children in tests [Michael Grosser]
* Fix the case where file_name is nil [Tyson Tate]
* Short aliases for serve and push [Kir Shatrov]
* Trailing params for Rspec as well [Marek Rosa]
* Prevent multiple test processes from running [Todd Mazierski]
* Debug via puts replaced with Logger [Todd Mazierski]
* 2 layers of SIGINT handling to Spin server [Todd Mazierski]

## Version 0.6.0 (Feb 13, 2013)

* add -v flag to spin and kick off integration testing [Michael Grosser]
* Options refactoring, namespaces and more tests [Michael Grosser]
* Do not create multidimensional ARGVs [☈king]

## Version 0.5.2 (Jul 26, 2012)

* Don't preload rspec/rails [Jonathan del Strother]

## Version 0.5.1 (Jul 26, 2012)

* Do not fail with missing root or missing .spin [Michael Grosser]

## Version 0.5.0 (Jul 24, 2012)

* Allow spin to run from a subdirectory of the project. [Dylan Thacker-Smith]
* Delete the socket file when spin serve exits. [Dylan Thacker-Smith]
* Adds ability to specify a line number for the RSpec. [Dmitry Koprov]
* Add --preload FILE option to preload whatever people want [Michael Grosser]
* Hooks [Michael Grosser]
* Make connection tty so we preserve colors [Michael Grosser]

## Version 0.4.5 (Mar 14, 2012)

* Fix issues with nil values from v0.4.4 release

## Version 0.4.4 (Mar 14, 2012)

* Refactor spin-push to support kicker-2.5.0 [Vivek Khokhar]

## Version 0.4.3 (Feb 4, 2012)

* Fixes colored output for Rspec users [Brian Helmkamp]

## Version 0.4.2 (Dec 14, 2011)

* Fixes "undefined local variable or method 'conn'" bug [Ben Brinckerhoff

## Version 0.4.1 (Dec 13, 2011)

* Restores compat with kicker

## Version 0.4.0 (Dec. 12, 2011) (yanked)

* Now supports line numbers for RSpec users. [Marek Prihoda]
  spin push spec/models/user_spec.rb:25

## Version 0.3.0 (Dec. 4, 2011)

* Stream results back to the client when using --push-results [Ben Brinckerhoff]

## Version 0.2.1 (Nov. 27, 2011)

* RSpec is now preloaded for RSpec users. Shaves up to a few seconds off of each test run. [Marek Prihoda]

## Version 0.2.0 (Nov. 19, 2011)

* Added a -p (--push-results) flag that displays results in the push process.
* Added --test-unit option to force test framwork to Test::Unit.
* Ensure that we don't spin up duplicate files.

## Version 0.1.5 (Nov. 15, 2011)

* Add --time flag to see total execution time. [Mark Mulder]
* Doesn't spin up anything if push received no valid files. (Fixes #13)

## Version 0.1.4 (Nov 2, 2011)

* Adds a -e option stub to keep kicker happy.

## Version 0.1.3 (Nov 2, 2011)

* Adds --rspec option to force test framework to rspec.
* Adds a -I option to append directories to LOAD_PATH.
* Allows multiple files to be pushed at the same time.

## Version 0.1.2 (Nov 1, 2011)

* Ensure that the paths generated for the socket file are valid on Ubuntu.
