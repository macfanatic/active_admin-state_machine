ActiveAdmin.register Post do
  belongs_to :category

  permit_params :id, :title, :body

  state_action :peer_review
  state_action :publish, confirm: true  # Has I18n in locale
  state_action :archive, confirm: ->{ "Do you want to archive?" }

  # No I18n for confirm message
  state_action :reopen, confirm: true, http_verb: :get do
    redirect_to admin_dashboard_path
  end

  form do |f|
    f.inputs "Post Details" do
      f.input :title
      f.input :body
    end
    f.actions
  end

  before_create do |resource|
    resource.status = :draft
  end

end
