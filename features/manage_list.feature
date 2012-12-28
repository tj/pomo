Feature: Manage Pomodoro list
  In order to complete tasks
  As a user
  I want to manage the order and content of my task list

  Scenario: Add tasks
    When I run `pomo add 'Remember the milk'`
    And I run `pomo list`
    Then the output from "pomo list" should contain "Remember the milk"

  Scenario: Remove tasks
    Given the following tasks:
      | Remember the milk |
      | Walk the dog      |
      | Shave the yak     |
    When I run `pomo rm first`
    And I run `pomo list`
    Then the output from "pomo list" should not contain "Remember the milk"

  Scenario: Move tasks
    Given the following tasks:
      | Remember the milk |
      | Walk the dog      |
      | Shave the yak     |
    When I run `pomo mv first last`
    And I run `pomo list`
    Then the output from "pomo list" should contain exactly:
    """
        0. Walk the dog                                       : 25 minutes
        1. Shave the yak                                      : 25 minutes
        2. Remember the milk                                  : 25 minutes
                                                                75 minutes

    """
