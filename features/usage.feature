Feature: Usage
  In order to have fun
  As a human
  I want my images in the browser

  Scenario: ruby is installed
    When I successfully run `ruby -v`
    Then the output should contain "ruby"

  Scenario: middleman is installed
    When I successfully run `middleman --help`
    Then the output should contain "middleman"
