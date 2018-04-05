require 'rake'

module RakeHelpers
  # Invoke a rake task
  # @param task [String/Symbol] The rake task to execute (incl. namespace)
  # @param *args [Array] Arguments to pass through to the rake task
  # @param options [Hash] A hash of additional options
  # @example
  #       invoke_rake_task('mytask', ['argument1', 'argument2'], env_vars: 'env_var1=MyEnvVarValue,env_var2=MyOtherEnvVarValue' )
  # @return [Integer] The exit code returned by the rake task
  def invoke_rake_task(task, *args, **options)
    env_vars = options.has_key?(:env_vars) ? options[:env_vars].split(',') : []
    args = args

    rake = Rake::Application.new
    Rake.application = rake
    Rake::Task.define_task :environment
    
    rake_files_to_load.each { |r| load r }

    set_env_variables(env_vars)

    begin
      rake[task].invoke(args)
    rescue SystemExit => e
      exit_code = e.status
    end

    unset_env_variables(env_vars)

    exit_code
  end

  private

  def rake_files_to_load
    Dir.glob(File.expand_path('../../../lib/tasks/**/*.rake', __FILE__))
  end

  # Sets environment variables from an array of 'key=value' pairs
  # @param env_vars [Array<String>] An array of 'key=value' pairs
  def set_env_variables(env_vars = [])
    env_vars.each do |_v|
      key, value = _v.split("=")

      ENV[key] = value
    end
  end

  # Unsets environment variables from an array of 'key=value' pairs
  # @param env_vars [Array<String>] An array of 'key=value' pairs
  def unset_env_variables(env_vars = [])
    env_vars.each do |var|
      key, value = var.split("=")

      ENV.delete(key)
    end
  end
end

World(RakeHelpers)