When("I run the {string} rake task with the {string} environment variables") do |rake_task, environment_variables|
  @exit_code = invoke_rake_task(rake_task, env_vars: environment_variables)
end

Then("the exit code should be {int}") do |expected_exit_code|
  expect(@exit_code).to eq(expected_exit_code)
end