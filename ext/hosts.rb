require 'lib/ghost/lib/ghost'

=begin
class HostControl
    def initialize(app, env)
        @app = app
    end
    def call(env)
        if Vagrant::Util::Platform::posix?
            puts "Removing host file entries...sudo needed"
            system(%Q[sudo su root -c "ruby -I lib/ghost/lib -I lib/unindent/lib lib/ghost/bin/ghost empty"])
        end

        @app.call(env)
    end
end
=end