AdminUser.create!(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password') unless AdminUser.exists?(email: 'admin@example.com')
