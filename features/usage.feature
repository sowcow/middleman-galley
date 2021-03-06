Feature: Basic usage
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

    # images for the gallery
    And I put in my images:
      | source/gallery/cards/one/01.png |
      | source/gallery/cards/one/02.png |
      | source/gallery/cards/two/a1.png |
      | source/gallery/cards/two/a2.png |
      | source/gallery/other/01.png |
      | source/gallery/other/02.png |

    When I append to "Gemfile" with:
      """

      gem 'middleman-galley'
      """
    And I successfully run `bundle`

    When I append to "config.rb" with:
      """

      # by default uses `gallery` dir inside `source` dir
      activate :galley

      # todo: test non relative paths?
      set :relative_links, true
      """
    # verbose option is optional
    And I successfully run `middleman build --verbose`

    Then the output should not contain "Unknown Extension"

    # pages
    And the following files should exist:
      | build/gallery/index.html |

      | build/gallery/cards/index.html |
      | build/gallery/cards/one/index.html |
      | build/gallery/cards/one/01.png |
      | build/gallery/cards/one/02.png |

      | build/gallery/cards/two/index.html |
      | build/gallery/cards/two/a1.png |
      | build/gallery/cards/two/a1.png |

      | build/gallery/other/index.html |
      | build/gallery/other/01.png |
      | build/gallery/other/02.png |

    # pages are linked (links sorted by name?) distinct feature?
    And the file "build/gallery/index.html" has links:
      | cards | cards/ |
      | other | other/ |

    And the file "build/gallery/cards/index.html" has links:
      | one | one/ |
      | two | two/ |

    And the file "build/gallery/cards/one/index.html" has no links
    And the file "build/gallery/cards/two/index.html" has no links
    And the file "build/gallery/other/index.html" has no links

    # pages have images
    And the file "build/gallery/cards/one/index.html" has images:
      | 01.png |
      | 02.png |
    And the file "build/gallery/cards/two/index.html" has images:
      | a1.png |
      | a2.png |
    And the file "build/gallery/other/index.html" has images:
      | 01.png |
      | 02.png |
    And the file "build/gallery/index.html" has no images
    And the file "build/gallery/cards/index.html" has no images

    # with fotorama template by default:
    And document "build/gallery/index.html" has 0 ".fotorama > img"
    And document "build/gallery/cards/index.html" has 0 ".fotorama > img"
    And document "build/gallery/cards/one/index.html" has 2 ".fotorama > img"
    And document "build/gallery/cards/two/index.html" has 2 ".fotorama > img"
    And document "build/gallery/other/index.html" has 2 ".fotorama > img"
