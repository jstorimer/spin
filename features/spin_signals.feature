Feature: Spin should respond to signals

  Scenario: Spin exits cleanly
    When I run `spin`
    And I send the "INT" signal to `spin`
    Then the `spin` exit status should be 0

