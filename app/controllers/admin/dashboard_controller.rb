class Admin::DashboardController < ApplicationController

  name = ENV['HTTP_AUTH_USERNAME']
  password = ENV['HTTP_AUTH_PASSWORD']
  http_basic_authenticate_with name: name, password: password

  def show
  end
end
