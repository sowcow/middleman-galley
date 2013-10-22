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

  Scenario: build gallery
    Given I successfully run `middleman init my-site`
    And I cd to "my-site"

    When I append to "Gemfile" with:
      """
      gem 'middleman-galley'
      """
    And I successfully run `bundle`

    When I append to "config.rb" with:
      """
      activate :galley
      """
    And I successfully run `middleman build`

    Then the output should not contain "Unknown Extension"
    And the following files should exist:
      | build/index.html |