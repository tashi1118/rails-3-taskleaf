class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    # @tasks = current_user.tasks.order(created_at: :desc)
    @q = current_user.tasks.ransack(params[:q])
    # @tasks = @q.result(distinct: true).recent
    @tasks = @q.result(distinct: true)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    # @taskにすることで、検証を行なったtaskのデータをビューに送ることができる。前回入力値と検証エラーの内容
    # リレーション・・・ログインしているユーザーのIDをuser_idに入れた状態でTaskデータを登録することが可能
    @task = current_user.tasks.new(task_params)

    if params[:back].present?
      render :new
      return
    end

    if @task.save
      # メールを即時送信するためのメソッド＝deliver_now
      TaskMailer.creation_email(@task).deliver_now
      redirect_to @task, notice: "タスク「#{@task.name}」を登録しました。"
    else
      # falseの場合は登録用のフォーム画面を再表示させる
      render :new
    end
  end

  def update
    @task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を更新しました。"
  end
  
  def destroy
    @task.destroy
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を削除しました。"
  end

  def confirm_new
    @task = current_user.tasks.new(task_params)
    render :new unless @task.valid? # 後置if
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end
