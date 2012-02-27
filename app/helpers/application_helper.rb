module ApplicationHelper

  FLASH_NOTICE_KEYS = [:info, :error, :notice, :warning]
  
  def flash_messages
    return unless messages = flash.keys.select{|k| FLASH_NOTICE_KEYS.include?(k)}
    formatted_messages = messages.map do |type|
      html = <<-HTML
        <div class="alert alert-#{type.to_s}">
          <a class="close" data-dismiss="alert">×</a>
          #{message_for_item(flash[type], flash["#{type}_item".to_sym])}
        </div>
      HTML
    end
    formatted_messages.join
  end

  def message_for_item(message, item = nil)
    if item.is_a?(Array)
      message % link_to(*item)
    else
      message % item
    end
  end
  
  def breadcrumbs
    @breadcrumbs ||= []
     
    crumbs ||= []
    
    @breadcrumbs.each do |crumb|
      crumbs << link_to_unless(crumb[:url].blank?, h(crumb[:name]), crumb[:url])
    end
       
    crumbs.join(" &raquo; ")
  end
  
end
