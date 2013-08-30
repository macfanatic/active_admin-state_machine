# ActiveAdmin-StateMachine

This gem provides an easy integration between the awesome [state_machine](https://github.com/pluginaweek/state_machine) and [active_admin](https://github.com/gregbell/active_admin) gems.

## Features

This gem provides you with a DSL extension to ActiveAdmin that allows you to easily define action item buttons for your resource to transition through your state_machine.

* Integration with ActiveAdmin authorization adapater layer - the button won't show if the user isn't authorized
* Provide custom permission to authorize against
* Provide confirmation message to prompt user before performing
* Button only shown if state_machine can transition
* Localizable button titles and flash messages
* Pass a block to customize the behavior

## Installation

This gem requires both `active_admin` and `state_machine`.  Add the gem to your Gemfile to get started and bundle.

```ruby
gem 'active_admin-state-machine'
```

## Usage

You will need to define a state_machine in a model, and have that model registered as a resource with ActiveAdmin.

**A basic model**

```
# app/models/post.rb
class Post < ActiveRecord::Base
  attr_accessible :body, :status, :title

  validates :title, presence: true, uniqueness: true
  validates :body, presence: true

  DRAFT = 'draft'
  REVIEWED = 'reviewed'
  PUBLISHED = 'published'

  state_machine :status, initial: DRAFT do
    event :peer_review do
      transition DRAFT => REVIEWED
    end

    event :publish do
      transition REVIEWED => PUBLISHED
    end
  end
end
```

**Corresponding ActiveAdmin resource**

```
ActiveAdmin.register Post do
  
  state_action :peer_review
  state_action :publish

  form do |f|
    f.inputs "Post Details" do
      f.input :title
      f.input :body
    end
    f.actions
  end

end
```

In the above example, the `state_action` method is defined by this gem and provides you with the following functionality:

1. The `:peer_review` is assumed to be an event in your state_machine definition on the Post model.
2. Calling `state_action` will add an action item button to your ActiveAdmin resource on the `#show` page, if the user is authorized to perform this action via the ActiveAdmin authorization adapter, and if the resource itself returns true to `#can_peer_review?`, which is provided by default with this event in state_machine.
3. Clicking the button will call `#peer_review!` on the resource, and redirect you back to `smart_resource_url`.
4. Fully localizable, provide translations for `"posts.peer_review.label"`for the button title and `"posts.peer_review.flash.success` for the flash message when completed.
5. You can pass a block to customize this behavior.

### Custom Block

```
ActiveAdmin.register Post do
  
  state_action :peer_review
  
  # Block to be called when submitted
  state_action :publish do
    PostPublicationService.publish!(resource)
    flash[:notice] = "Post published"
    redirect_to collection_path
  end

end
```

### Custom Permission

```
ActiveAdmin.register Post do

  # by default, permission would be :peer_review
  state_action :peer_review, permission: :read
end
```

### Confirmation

```
ActiveAdmin.register Post do

  # Lookup 'posts.peer_review.prompt'
  state_action :peer_review, confirm: :true
  
  # Pass proc
  state_action :peer_review, confirm: ->{ I18n.t("posts.peer_review.confirm") }
end
```

### Using without state_machine model

If you really want to use without a state_machine on your model, you essentially just need to provide the following methods, contining with our `:peer_review` example:

```
class Post < ActiveRecord::Base    
  def can_peer_review?
    author.present? && !published?
  end
  
  def peer_review!
    self.published_at = Time.now
    save!
  end
end
```
