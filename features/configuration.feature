Feature: Configure pomo
  In order to use pomo
  As a user
  I want a sane default configuration for my system
  and a data file to store my tasks

  Scenario: Execute pomo without configuration
    When I run `pomo`
    Then the following files should exist:
      | /tmp/home/.pomorc |
      | /tmp/home/.pomo   |
    And the output should contain "Initialized default config file in /tmp/home/.pomorc. See 'pomo help initconfig' for options."

  Scenario: Initialize configuration
    When I run `pomo initconfig`
    Then the following files should exist:
      | /tmp/home/.pomorc |
      | /tmp/home/.pomo   |
    And the output should contain "Initialized config file"

  Scenario: Initialize configuration (no clobber)
    Given a file named "/tmp/home/.pomorc" with:
      """
      hello world
      """
    When I run `pomo initconfig`
    Then the output should contain "Not overwriting existing config file"

  Scenario: Force initialize configuration (clobber)
    Given a file named "/tmp/home/.pomorc" with:
      """
      hello world
      """
    When I run `pomo initconfig --force`
    Then the file "/tmp/home/.pomorc" should not contain "hello world"
