Feature: test
Scenario Outline: Ensure that specific tags_all are defined
  Given I have resource that supports tags_all defined
  When it has tags_all
  Then it must contain tags_all
  Then it must contain "<tags_all>"
  And its value must match the "<value>" regex

  Examples:
    | tags_all    | value |
    | Name        | .+    |
    | environment | .+    |
