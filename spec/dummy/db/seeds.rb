AdminUser.create!(email: 'admin@example.com', password: 'password') unless AdminUser.exists?(email: 'admin@example.com')
AdminUser.create!(email: 'super@example.com', password: 'password', super_admin: true) unless AdminUser.exists?(email: 'super@example.com')
