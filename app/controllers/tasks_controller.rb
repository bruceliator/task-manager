class TasksController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /tasks
  # GET /tasks.json
  def index
    @complited_tasks = current_user.tasks.where(:complited => true).order(sort_column + " " + sort_direction)
    @incomplited_tasks = current_user.tasks.where(:complited => false).order(sort_column + " " + sort_direction)
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  	@task = current_user.tasks.find(params[:id])
	respond_to do |format|
		format.html # show.html.erb
		format.json { render :json => @task }
	end
	rescue ActiveRecord::RecordNotFound
      redirect_to tasks_path

  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = current_user.tasks.build(task_params)

    respond_to do |format|
      if @task.save
	flash[:success] = "Micropost created!"
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render action: 'show', status: :created, location: @task }
      else
        format.html { render action: 'new' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end
	
  def complete_multiple 
    current_user.tasks.where(id: params[:task_ids]).update_all(["complited=?", true])
    redirect_to tasks_path
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
      format.js
    end
  end

  def destroy_multiple
    Task.destroy(params[:task_ids])
    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
      format.js
    end
    rescue ActiveRecord::RecordNotFound
      redirect_to tasks_path

end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :description, :priority, :due_date, :user_id, :complited)
    end

  def sort_column
    Task.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
