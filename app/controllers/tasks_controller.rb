class TasksController < ApplicationController
  #privateで定義したset_askを使用するため、before_actionでまとめる。
  before_action :set_task,only[:show, :edit, :update, :destroy]
  
  def index
    @tasks = Task.all
  end 
  
  def show
   set_task
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
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
    set_task
    
  end
  
  def update
    set_task
    if @task.update(task_params)
      flash[:success] ='Task は正常に更新されました'
      redirect_to @task
    else
      flash.now[:denger] = 'Task は更新されませんでした。'
      render :edit
    end
  end
  
  def destroy
    set_task
    @task.destroy
    
    flash[:success] = 'Taskは正常に削除されました。'
    redirect_to tasks_url
  end
  
  private
  #これ以降に定義されたメソッドがアクショ��ではなく、クラス内のみ使用することを示す。
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  
  #Strong Parameter(セキュリティ対策)
  
  def task_params
    params.require(:task).permit(:content)
  end
  # params.require(:task) でTaskモデルのフォームからのデータだと示す。
  #permit(:content) で必要なカラムだけを選択。(content)
  
  
  
end

