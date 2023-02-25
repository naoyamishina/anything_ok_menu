class PasswordResetsController < ApplicationController
  skip_before_action :require_login
  
  # パスワードリセット申請画面へレンダリングするアクション
  def new; end
    
  # パスワードのリセットを要求するアクション。
  # ユーザーがパスワードのリセットフォームにメールアドレスを入力して送信すると、このアクションが実行される。
  def create 
    @user = User.find_by(email: params[:email])
    @user&.deliver_reset_password_instructions!
    # 上記は@user.deliver_reset_password_instructions! if @user と同じ
        
    # 電子メールが見つかったかどうかに関係なく、ユーザーの指示が送信されたことをユーザーに伝えます。
    # これは、システムに存在する電子メールに関する情報を攻撃者に漏らさないためです。
    redirect_to login_path, success: t('.success')
  end
    
  # パスワードのリセットフォーム画面へ遷移するアクション
  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    return not_authenticated if @user.blank?
  end
      
  # ユーザーがパスワードのリセットフォームを送信したときに発生
  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    return not_authenticated if @user.blank?

    # 次の行は、パスワード確認の検証を機能させます
    @user.password_confirmation = params[:user][:password_confirmation]
    # 次の行は一時トークンをクリアし、パスワードを更新します
    if @user.change_password(params[:user][:password])
      redirect_to login_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :edit
    end
  end 
end
