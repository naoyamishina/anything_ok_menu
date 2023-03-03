module NotificationsMacros

include LoginMacros

  def eat_click(other_user)
    login_as(other_user)
    sleep 0.5
    visit menus_path
    click_link("eat_botton")
    expect(page.accept_confirm).to eq "食べる予定にしますか？"
    sleep 0.5
    find('#header-profile').click
    click_link 'ログアウト'
  end

  def bookmark_click(other_user)
    login_as(other_user)
    sleep 0.5
    visit menus_path
    click_link "bookmark-button-for-menu-#{menu.id}"
    sleep 0.5
    find('#header-profile').click
    click_link 'ログアウト'
  end

  def comment_by(other_user)
    login_as(other_user)
    sleep 0.5
    visit menu_path menu
    fill_in 'js-new-comment-body', with: '新規コメント'
    click_on 'js-comment-create-btn'
    sleep 0.1
    find('#header-profile').click
    click_link 'ログアウト'
  end
end