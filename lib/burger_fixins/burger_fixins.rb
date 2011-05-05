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

    def setting(setting_name, setting_type = :value)
      case setting_type
      when :string
        create_burger_fixins_string(setting_name)
      when :integer
        create_burger_fixins_integer(setting_name)
      when :array
        create_burger_fixins_array(setting_name)
      when :hash
        create_burger_fixins_hash(setting_name)
      when :boolean
        create_burger_fixins_boolean(setting_name)
      else
        create_burger_fixins_value(setting_name)
      end
    end
    
    private
    
    def create_burger_fixins_string(setting_name)
      module_eval <<-STR
        def self.#{setting_name}; settings_store['#{setting_name.to_s}'] ; end
        def self.#{setting_name}=(v); settings_store['#{setting_name.to_s}'] = v ; end
      STR
    end
    
    def create_burger_fixins_integer(setting_name)
      module_eval <<-STR
        def self.#{setting_name}; settings_store['#{setting_name.to_s}'].to_i ; end
        def self.#{setting_name}=(v); settings_store['#{setting_name.to_s}'] = v.to_i ; end
      STR
    end
    
    # TODO Consider moving this over to Redis::List
    def create_burger_fixins_array(setting_name)
      module_eval <<-STR
        def self.#{setting_name}; Redis::Value.new('#{setting_name}', settings_store, :marshal => true).value ; end
        def self.#{setting_name}=(v); Redis::Value.new('#{setting_name}', settings_store, :marshal => true).value = v ; end
      STR
    end
    
    # TODO Consider moving this over to Redis::HashKey
    def create_burger_fixins_hash(setting_name)
      module_eval <<-STR
        def self.#{setting_name}; Redis::Value.new('#{setting_name}', settings_store, :marshal => true).value ; end
        def self.#{setting_name}=(v); Redis::Value.new('#{setting_name}', settings_store, :marshal => true).value = v ; end
      STR
    end
    
    def create_burger_fixins_boolean(setting_name)
      module_eval <<-STR
        def self.#{setting_name}; Redis::Value.new('#{setting_name}', settings_store).value == "true" ; end
        def self.#{setting_name}=(v); settings_store['#{setting_name.to_s}'] = v.to_s ; end
        def self.#{setting_name}?; Redis::Value.new('#{setting_name}', settings_store).value == "true" ; end
      STR
    end
    
    def create_burger_fixins_value(setting_name)
      module_eval <<-STR
        def self.#{setting_name}; Redis::Value.new('#{setting_name}', settings_store, :marshal => true).value ; end
        def self.#{setting_name}=(v); Redis::Value.new('#{setting_name}', settings_store, :marshal => true).value = v ; end
      STR
    end
  end
  
end