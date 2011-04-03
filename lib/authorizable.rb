module Sombrero
  module Authorizable
    # Workflow action pre-conditions
    #----------------------------------------------------------------------------
    def authorized_for?(params)
      Workflow::Rules::Checker.instance.authorized_for?(self, params[:action])
    end
  end
end
