module NewRelic
  module Rake
    module Task
      include ::NewRelic::Agent::Instrumentation::ControllerInstrumentation

      def execute(args=nil)
        return super if ignore_metric_reporting?

        unless ::NewRelic::Rake.started?
          ::NewRelic::Agent.manual_start
          ::NewRelic::Rake.started = true
        end
        perform_action_with_newrelic_trace(:name => self.name, :category => "OtherTransaction/Rake") do
          super(args)
        end
      end

      def ignore_metric_reporting?
        self.name == 'jobs:work'
      end
    end
  end
end
