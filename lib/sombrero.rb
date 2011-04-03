require "rule"
require "rules_builder"
require "rules_checker"
require "authorizable"

ActiveRecord::Base.send(:include, Sombrero::Authorizable)
