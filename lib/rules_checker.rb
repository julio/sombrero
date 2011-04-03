module Workflow
  module Rules
    class Checker
      include Singleton
    
      # -------------------------------------------------------------------------
      def rules
        @rules ||= {}
      end
    
      # -------------------------------------------------------------------------
      def add_rules(&proc)
        Workflow::Rules::Builder.new.instance_eval(&proc)
      end
    
      # Returns true if "action" is allowed on "model", false otherwise
      # -------------------------------------------------------------------------
      def authorized_for?(model, action)
        model_type = model.class.name.tableize.singularize.to_sym
        rule       = @rules[model_type][action.to_sym]
        rule.match? model
      end
    end
  end
end
