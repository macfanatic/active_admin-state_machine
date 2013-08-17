require 'active_admin'
require 'state_machine'

require 'active_admin/state_machine/dsl'

ActiveAdmin::DSL.send :include, ActiveAdmin::StateMachine::DSL
