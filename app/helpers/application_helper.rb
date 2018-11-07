module ApplicationHelper



  # Returns full_title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Ruby on Rails Tutorial Ostap Pazyniuk App"
    
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
    
  end
  
end
