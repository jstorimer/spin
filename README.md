# Spin

![superman band aid logo]

A super band-aid for autotesting large Rails apps. If your Rails takes 10+ seconds just to boot, then you want this for testing.

## Tell me more

Spin is a solution for testing big Rails apps. The trick is that it loads the parts of your app that don't change between test runs (gem dependencies and Rails framework code) into a long-running parent process. When you tell spin to run a test for you it forks a process from the parent and loads your test there. This avoids the overhead of loading your environment on every single test run.

## Real world example:

## Why do you call it a band-aid?

Spin treats a symptom, not a root cause. If your Rails app takes 10+ seconds to boot and each of your tests must load that entire environment to run then spin can't fix the root cause. The root issue is that your application logic and tests are coupled to the Rails framework. [People](destroyallsoftware) in the [community](coreyhaines) have been educating others and advocating that we decouple our application logic from the framework we use and write blazing fast tests that don't depend on the entire environment.

The sad reality is that a lot of us work on legacy apps where this isn't the case and, for whatever reason, will never be the case. For us, spin makes life easier.

## Motivation

[snippet from prev readme]

## Isn't this a lot like spork?

Yes, with a few key differences.

1. **Unobtrusive**. Spork requires you to modify your `test_helper` in order to facilitate its loading process, which requires that you add spork to your Gemfile and that other developers on your team be aware of it and how to use it. Spin offers the same flexibility without requiring any modifications to your project, instead it relies on Ruby's require system. Also, you could use spin without having to bother any of your coworkers.
2. Test agnostic. Spork seems to favour rspec/cucumber (true?). Spin doesn't care what you use.
3. No monkey pathces. Spork has [crazy monkey patches](link) to Rails. They may be there for good reason but I don't plan on ever adding them to spin.

## Basic Usage

Install it with 

``` console
$ gem i spin
```

Use it from the root of a Rails project with

``` console
$ spin
```

That's it. Faster tests :)

See all the options with

``` console
$ spin -h
$ spin --help

## Usage with Text Editors

The basic usage doesn't really work if you want to run the tests from inside vim, textmate, or whatever. There's an alternate workflow for that.

Start spin in a terminal outside of your editor

``` console
$ spin
```

Then use `spin push` to queue up test runs on the main instance

``` console
$ spin push -w test/unit/product_test.rb
```

The `-w` option tells `spin push` to wait for the results and display them. If you omit that option then the test results will show up in the output from the main instance.

## License

MIT.

## Contributing

Yes please. There are few tests, keep them passing. I take pull requests. An accepted patch gets you commit access to the project, ping me if I forget.

