module Gerd
  module Inspections
    module Actions
      
      class CreateRepo

        def initialize(repo_to_create, org, privacy = false)
          @org = org
          @repo = repo_to_create
          @privacy = privacy
        end

        def invoke(client, options = {})
          puts "I WANT TO CREATE #{@org}/#{@repo}"
          opts = { 
            :organization => @org,
            :private => @privacy
          }
          res = client.create_repo(@repo, { :organization => @org })
          puts res
        end

      end

    end
  end
end