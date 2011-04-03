module Workflow
  module Rules
    class Builder
      # -----------------------------------------------------------------------
      def initialize
        @checker = Workflow::Rules::Checker.instance
      end

      # TODO - make this settable from the client code.
      actions = [
        :stop, 
        :play, 
        :pause, 
        :show
      ]
      
      actions.each do |action|
        define_method action do |model, *args|
          create_rule(action, model, *args)
        end
      end

      private # ------
      
      # -----------------------------------------------------------------------
      def create_rule(action, model, options={})
        @checker.rules[model] ||= {}
        @checker.rules[model][action] = Workflow::Rule.new(options)
      end
    end
  end
end
