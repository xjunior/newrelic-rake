require 'new_relic/agent/method_tracer'

DependencyDetection.defer do
  @name = :rake

  depends_on do
    defined?(::Rake) and not ::NewRelic::Control.instance['disable_rake']
  end

  executes do
    ::NewRelic::Agent.logger.info 'Installing Rake instrumentation'
  end

  executes do
    class Rake::Task
      prepend NewRelic::Rake::Task
    end
  end
end
