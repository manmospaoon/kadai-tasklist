class TasksController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :edit, :update, :destroy, :new]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  #privateで定義したset_taskを使用するため、before_actionでまとめる。

  def index 
    if logged_in?
      @tasks = current_user.tasks.order(id: :desc).page(params[:page]).per(7)
    end
  end 
  
  def show
   correct_user
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'Task が正常に投稿されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task が正常に投稿されませんでした'
      render :new
    end
  end
  #redirect_toは強制的に移動、renderは単に表示する。
  #radirect_to @task は、redirect_toの引数にモデルのインスタンスを渡すと、model_urlメソッドが組み込まれる。

  def edit
    correct_user
    
  end
  
  def update
    correct_user
    if @task.update(task_params)
      flash[:success] ='Task は正常に更新されました'
      redirect_to @task
    else
      flash.now[:denger] = 'Task は更新されませんでした。'
      render :edit
    end
  end
  
  def destroy
    correct_user
    @task.destroy
    
    flash[:success] = 'Taskは正常に削除されました。'
    redirect_to root_url
  end
  
  private
  #これ以降に定義されたメソッドがアクション内ではなく、クラス内のみ使用することを示す。
  
  
  
  #Strong Parameter(セキュリティ対策)
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  # params.require(:task) でTaskモデルのフォームからのデータだと示す。
  #permit(:content) で必要なカラムだけを選択。(content)
  
   def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
   end
  
  
end

