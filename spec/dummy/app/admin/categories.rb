ActiveAdmin.register Category do
    action_item_args =  if ActiveAdmin::VERSION.start_with?('0.')
                          [{ only: :show }]
                        else
                          ["state_action_category", { only: :show }]
                        end
    action_item(*action_item_args) do
    link_to "Posts", admin_category_posts_path(resource)
  end
end
