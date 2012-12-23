@announce
Feature: Configure pomo
  In order to use pomo
  As a user
  I want a sane default configuration for my system
  and a data file to store my tasks

  Scenario: Execute pomo for first time
    When I run `pomo`
    Then the following files should exist:
      | /tmp/home/.pomo   |
      | /tmp/home/.pomorc |
