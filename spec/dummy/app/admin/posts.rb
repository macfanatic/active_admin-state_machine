ActiveAdmin.register Post do
  belongs_to :category
  
  state_action :peer_review
  state_action :publish, confirm: true  # Has I18n in locale
  state_action :archive, confirm: ->{ "Do you want to archive?" }

  # No I18n for confirm message
  state_action :reopen, confirm: true do
    redirect_to admin_dashboard_path
  end

  form do |f|
    f.inputs "Post Details" do
      f.input :title
      f.input :body
    end
    f.actions
  end

end
