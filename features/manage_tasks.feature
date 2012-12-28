Feature: Manage Pomodoro task
  In order to track tasks
  As a user
  I want to manage the metadata and status of my tasks

  Scenario: Edit tasks
    When I run `pomo add 'Remember the milk' -d '1 qt Almond milk' -l 60`
    And I run `pomo edit first -n 'Remember the Almond milk' -d '1 qt' -l 30`
    And I run `pomo show first`
    Then the output from "pomo show first" should contain exactly:
    """

               name : Remember the Almond milk
             length : 30 minutes
        description : 1 qt
           complete : [ ]


    """

  Scenario: Complete tasks
    When I run `pomo add 'Remember the milk'`
    And I run `pomo complete first`
    And I run `pomo show first`
    Then the output from "pomo show first" should contain exactly:
    """

               name : Remember the milk
             length : 25 minutes
           complete : [✓]


    """

  Scenario: Incomplete tasks
    When I run `pomo add 'Remember the milk'`
    And I run `pomo complete first`
    And I run `pomo incomplete first`
    And I run `pomo show first`
    Then the output from "pomo show first" should contain exactly:
    """

               name : Remember the milk
             length : 25 minutes
           complete : [ ]


    """
