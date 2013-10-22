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

    # images for gallery
    And I prepare following files:
      | source/gallery/cards/one/01.png |
      | source/gallery/cards/one/02.png |
      | source/gallery/cards/two/01.png |
      | source/gallery/cards/two/02.png |
      | source/gallery/other/01.png |
      | source/gallery/other/02.png |

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
      | build/gallery/index.html |

      | build/gallery/cards/index.html |
      | build/gallery/cards/one/index.html |
      | build/gallery/cards/one/01.png |
      | build/gallery/cards/one/02.png |

      | build/gallery/cards/two/index.html |
      | build/gallery/cards/two/01.png |

      | build/gallery/other/index.html |
      | build/gallery/other/01.png |
      | build/gallery/other/02.png |
