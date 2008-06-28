$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Brain
end

module Brain::Extensions
end

Brain.send :include, Brain::Extensions