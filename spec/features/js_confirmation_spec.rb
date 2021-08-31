require 'spec_helper'

feature "JS Confirmations" do

  given(:admin) { create(:user, super_admin: true) }

  given(:category) { create(:category, num_posts: 0) }
  given(:post) { create(:post, :reviewed, category: category) }

  scenario 'accepting JS confirmation performs action', js: true do
    login_and_navigate_to_post admin, post

    click_link "Publish Post"
    expect(page.driver.browser.switch_to.alert.text).to include('Do you want to publish now?')
    page.driver.browser.switch_to.alert.accept

    expect(page).to have_css(".flash.flash_notice", text: "Post successfully published")

    post_should_have_status "published"
  end

  scenario 'rejecting JS confirmatino skips action', js: true do
    login_and_navigate_to_post admin, post

    click_link "Publish Post"
    expect(page.driver.browser.switch_to.alert.text).to include('Do you want to publish now?')
    page.driver.browser.switch_to.alert.dismiss

    expect(page).to_not have_css(".flash.flash_notice", text: "Post successfully published")

    post_should_have_status "reviewed"
  end

  scenario 'JS prompt has default transation', js: true do
    login_and_navigate_to_post admin, post

    click_link "Reopen"

    expect(page.driver.browser.switch_to.alert.text).to include('Are you sure you want to reopen?')

    page.driver.browser.switch_to.alert.accept
  end

  scenario 'JS prompt uses Proc for message', js: true do
    login_and_navigate_to_post admin, post

    click_link "Archive"

    expect(page.driver.browser.switch_to.alert.text).to include('Do you want to archive?')

    page.driver.browser.switch_to.alert.accept
  end
end
