class FakeloginController < ApplicationController
  
  def login
    cookies[:fakelogin] = 'FakeUser'
    redirect_to :controller => 'shop', :action => 'index'
  end
  
  def logout
    cookies[:fakelogin] = nil
    redirect_to :controller => 'shop', :action => 'index'
  end
  
end