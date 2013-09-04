require 'spec_helper'

feature "Authorized Access" do

  given(:user) { create(:user) }
  given(:admin) { create(:admin_user) }

  given(:category) { create(:category, num_posts: 1) }
  given(:post) { category.posts.first }

  scenario 'should not show button if authorized' do
    login_as user
    visit admin_category_post_path(category, post)
    within(".action_items") do
      page.should_not have_link("Peer Review")
    end
  end

  scenario 'should show button if authorized' do
    login_as admin
    visit admin_category_post_path(category, post)
    within(".action_items") do
      page.should have_link("Peer Review")
    end
  end
  
end
