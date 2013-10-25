Feature: Specify view
  In order to have fun
  As a human
  I want to select another view for gallery

  Background: * basic setup *
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

    And I append to "Gemfile" with:
      """

      gem 'middleman-galley'
      """
    And I successfully run `bundle`

    And I append to "config.rb" with:
      """

      set :relative_links, true
      """

  Scenario: * use default template *
    When I append to "config.rb" with:
      """

      activate :galley
      """
    And I successfully run `middleman build --verbose`

    Then document "build/gallery/other/index.html" has 2 ".fotorama > img"
    Then document "build/gallery/other/index.html" has 0 ".Collage > img"

  Scenario: * set collage view *
    When I append to "config.rb" with:
      """

      activate :galley, view: :collage
      """
    And I successfully run `middleman build --verbose`

    Then document "build/gallery/other/index.html" has 0 ".fotorama > img"
    Then document "build/gallery/other/index.html" has 2 ".Collage > img"

  Scenario: * set fotorama view (it is default anyway) *
    When I append to "config.rb" with:
      """

      activate :galley, view: :fotorama
      """
    And I successfully run `middleman build --verbose`

    Then document "build/gallery/other/index.html" has 2 ".fotorama > img"
    Then document "build/gallery/other/index.html" has 0 ".Collage > img"
