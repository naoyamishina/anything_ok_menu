module ApplicationHelper
  # ページネーション
  def page_title(page_title = '')
    base_title = 'なんでもいい飯メニュー'

    page_title.empty? ? base_title : page_title + ' | ' + base_title
  end

  # アクティブ・非アクティブ化
  def active_if(*names)
    'active' if active_menu?(*names)
  end

  def active_menu?(*names)
    active_namespace?(*names) || active_controller?(*names) || active_action?(*names)
  end

  def active_controller?(*names)
    names.any?(controller_path)
  end

  def active_namespace?(*namespaces)
    namespaces.any? { |namespace| controller_path.start_with?(namespace) }
  end

  def active_action?(*names)
    names.any?("#{controller_path}##{action_name}")
  end

  def eat_at_color_if(object)
    if object == "いつでも"
      'text-secondary'
    elsif object == "朝食"
      'text-success'
    elsif object == "昼食"
      'text-danger'
    elsif object == "夕食"
      'text-primary'
    end
  end
end
