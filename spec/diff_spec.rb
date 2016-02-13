require 'spec_helper'
require 'gerd/model/model'
require 'gerd/inspections/inspections'

describe "organisation diff" do

  context "states match" do

    expected = Gerd::Model::GithubState.new( 
    { 
      "organisation" => "Test organisation",
      "teams" => {},
      "members" => {},
      "repositories" => {}
    })

    actual = Gerd::Model::GithubState.new( 
    { 
      "organisation" => "Test organisation",
      "teams" => {},
      "members" => {},
      "repositories" => {}
    })

    it "should spot same organisations" do
  
      diff = Gerd::Inspections::inspect_organisations(expected, actual)
      
      expect(diff.passed).to be true

    end

    it "should spot same teams" do

      diff = Gerd::Inspections::inspect_teams(expected, actual)
      
      expect(diff.passed).to be true

    end

  end

  context "states do not match" do

    expected = Gerd::Model::GithubState.new( 
    { 
      "organisation" => "Test organisation",
      "teams" => {},
      "members" => {},
      "repositories" => {}
    })

    actual = Gerd::Model::GithubState.new( 
    { 
      "organisation" => "Other organisation",
      "teams" => {},
      "members" => {},
      "repositories" => {}
    })

    it "should spot same organisations" do
  
      diff = Gerd::Inspections::inspect_organisations(expected, actual)
      
      expect(diff.passed).to be false

    end

  end

end