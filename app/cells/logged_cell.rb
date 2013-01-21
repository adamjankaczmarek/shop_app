class LoggedCell < Cell::Rails
  
  
  def show(args)
    @username = args[:user]
    if @username == nil || @username == ''
      render :view => :notlogged
    else
      render  
    end
  end

end
