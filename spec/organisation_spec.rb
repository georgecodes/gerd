require 'spec_helper'
require 'gerd/model/model'
require 'gerd/inspections/diffs/organisation'


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

    diff = Gerd::Inspections::Organisation::inspect_organisations(expected, actual)

    it "should spot same organisations" do
      
      expect(diff.passed).to be true

    end

    it "should give us no actions" do

      expect(diff.actions.length).to be 0

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

    diff = Gerd::Inspections::Organisation::inspect_organisations(expected, actual)
     
    it "should spot different organisations" do
  
      expect(diff.passed).to be false

    end

    it "should give us a name change action" do

      expect(diff.actions.length).to be 1

    end

  end

end