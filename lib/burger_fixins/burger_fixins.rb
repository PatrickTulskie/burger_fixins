module BurgerFixins
  
  def self.included(a_module)
    a_module.module_eval do
      extend ClassMethods
    end
  end
  
  module ClassMethods
    def redis_instance(r = nil)
      if r
        @@redis_instance = r
      else
        defined?(@@redis_instance) ? @@redis_instance : Redis.current
      end
    end

    def settings_store
      Redis::Namespace.new(self.to_s, :redis => redis_instance)
    end

    def setting(setting_name, options = { })
      @@default_values ||= { }
      case options[:type]
      when :string
        initial = options[:initial] || ""
        create_burger_fixins_string(setting_name, initial)
      when :integer
        initial = options[:initial] || 0
        create_burger_fixins_integer(setting_name, initial)
      when :array
        initial = options[:initial] || []
        create_burger_fixins_array(setting_name, initial)
      when :hash
        initial = options[:initial] || { }
        create_burger_fixins_hash(setting_name, initial)
      when :boolean
        initial = options[:initial] || false
        create_burger_fixins_boolean(setting_name, initial)
      else
        initial = options[:initial] || nil
        create_burger_fixins_value(setting_name, initial)
      end
    end
    
    private
    
    def create_burger_fixins_string(setting_name, default_value)
      # initialize_fixins_value(setting_name, default_value) do
      #   settings_store[setting_name.to_s].
      # end
      module_eval <<-STR
        def self.#{setting_name}; settings_store['#{setting_name.to_s}'] ; end
        def self.#{setting_name}=(v); settings_store['#{setting_name.to_s}'] = v ; end
      STR
    end
    
    def create_burger_fixins_integer(setting_name, default_value)
      if settings_store[setting_name.to_s].nil?
        settings_store[setting_name.to_s] = default_value
        puts "Setting OK #{setting_name}: #{settings_store[setting_name]}"
      else
        puts "Setting #{setting_name}: #{settings_store[setting_name]}"
      end
      module_eval <<-STR
        def self.#{setting_name}; settings_store['#{setting_name.to_s}'].to_i ; end
        def self.#{setting_name}=(v); settings_store['#{setting_name.to_s}'] = v.to_i ; end
      STR
    end
    
    # TODO Consider moving this over to Redis::List
    def create_burger_fixins_array(setting_name, default_value)
      if settings_store[setting_name].nil?
        settings_store[setting_name] = default_value
      end
      module_eval <<-STR
        def self.#{setting_name}; Redis::Value.new('#{setting_name}', settings_store, :marshal => true).value ; end
        def self.#{setting_name}=(v); Redis::Value.new('#{setting_name}', settings_store, :marshal => true).value = v ; end
      STR
    end
    
    # TODO Consider moving this over to Redis::HashKey
    def create_burger_fixins_hash(setting_name, default_value)
      module_eval <<-STR
        def self.#{setting_name}; Redis::Value.new('#{setting_name}', settings_store, :marshal => true).value ; end
        def self.#{setting_name}=(v); Redis::Value.new('#{setting_name}', settings_store, :marshal => true).value = v ; end
      STR
    end
    
    def create_burger_fixins_boolean(setting_name, default_value)
      module_eval <<-STR
        def self.#{setting_name}; Redis::Value.new('#{setting_name}', settings_store).value ; end
        def self.#{setting_name}=(v); Redis::Value.new('#{setting_name}', settings_store).value = v ; end
        def self.#{setting_name}?; !!settings_store['#{setting_name.to_s}'] ; end
      STR
    end
    
    def create_burger_fixins_value(setting_name, default_value)
      module_eval <<-STR
        def self.#{setting_name}; Redis::Value.new('#{setting_name}', settings_store, :marshal => true).value ; end
        def self.#{setting_name}=(v); Redis::Value.new('#{setting_name}', settings_store, :marshal => true).value = v ; end
      STR
    end
    
    def initialize_fixins_value(setting_name, default_value)
      if settings_store[setting_name.to_s].nil?
        yield
      end
    end
    
  end
  
end