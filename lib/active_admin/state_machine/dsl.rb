module ActiveAdmin
  module StateMachine
    module DSL

      def state_action(method, &block)
        Rails.logger.info("state_machine(#{method})")
      end

    end
  end
end
