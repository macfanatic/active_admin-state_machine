require 'active_admin'
require 'state_machine'

require 'active_admin/state_machine/dsl'

module ActiveAdmin
  module StateMachine
  end
end

ActiveAdmin::DSL.send :include, ActiveAdmin::StateMachine::DSL
