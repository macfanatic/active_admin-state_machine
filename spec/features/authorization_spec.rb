require 'spec_helper'

feature "Authorized Access" do

  given(:user) { create(:user) }
  given(:admin) { create(:user, super_admin: true) }

  given(:category) { create(:category, num_posts: 1) }
  given(:post) { category.posts.first }

  scenario 'should not show button if not authorized' do
    login_and_navigate_to_post user, post
    
    has_no_action_item "Peer Review"
  end

  scenario 'should show button if authorized' do
    login_and_navigate_to_post admin, post

    has_action_item "Peer Review"
  end
  
end
