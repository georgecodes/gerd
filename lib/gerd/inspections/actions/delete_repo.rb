module Gerd
  module Inspections
    module Actions
      
      class DeleteRepo

        def initialize(repo_to_delete, organisation)
          @org = organisation
          @repo = repo_to_delete
        end

        def invoke(client, options = {})
         if !options[:delete]
           puts "You must explicitly use the --delete option to delete repos"
           return
          end
          opts = {
            :organization => @org
          }
          repo_name = "#{@org}/#{@repo}"
          puts "Deleting #{repo_name}"
          client.delete_repository(repo_name, opts)
        end

      end

    end
  end
end