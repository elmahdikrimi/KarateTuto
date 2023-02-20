Feature: Basic API calls
Background:
  * url 'https://jsonplaceholder.typicode.com/'

  Scenario: POST Method
    Given path 'posts'
    And request {"title": "foo","body": "bar","userId": 1}
    When method POST
    Then status 201
    And match response.userId == 1

  Scenario: Patch Method
    Given path 'posts/1'
    And request {"title":  "FLL"}
    When method PATCH
    Then status 200
    And print response.title

  Scenario: Delete Method
    Given path 'posts/1'
    When method DELETE
    Then status 200

  Scenario: Get
    Given path 'posts/1'
    When method GET
    Then status 200
    And print response

  Scenario Outline:
    Given def myName = Name
    And print myName, Age
  Examples:
    |Name    |Age |
    |El Mahdi|31 |
