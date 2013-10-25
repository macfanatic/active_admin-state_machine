ActiveAdmin.register Post do
  belongs_to :category
  
  state_action :peer_review
  state_action :publish, confirm: true  # Has I18n in locale
  state_action :archive, confirm: ->{ "Do you want to archive?" }
  state_action :reopen, confirm: true   # No I18n

  form do |f|
    f.inputs "Post Details" do
      f.input :title
      f.input :body
    end
    f.actions
  end

end
