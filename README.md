[![Build Status](https://travis-ci.org/georgecodes/gerd.png?branch=master)](https://travis-ci.org/georgecodes/gerd)

# Gerd - Github Herder

Declaratively manage your Github estate using gerd.

## Introduction

Gerd is a tool which declaratively manages your GitHub estate. In a nutshell, it will create a metadata file for you which models a GitHub organisation, and will let you make changes to that organisation in the file, which will then be reflected in GitHub. 

Currently, the only support is for the creation and deletion of repositories, but new features will be added.

## Usage

### Installation

Gerd is a Ruby gem. Install it using

    $ gem install gerd

### Configuration

Gerd needs a GitHub API token to work. You can provide this on the command line 

    $ gerd -t wpergih3409gihjp2g4brjep
    $ gerd --token wpergih3409gihjp2g4brjep

Or as an environment variable

    $ export GERD_TOKEN=wpergih3409gihjp2g4brjep

Or in a .gerd file in the local directory

    {
      "token": "wpergih3409gihjp2g4brjep"
    }

Or in a .gerd file in your home directory. 

Gerd will look for a token in these places, in order.

### Commands

#### gerd audit

First steps are to create a snapshot of your organisation

    $ gerd audit meet-gerd -f gerd.json

This captures the data in a file which now models your organisation. It will look like this
 ```
   {
     "organisation": "meet-gerd",
     "teams": {
     },
     "repositories": {
     },
     "members": {
       "georgecodes": {
         "id": 99999
       }
    }
  }
```
#### gerd validate

At any point, you can see if your model file matches reality

    $ gerd validate meet-gerd --expected gerd.json

You will get a short report on the recognised differences

#### gerd sync

This is what will propagate changes in your gerd model to GitHub.

    $ gerd sync meet-gerd --file gerd.json

Note that as a layer of protection, destructive behaviour - deleting repos - requires an explicit flag to perform

    $ gerd sync meet-gerd --file gerd.json --delete

  
