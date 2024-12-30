# frozen_string_literal: true
namespace :admin do
  desc "Add admin user"
  task add_user: :environment do
    email = ENV['ADMIN_EMAIL']
    password = ENV['ADMIN_PASSWORD']

    AdminUser.find_or_create_by(email: email) do |user|
      user.password = password
      user.password_confirmation = password
    end
  end
end
