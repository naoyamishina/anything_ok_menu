module LoginMacros
  def login_as(user)
    visit login_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード (英数字3文字以上)', with: 'password'
    click_button 'ログイン'
  end
end