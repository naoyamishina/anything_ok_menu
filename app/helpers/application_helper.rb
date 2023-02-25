module ApplicationHelper
  # ページネーション
  def page_title(page_title = '', admin = false)
    base_title = if admin
      'なんでもいい飯メニュー(管理画面)'
    else
      'なんでもいい飯メニュー'
    end

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

  # 食事のタイミングで色を変える
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

  # ボタンの表示、非表示
  def display_unless(*names)
    'd-none' if active_menu?(*names)
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
end
