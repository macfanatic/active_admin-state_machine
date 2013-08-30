module ActiveAdmin
  module StateMachine
    module DSL

      #
      # Easily tie into a state_machine action
      #
      # @param [Symbol] state machine event, ie: :publish
      # @param [Hash] options
      #   - permission [Symbol] permission to check authorization against
      #
      # Will call "resource.publish!", if "resource.can_publish?" returns true
      #

      def state_action(action, options={}, &controller_action)
        singular = config.resource_name.singular
        plural = config.resource_name.plural

        options[:permission] ||= controller.new.send(:action_to_permission, action)
        confirmation = options.fetch(:confirm, false)
        if confirmation == true
          default = "Are you sure you want to #{action.to_s.humanize.downcase}?"
          confirmation = ->{ I18n.t(:confirm, scope: "#{plural}.#{action}", default: default) }
        end
        
        action_item only: :show do
          if resource.send("can_#{action}?") && authorized?(options[:permission], resource)
            path = resource_path << "/#{action}"
            label = I18n.t("#{plural}.#{action}.label", default: action.to_s.titleize)

            link_options = {}
            if confirmation.is_a?(Proc)
              link_options[:data] ||= {}
              link_options[:data][:confirm] = instance_exec(&confirmation)
            end

            link_options[:class] = "btn btn-large"
            link_options[:method] = :put

            link_to label, path, link_options
          end
        end

        unless block_given?
          controller_action = -> do
            resource.send("#{action}!")
            flash[:notice] = t("#{plural}.#{action}.flash.success")
            redirect_to smart_resource_url
          end
        end

        member_action action, method: :put, &controller_action
      end

    end
  end
end
