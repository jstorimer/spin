
describe "Spin" do
  around do |example|
    folder = File.expand_path("../tmp", __FILE__)
    `rm -rf #{folder}`
    ensure_folder folder
    Dir.chdir folder do
      example.call
    end
    `rm -rf #{folder}`
  end

  after do
    kill_all_threads
    kill_all_children
  end

  context "with simple setup" do
    before do
      write "config/application.rb", "$xxx = 1234"
      write "test/foo_test.rb", "puts $xxx * 2"
      @log_label = "[Spin]"
      @default_pushed = "#{@log_label} Spinning up test/foo_test.rb\n"
      @preloaded_message = "Preloaded Rails environment in "
    end

    it "shows help when no arguments are given" do
      spin("", :fail => true).should include("General Options:")
    end

    it "can serve and push" do
      served, pushed = serve_and_push("", "test/foo_test.rb")
      served.should include @preloaded_message
      served.should include "2468"
      pushed.first.should == @default_pushed
    end

    it "can run files without .rb extension" do
      served, pushed = serve_and_push("", "test/foo_test")
      served.should include @preloaded_message
      served.should include "2468"
      pushed.first.should == @default_pushed
    end

    it "can run multiple times" do
      write "test/foo_test.rb", "puts $xxx *= 2"
      served, pushed = serve_and_push("", ["test/foo_test.rb", "test/foo_test.rb", "test/foo_test.rb"])
      served.should include @preloaded_message
      served.scan("2468").size.should == 3
      pushed.size.should == 3
      pushed.each{|x| x.should == @default_pushed }
    end

    it "can run multiple files at once" do
      write "test/bar_test.rb", "puts $xxx / 2"
      served, pushed = serve_and_push("", "test/foo_test.rb test/bar_test.rb")
      served.should include @preloaded_message
      served.should include "2468"
      served.should include "617"
      pushed.first.should == "#{@log_label} Spinning up test/foo_test.rb test/bar_test.rb\n"
    end

    it "complains when the preloaded file cannot be found" do
      delete "config/application.rb"
      write "test/foo_test.rb", "puts 2468"
      served, pushed = serve_and_push("", "test/foo_test.rb")
      served.should_not include @preloaded_message
      served.should include "Could not find config/application.rb. Are you running"
      served.should include "2468"
      pushed.first.should == @default_pushed
    end

    context "RSpec" do
      before do
        write "config/application.rb", "module RSpec;end"
      end

      it "can run files" do
        write "spec/foo_spec.rb", "RSpec.configure{}; puts 'YES'"
        served, pushed = serve_and_push("", "spec/foo_spec.rb")
        served.should include "YES"
      end

      it "can run by line" do
        write "spec/foo_spec.rb", <<-RUBY
          describe "x" do
            it("a"){ puts "AAA" }
            it("b"){ puts "BBB" }
            it("c"){ puts "CCC" }
          end
        RUBY
        served, pushed = serve_and_push("", "spec/foo_spec.rb:3")
        served.should_not include "AAA"
        served.should include "BBB"
        served.should_not include "CCC"
      end

      it "can pass trailing arguments to the spec runner" do
        write "spec/foo_spec.rb", <<-RUBY
          describe "x" do
            it("a"){ puts "AAA" }
            it("b"){ puts "BBB" }
            it("c"){ puts "CCC" }
          end
        RUBY
        served, pushed = serve_and_push("", ["spec/foo_spec.rb -- --profile"])
        served.should include 'Will run with: ["--profile"]'
        served.should include 'Top 3 slowest examples'
      end
    end

    context "options" do
      it "can show current version" do
        spin("--version").should =~ /^\d+\.\d+\.\d+/
      end

      it "can show help" do
        spin("--help").should include("General Options:")
      end

      it "can --push-results" do
        served, pushed = serve_and_push("--push-results", "test/foo_test.rb")
        served.should include @preloaded_message
        served.should_not include "2468"
        pushed.first.should include "2468"
      end

      it "can --preload a different file" do
        write "config/application.rb", "raise"
        write "config/environment.rb", "$xxx = 1234"
        served, pushed = serve_and_push("--preload config/environment.rb", "test/foo_test.rb")
        served.should include @preloaded_message
        served.should include "2468"
        pushed.first.should == @default_pushed
      end

      it "can add load paths via -I" do
        write "lib/bar.rb", "puts 'bar'"
        write "test/foo_test.rb", "require 'bar'"
        served, pushed = serve_and_push("-Itest:lib", "test/foo_test.rb")
        served.should include "bar"
        pushed.first.should == @default_pushed
      end

      it "ignores -e" do
        served, pushed = serve_and_push("-e", "test/foo_test.rb -e")
        served.should include @preloaded_message
        served.should include "2468"
        pushed.first.should == @default_pushed
      end

      # TODO process never reaches after the fork block with only 1 push command
      it "can show total execution time" do
        served, pushed = serve_and_push("--time", ["test/foo_test.rb", "test/foo_test.rb"])
        served.should include "Total execution time was 0."
        pushed.first.should == @default_pushed
      end

      it "can pass trailing arguments to the test runner" do
        served, pushed = serve_and_push("", ["test/foo_test.rb -- -n /validates/"])
        served.should include 'Will run with: ["-n", "/validates/"]'
        pushed.first.should == @default_pushed
      end
    end

    context "hooks" do
      before do
        write "config/application.rb", "$calls << :real_preload"
        write "test/calls_test.rb", "puts '>>' + $calls.inspect + '<<'"
      end

      it "calls preload hooks in correct order" do
        write ".spin.rb", <<-RUBY
          $calls = []
          [:before_preload, :after_preload].each do |hook|
            Spin.hook(hook) { $calls << hook }
          end
        RUBY
        served, pushed = serve_and_push("--time", "test/calls_test.rb")
        served[/>>.*<</].should == ">>[:before_preload, :real_preload, :after_preload]<<"
      end

      it "can have multiple hooks" do
        write ".spin.rb", <<-RUBY
          $calls = []
          Spin.hook(:before_preload) { $calls << :before_preload_1 }
          Spin.hook(:before_preload) { $calls << :before_preload_2 }
        RUBY
        served, pushed = serve_and_push("--time", "test/calls_test.rb")
        served[/>>.*<</].should == ">>[:before_preload_1, :before_preload_2, :real_preload]<<"
      end

      it "can hook before/after fork" do
        write ".spin.rb", <<-RUBY
          $calls = []
          [:before_fork, :after_fork].each do |hook|
            Spin.hook(hook) { $calls << hook }
          end
        RUBY
        served, pushed = serve_and_push("--time", "test/calls_test.rb")
        served[/>>.*<</].should == ">>[:real_preload, :before_fork, :after_fork]<<"
      end
    end
  end

  private

  def root
    File.expand_path '../..', __FILE__
  end

  def spin(command, options={})
    command = spin_command(command)
    result = `#{command}`
    raise "FAILED #{command}\n#{result}" if $?.success? == !!options[:fail]
    result
  end

  def spin_command(command)
    "ruby -I #{root}/lib #{root}/bin/spin #{command} 2>&1"
  end

  def record_serve(output, command)
    IO.popen(spin_command("serve #{command}")) do |pipe|
      while str = pipe.readpartial(100)
        output << str
      end rescue EOFError
    end
  end

  def write(file, content)
    ensure_folder File.dirname(file)
    File.open(file, 'w'){|f| f.write content }
  end

  def read(file)
    File.read file
  end

  def delete(file)
    `rm #{file}`
  end

  def ensure_folder(folder)
    `mkdir -p #{folder}` unless File.exist?(folder)
  end

  def serve_and_push(serve_command, push_commands)
    serve_output = ""
    t1 = Thread.new { record_serve(serve_output, serve_command) }
    sleep 0.1
    push_output = [*push_commands].map{ |cmd| spin("push #{cmd}") }
    sleep 0.2
    t1.kill
    [serve_output, push_output]
  end

  def kill_all_threads
    Thread.list.each { |thread| thread.exit unless thread == Thread.current }
  end

  def kill_all_children
    children = child_pids
    `kill -9 #{children.join(" ")}` unless children.empty?
  end

  def child_pids
    pid = Process.pid
    pipe = IO.popen("ps -ef | grep #{pid}")
    pipe.readlines.map do |line|
      parts = line.split(/\s+/)
      parts[2] if parts[3] == pid.to_s and parts[2] != pipe.pid.to_s
    end.compact
  end
end
