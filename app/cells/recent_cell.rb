class RecentCell < Cell::Rails
  cache :show, :expires_in => 10.minutes

  def show(args)
    @recent = OrderItem.order('updated_at DESC').limit(args[:limit])
    render
  end

end
