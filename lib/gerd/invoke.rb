module Gerd
    module Helpers

      class Exec

        def initialize(script)
          @script = script
        end

        def exec(model)
          eval @script
          invoke_script(model)
        end

      end

  end
end
