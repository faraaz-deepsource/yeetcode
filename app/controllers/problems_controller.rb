class ProblemsController < ApplicationController
  before_action :set_problem, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[new edit update destroy]

  # GET /problems or /problems.json
  def index
    @problems = Problem.all
    return unless user_signed_in?

    @completions = []

    @problems.each do |prob|
      @completions << Completion.where(user_id: current_user.id, problem_id: prob.id).first
    end
  end

  # GET /problems/1 or /problems/1.json
  def show
    @lang = case @problem.lang
            when 'node'
              'javascript'
            else
              @problem.lang
            end
    return unless user_signed_in?

    @completion = Completion.where(user_id: current_user.id, problem_id: @problem.id).first

    @solutions = Solution.where(problem: @problem) unless @completion.nil?
  end

  # GET /problems/new
  def new
    @problem = Problem.new
  end

  # GET /problems/1/edit
  def edit; end

  # POST /problems or /problems.json
  def create
    @problem = Problem.new(problem_params)
    @problem.user = current_user

    respond_to do |format|
      if @problem.save
        format.html { redirect_to problem_url(@problem), notice: 'Problem was successfully created.' }
        format.json { render :show, status: :created, location: @problem }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /problems/1 or /problems/1.json
  def update
    respond_to do |format|
      if @problem.update(problem_params)
        format.html { redirect_to problem_url(@problem), notice: 'Problem was successfully updated.' }
        format.json { render :show, status: :ok, location: @problem }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /problems/1 or /problems/1.json
  def destroy
    @problem.destroy

    respond_to do |format|
      format.html { redirect_to problems_url, notice: 'Problem was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_problem
    @problem = Problem.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def problem_params
    params.require(:problem).permit(:code, :user_id, :title, :description, :test, :lang)
  end
end
