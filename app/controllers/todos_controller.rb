class TodosController < ApplicationController
	def index
		@todos = Todo.all
		if params[:status].present?
			@todos = @todos.where(:status => false)
		end
		if params[:status2].present?
			@todos = @todos.where(:status => true)
		end
	end
	def show
		@todo = Todo.find(params[:id])
	end
	def new
		@todo = Todo.new
	end

	def create
		@todo = Todo.new(todo_params)
		if @todo.save
			redirect_to root_path
		else
			render :new
		end
	end

	def edit
		@todo = Todo.find(params[:id])
	end

	def update
		@todo = Todo.find(params[:id])
		if @todo.update(todo_params)
			redirect_to root_path
		else
			render :edit
		end
	end

	def destroy
		@todo = Todo.find(params[:id])
		@todo.destroy
		redirect_to root_path
	end

	def compelete
		@todo = Todo.find(params[:id])

		if @todo.status == false
			@todo.update_attribute(:status,true)
			redirect_to root_path
		else
			@todo.update_attribute(:status, false)
			redirect_to root_path
		end
	end
	
private
	def todo_params
		params.require(:todo).permit(:title, :status)
	end
end
