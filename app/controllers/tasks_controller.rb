class TasksController < ApplicationController
  def index
    @tasks = current_user.tasks.order(created_at: :desc)
  end

  def show
    @task = current_user.tasks.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def create
    # @taskにすることで、検証を行なったtaskのデータをビューに送ることができる。前回入力値と検証エラーの内容
    # リレーション・・・ログインしているユーザーのIDをuser_idに入れた状態でTaskデータを登録することが可能
    @task = current_user.tasks.new(task_params)

    if @task.save
      redirect_to @task, notice: "タスク「#{@task.name}」を登録しました。"
    else
      # falseの場合は登録用のフォーム画面を再表示させる
      render :new
    end
  end

  def update
    task = current_user.tasks.find(params[:id])
    task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{task.name}」を更新しました。"
  end
  
  def destroy
    task = current_user.tasks.find(params[:id])
    task.destroy
    redirect_to tasks_url, notice: "タスク「#{task.name}」を削除しました。"
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end
end
