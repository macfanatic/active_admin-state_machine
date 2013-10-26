require 'spec_helper'

feature "Custom Block" do

  given(:admin) { create(:user, super_admin: true) }

  given(:category) { create(:category, num_posts: 0) }
  given(:post) { create(:post, :reviewed, category: category) }

  scenario 'uses block for controller action if provided' do
    login_and_navigate_to_post admin, post

    click_link "Reopen"

    current_path.should == admin_dashboard_path
    post.should be_reviewed
  end
end
