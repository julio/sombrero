module Workflow
  class Rule
    # -------------------------------------------------------------------------
    def initialize(options={})
      @if      = conditions(options[:if])
      @unless  = conditions(options[:unless], false)
      @extra   = conditions(options[:and])
    end

    # -------------------------------------------------------------------------
    def match?(entity)
      @if.call(entity) && !@unless.call(entity) && @extra.call(entity)
    end
    
    private # -----
    
    def conditions(conditions, flag = true)
      case
      when conditions.blank?        then lambda { flag }
      when conditions.is_a?(String) then lambda { |e| conditions == e.state }
      when conditions.is_a?(Array)  then lambda { |e| conditions.include?(e.state) }
      when conditions.is_a?(Proc)   then conditions
      else 
        raise "Don't know how to handle an argument: #{conditions.inspect}"
      end
    end
  end
end
