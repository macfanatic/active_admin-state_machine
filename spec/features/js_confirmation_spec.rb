require 'spec_helper'

feature "JS Confirmations" do

  given(:admin) { create(:user, super_admin: true) }

  given(:category) { create(:category, num_posts: 0) }
  given(:post) { create(:post, :reviewed, category: category) }

  scenario 'accepting JS confirmation performs action', js: true do
    login_and_navigate_to_post admin, post

    page.driver.browser.accept_js_confirms
    click_link "Publish Post"

    page.driver.confirm_messages.should include "Do you want to publish now?"
    page.should have_css(".flash.flash_notice", text: "Post successfully published")

    post_should_have_status "published"
  end

  scenario 'rejecting JS confirmatino skips action', js: true do
    login_and_navigate_to_post admin, post

    page.driver.browser.reject_js_confirms
    click_link "Publish Post"

    page.driver.confirm_messages.should include "Do you want to publish now?"
    page.should_not have_css(".flash.flash_notice", text: "Post successfully published")

    post_should_have_status "reviewed"
  end

  scenario 'JS prompt has default transation', js: true do
    login_and_navigate_to_post admin, post

    page.driver.browser.accept_js_confirms
    click_link "Reopen"

    page.driver.confirm_messages.should include "Are you sure you want to reopen?"
  end

  scenario 'JS prompt uses Proc for message', js: true do
    login_and_navigate_to_post admin, post

    page.driver.browser.accept_js_confirms
    click_link "Archive"

    page.driver.confirm_messages.should include "Do you want to archive?"
  end
end
