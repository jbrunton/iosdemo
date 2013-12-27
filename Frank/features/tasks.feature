Feature: Tasks

Scenario: List of tasks

  Given I launch the app
  Then I should be on the 'Tasks' screen

  Given I have a task 'some task'
  And I am on the Tasks screen
  Then the task 'some task' should be visible
