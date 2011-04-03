require "rule"
require "rules_builder"
require "rules_checker"
require "authorizable"

ActiveRecord::Base.send(:extend, Sombrero::Authorizable)
