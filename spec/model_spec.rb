require 'spec_helper'
require 'grim/model'

describe Grim::Model::GithubState do

  context "validation" do

    it "should validate good json" do

      content = load_fixture('good_state.json')
    
      state = Grim::Model::GithubState.new(content)
      
    end

    it "Should pull out the organisation" do

        content = load_fixture('good_state.json')
    
        state = Grim::Model::GithubState.new(content)

        expect(state.organisation).to eq "Elevenware"

    end

    it "Should have two teams" do

      content = load_fixture('good_state.json')
    
      state = Grim::Model::GithubState.new(content)

      expect(state.teams.length).to eq 2

    end

    it "Should have three members" do

      content = load_fixture('good_state.json')
    
      state = Grim::Model::GithubState.new(content)

      expect(state.members.length).to eq 3

    end

    it "Should have seven repositories" do

      content = load_fixture('good_state.json')
    
      state = Grim::Model::GithubState.new(content)

      expect(state.repositories.length).to eq 7

    end

    it "should not validate malformed json" do

      content = "{"

      expect {Grim::Model::GithubState.new(content) }.to raise_error Exception
      
    end

    it "should not validate if no organisation is present" do
      content = <<-JSON
      {
        "teams": {},
        "repositories": {},
        "members": {}
      }
      JSON

      expect {Grim::Model::GithubState.new(content) }.to raise_error Exception
      

    end

    it "should not validate if no team element is present" do
      content = <<-JSON
      { 
        "organisation": "test",
        "repositories": {},
        "members": {}
      }
      JSON

     expect {Grim::Model::GithubState.new(content) }.to raise_error Exception

    end

    it "should not validate if the team element is not an object" do
      content = <<-JSON
      { 
        "organisation": "test",
        "teams": "a string",
        "repositories": {},
        "members": {}
      }
      JSON

      expect {Grim::Model::GithubState.new(content) }.to raise_error Exception

    end

    it "should not validate if no repositories element is present" do
      content = <<-JSON
      { 
        "organisation": "test",
        "teams": {},
        "members": {}
      }
      JSON

      expect {Grim::Model::GithubState.new(content) }.to raise_error Exception

    end

    it "should not validate if the repositories element is not an object" do
      content = <<-JSON
      { 
        "organisation": "test",
        "teams": {},
        "repositories": "dve",
        "members": {}
      }
      JSON

      expect {Grim::Model::GithubState.new(content) }.to raise_error Exception

    end

    it "should not validate if no members element is present" do
      content = <<-JSON
      { 
        "organisation": "test",
        "teams": {},
        "repositories": {}
      }
      JSON

      expect {Grim::Model::GithubState.new(content) }.to raise_error Exception

    end

    it "should not validate if the members element is not an object" do
      content = <<-JSON
      { 
        "organisation": "test",
        "teams": {},
        "repositories": {},
        "members": ""
      }
      JSON

      expect {Grim::Model::GithubState.new(content) }.to raise_error Exception 

    end

  end

end