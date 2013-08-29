ActiveAdmin.register Post do
  belongs_to :category
  
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
