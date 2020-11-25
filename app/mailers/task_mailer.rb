class TaskMailer < ApplicationMailer
  default from: 'taskleaf@example.com'

  def creation_email(task)
    # メール本文作成のためにテンプレートで利用したいので、インスタンス変数に代入
    @task = task
    mail(
      subject: 'タスク作成完了メール',
      to: 'user@example.com',
      from: 'taskleaf@example.com'
    )
  end
end
