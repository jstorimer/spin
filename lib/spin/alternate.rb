# A Spin::Rule maps a file to its test file 

module Spin
  module Alternate
    extend self

    attr_reader :map
    @map = {}

    def for(file)
      match = map.find do |k, _|
        k.match(file)
      end

      alternates = match[1]
      matched_source = $1
      alternates.map! { |alt| alt.gsub(/:source:/, matched_source) }
      alternates.keep_if { |alt| File.exist?(alt) }
      alternates
    end

    map[/app\/models\/(\w+).rb/] = ["test/unit/:source:_test.rb", "spec/models/:source:_spec.rb"]
    map[/app\/controllers\/(\w+).rb/] = ["test/functional/:source:_test.rb"]
    map[/app\/views\/(\w+)\/.+/] = ["test/functional/:source:_controller_test.rb"]
  end
end

