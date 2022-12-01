require 'tempfile'

class ProblemTesterJob < ApplicationJob
  queue_as :urgent

  def perform(solution)
    puts "Testing solution # #{solution.id}..."

    problem = solution.problem
    test_code = <<~TEST_CODE
      #{solution.code}
      #{problem.test}
    TEST_CODE

    file = Tempfile.new
    file.write(test_code)
    file.close

    sleep rand(2..5)

    command = "#{problem.lang} #{file.path}"
    results = system command
    file.unlink

    quality_score = rand(-5..5)
    case results
    when true
      solution.score += 5 + quality_score
      completion = Completion.new(user: solution.user, solution:, problem:)
      completion.save!
    else
      solution.score -= 5 + quality_score
    end

    solution.tested = true
    solution.status = 'ended'
    solution.save!
  end
end
