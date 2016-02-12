require 'spec_helper'
require 'grim/model'

describe Grim::Model::GithubState do

  context "validation" do

    it "should validate good json" do

      content = load_fixture('good_state.json')
    
      state = Grim::Model::GithubState.new(content)
      
      expect(state.valid?).to be true

    end

    it "should not validate malformed json" do

      content = "{"

      state = Grim::Model::GithubState.new(content)
      
      expect(state.valid?).to be false

    end

    it "should not validate if no organisation is present" do
      content = <<-JSON
      {
        "teams": {},
        "repositories": {},
        "members": {}
      }
      JSON

      state = Grim::Model::GithubState.new(content)
      
      expect(state.valid?).to be false

    end

    it "should not validate if no team element is present" do
      content = <<-JSON
      { 
        "organisation": "test",
        "repositories": {},
        "members": {}
      }
      JSON

      state = Grim::Model::GithubState.new(content)
      
      expect(state.valid?).to be false

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

      state = Grim::Model::GithubState.new(content)
      
      expect(state.valid?).to be false

    end

    it "should not validate if no repositories element is present" do
      content = <<-JSON
      { 
        "organisation": "test",
        "teams": {},
        "members": {}
      }
      JSON

      state = Grim::Model::GithubState.new(content)
      
      expect(state.valid?).to be false

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

      state = Grim::Model::GithubState.new(content)
      
      expect(state.valid?).to be false

    end

    it "should not validate if no members element is present" do
      content = <<-JSON
      { 
        "organisation": "test",
        "teams": {},
        "repositories": {}
      }
      JSON

      state = Grim::Model::GithubState.new(content)
      
      expect(state.valid?).to be false

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

      state = Grim::Model::GithubState.new(content)
      
      expect(state.valid?).to be false

    end

  end

end