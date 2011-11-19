module ApplicationHelper
  def meta_tags(type)
    "<meta name='#{type}' content='#{t("page_headings.meta.#{type}")}'/>".html_safe unless type.nil?
  end
  
  def render_meta_title(meta_title = nil)
    title = ""
    if meta_title.blank?
      title = "Welcome to Everest"
    else
      title = meta_title
    end
    content_tag(:title, title)
  end
end
