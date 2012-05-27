class PeerModel
  class << self
    attr_reader :properties

    def property(name, options = {})
      @properties ||= []
      @properties << name

      attr_accessor name
    end
  end

  def encodeWithCoder(coder)
    self.class.properties.each do |property|
      value = instance_variable_get("@#{property}".to_sym)
      coder.encodeObject(value, forKey: property.to_s)
    end
  end

  def initWithCoder(coder)
    self.class.properties.each do |property|
      instance_variable_set("@#{property}".to_sym, coder.decodeObjectForKey(property.to_s))
    end

    self
  end
end