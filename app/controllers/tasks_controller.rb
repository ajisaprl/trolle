class TasksController < ApplicationController
	before_action :authenticate_user!
	before_action :set_task, only: [:edit, :update, :show, :destroy, :change]

	def index
		@to_do = current_user.tasks.where(state: 'to_do')
		@doing = current_user.tasks.where(state: 'doing')
		@done = current_user.tasks.where(state: 'done')
	end

	def new
		@task = Task.new
	end

	def create
		@task = current_user.tasks.new(tasks_params)
		if @task.save
			flash[:success] = "Task created!"
			redirect_to tasks_path(@task)
		else
			render 'new'
		end
	end

	def update
		if @task.update(tasks_params)
			flash[:success] = 'Task '
			redirect_to tasks_path(@task)
		else
			render 'edit'
		end
	end

	def destroy
		@task.destroy
		flash[:danger] = 'Task was successfully deleted'
		redirect_to tasks_path
	end

	def change
		@task.update_attributes(state: params[:state])
		if @task.state == 'to_do'
			@task.state = 'To Do'
		end
		flash[:success] = 'Task updated to ' + @task.state
		redirect_to tasks_path
	end

	private

	def set_task
		@task = Task.find(params[:id])
	end

	def tasks_params
		params.require(:task).permit(:content, :state)
	end

end