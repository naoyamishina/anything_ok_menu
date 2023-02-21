module ApplicationHelper

  def show_meta_tags
    assign_meta_tags if display_meta_tags.blank?
    display_meta_tags
  end

  def assign_meta_tags(options = {})
    defaults = t('meta_tags.defaults')
    options.reverse_merge!(defaults)
    site = options[:site]
    title = options[:title]
    description = options[:description]
    keywords = options[:keywords]
    image = options[:image].presence || image_url('menu_placeholder.png')
    configs = {
      separator: '|',
      reverse: true,
      site:,
      title:,
      description:,
      keywords:,
      canonical: request.original_url,
      icon: {
        href: image_url('favicon.png')
      },
      og: {
        type: 'website',
        title: title.presence || site,
        description:,
        url: request.original_url,
        image:,
        site_name: site
      },
      twitter: {
        site:,
        card: 'summary_large_image',
        image:
      }
    }
    set_meta_tags(configs)
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
    elsif object == "間食"
      'text-warning'
    end
  end

  # ボタンの表示、非表示
  def display_unless(*names)
    'd-none' if active_menu?(*names)
  end
end
