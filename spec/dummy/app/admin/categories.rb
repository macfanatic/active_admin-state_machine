ActiveAdmin.register Category do
  action_item 'state_action_category', only: :show do
    link_to "Posts", admin_category_posts_path(resource)
  end
end
