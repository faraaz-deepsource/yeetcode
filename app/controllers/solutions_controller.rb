class SolutionsController < ApplicationController
  before_action :set_problem
  before_action :set_solution, only: %i[show update destroy]

  # GET /solutions or /solutions.json
  def index
    @solutions = Solution.all
  end

  # GET /solutions/1 or /solutions/1.json
  def show
    @lang = @lang = case @solution.problem.lang
                    when 'node'
                      'javascript'
                    else
                      @problem.lang
                    end
  end

  # GET /solutions/new
  def new
    @solution = Solution.new
    @solution.code = @problem.code
  end

  # GET /solutions/1/edit
  def edit; end

  # POST /solutions or /solutions.json
  def create
    @solution = @problem.solutions.build(solution_params)
    @solution.user = current_user
    @solution.status = 'testing'

    respond_to do |format|
      if @solution.save
        ProblemTesterJob.perform_later(@solution)
        format.html do
          redirect_to problem_solution_url(@problem, @solution), notice: 'Solution was successfully created.'
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /solutions/1 or /solutions/1.json
  def destroy
    @solution.destroy

    respond_to do |format|
      format.html { redirect_to problem_solutions_path(@problem), notice: 'Solution was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_solution
    @solution = @problem.solutions.find(params[:id])
  end

  def set_problem
    @problem = Problem.find(params[:problem_id])
  end

  # Only allow a list of trusted parameters through.
  def solution_params
    params.require(:solution).permit(:score, :code, :user_id, :problem_id, :status, :tested)
  end
end
