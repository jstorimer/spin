module Spin
  module Hooks
    HOOKS = [:before_fork, :after_fork, :before_preload, :after_preload]

    def hook(name, &block)
      raise unless HOOKS.include?(name)
      _hooks(name) << block
    end

    def execute_hook(name)
      raise unless HOOKS.include?(name)
      _hooks(name).each(&:call)
    end

    def parse_hook_file(root)
      file = root.join(".spin.rb")
      load(file) if File.exist?(file)
    end

    private

    def _hooks(name)
      @hooks ||= {}
      @hooks[name] ||= []
      @hooks[name]
    end
  end
end
