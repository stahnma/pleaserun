require 'pleaserun/namespace'
require 'pleaserun/base'

class PleaseRun::Runit < PleaseRun::Base
  attribute :service_path, "The path runit service directory",
            :default => "/service" do |path|
    insist { path }.is_a?(String)
  end

  def files
    return Enumerator::Generator.new do |enum|
      enum.yield [ safe_filename("{{ service_path }}/{{ name }}/run"), render_template('run') ]
      enum.yield [ safe_filename("{{ service_path }}/{{ name}}/log/run"), render_template('log') ]
    end
  end
end
