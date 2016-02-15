require 'spec_helper'
require 'gerd/model/model'
require 'gerd/inspections/diffs/repositories'

describe 'repositories inspection' do

  context 'repositories match' do

    expected = Gerd::Model::GithubState.new( 
    { 
      "organisation" => "Test organisation",
      "teams" => {},
      "members" => {},
      "repositories" => {
        "foo" => {
          "private" => false
        },
        "bar" => {
          "private" => false
        }
      }
    })

    actual = Gerd::Model::GithubState.new( 
    { 
      "organisation" => "Test organisation",
      "teams" => {},
      "members" => {},
      "repositories" => {
        "foo" => {
          "private" => false
        },
        "bar" => {
          "private" => false
        }
      }
    })

    diffs = Gerd::Inspections::Repositories::inspect_repositories(expected, actual)

    it "should give me 0 diffs" do

      expect(diffs.length).to be 0

    end 

  end

  context 'missing repository' do

    expected = Gerd::Model::GithubState.new( 
    { 
      "organisation" => "Test organisation",
      "teams" => {},
      "members" => {},
      "repositories" => {
        "foo" => {
          "private" => false
        },
        "bar" => {
          "private" => false
        }
      }
    })

    actual = Gerd::Model::GithubState.new( 
    { 
      "organisation" => "Test organisation",
      "teams" => {},
      "members" => {},
      "repositories" => {
        "foo" => {
          "private" => false
        }
      }
    })

    diffs = Gerd::Inspections::Repositories::inspect_repositories(expected, actual)

    it "should give me 1 diff" do

      expect(diffs.length).to be 1

      expect(diffs[0].message).to eq "I expected to see repository bar but did not"

      expect(diffs[0].actions.length).to be 1

      expect(diffs[0].actions[0].class).to be Gerd::Inspections::Actions::CreateRepo

    end 

  end

  context 'extra repository' do

    expected = Gerd::Model::GithubState.new( 
    { 
      "organisation" => "Test organisation",
      "teams" => {},
      "members" => {},
      "repositories" => {
        "foo" => {
          "private" => false
        }
      }
    })

    actual = Gerd::Model::GithubState.new( 
    { 
      "organisation" => "Test organisation",
      "teams" => {},
      "members" => {},
      "repositories" => {
        "foo" => {
          "private" => false
        },
        "bar" => {
          "private" => false
        }
      }
    })

    diffs = Gerd::Inspections::Repositories::inspect_repositories(expected, actual)

    it "should give me 1 diff" do

      expect(diffs.length).to be 1

      expect(diffs[0].message).to eq "I did not expect to see repository bar but saw it anyway"

      expect(diffs[0].actions.length).to be 1

      expect(diffs[0].actions[0].class).to be Gerd::Inspections::Actions::DeleteRepo

    end 

  end
  
end