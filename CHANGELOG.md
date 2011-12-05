## Versino 0.3.0 (Dec. 4, 2011)

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
