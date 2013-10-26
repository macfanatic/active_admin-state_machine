def post_should_have_status(status)
  within ".attributes_table" do
    page.should have_content(status)
  end
end

def login_and_navigate_to_post(user, post)
  login_as user
  visit admin_category_post_path(post.category, post)
end

def has_action_item(item)
  within ".action_items" do
    page.should have_link(item)
  end
end

def has_no_action_item(item)
  within ".action_items" do
    page.should_not have_link(item)
  end  
end
