class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :login_required

  private

  # 全てのコントローラーから利用可能 アクションではないのでprivateへ
  def current_user
    # セッションに保存されているIDを読み出して、ユーザーのデータを保存
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  
  def login_required
    redirect_to login_path unless current_user
  end
end
