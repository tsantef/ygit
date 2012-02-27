module FieldHelper

  def field(form, field_name, content, options = {})
    label = options[:label] || field_name.to_s.gsub(/\_/, " ").capitalize
    help  = options[:help] ? %{<p class="help-block">#{options[:help]}</p>} : ""
    message = options[:error] || options[:warning] ? %{<p class="help-inline">#{options[:error]||options[:warning]}</p>} : ""
    classes = ["control-group"]
    classes << "error" if options[:error]
    classes << "warning" if options[:warning] 

    html = <<-HTML
      <div class="#{classes.join(' ')}">
        #{form.label(field_name, label, :class => "control-label")}
        <div class="controls">
          #{content}
          #{message}
          #{help}
        </div>
      </div>
    HTML
    html.html_safe
  end
  
  def field_checkbox(form, field_name, options = {})
    field(form, field_name, form.check_box(field_name, :class => options[:class]), options)
  end

  def field_text(form, field_name, options = {})
    field(form, field_name, form.text_field(field_name, :class => options[:class]), options)
  end
  
  def field_text_area(form, field_name, options = {})
    field(form, field_name, form.text_area(field_name, :rows => options[:rows], :class => "input-xlarge"), options)
  end

end