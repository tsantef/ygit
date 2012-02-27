module MetaHelper
  
  def title(page_title)
    if page_title.class == Array then
      return @title ? @title + " - " + page_title[0] : page_title[0]
    else
      @title = page_title
    end   
  end
  
  def description(desc = nil)
    if desc == nil then
      return @description ? "<meta name=\"description\" content=\"#{@description}\" />".html_safe : ""
    else
      @description = desc
    end   
  end
  
  def canonical(page_url = nil)
    if page_url == nil then
      return @canonical ? "<link rel=\"canonical\" href=\"#{URI.escape(@canonical)}\" />".html_safe : ""
    else
      @canonical = page_url
    end   
  end

  def author(page_url = nil)
    if page_url == nil then
      return @author ? "<meta name=\"author\" content=\"#{@author}\" />".html_safe : ""
    else
      @author = page_url
    end   
  end

  def cdn_js(cdn_url, condition, local_url)
    html = <<-HTML
      <script src="#{cdn_url}"></script>
      <script>#{condition} || document.write("\\x3Cscript src='#{local_url}'>\\x3C/script>");</script>
    HTML
    html.html_safe
  end
  
  def body_id(b_id = nil)
    if b_id == nil then
      return @body_id ? @body_id : controller.controller_name.underscore + "-" + controller.action_name.to_url
    else
      @body_id = b_id
    end   
  end
    
  def body_class(b_class = nil)
    if b_class == nil then
      return @body_class ? @body_class : controller.controller_name.underscore + "-page"
    else
      @body_class = b_class
    end   
  end
  
  def bulk_action(title, path, confirm=nil)
    if confirm
      link_to_function title, "if (confirm('#{confirm}')) $(this).parents('form').attr('action', '#{path}').attr('method','post').submit()"    
    else
      link_to_function title, "$(this).parents('form').attr('action', '#{path}').attr('method','post').submit()"    
    end
  end

  def gavatar(email, size = 32, username = nil)
    image_tag "http://www.gravatar.com/avatar/#{Digest::MD5::hexdigest(email)}?s=#{size}&d=identicon&r=PG", :alt => "Image of #{username}"
  end
  
  def analytics(account)     
    if !account.blank?
      s = %{
  <script type="text/javascript">
    var _gaq = _gaq || [];
    _gaq.push(['_setAccount', '#{account}']);
    _gaq.push(['_trackPageview']);
    
    (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
    })();
  </script> 
      }.html_safe
    end
  end
  
end