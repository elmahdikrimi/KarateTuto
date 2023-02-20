Feature:Sign up new user
  Background: preconditions
    Given url apiUrl
    #reading a java class
    * def dataGenerator = Java.type('Helpers.DataGenerator')
    #* def dateValidator = read('classpath:Helpers/dateValidator.js')

  Scenario: New user sign up
    Given def signupData = {"email":"newuser20010@gmail.com","username": "newuser20010"}
    Given path 'users'
    * def randomEmail = dataGenerator.getEmail()
    * def randomUsername = dataGenerator.getUsername()
    #multiline Expressions
    #embedded expressions
    And request
    """
    {"user":
    {"email":"#(randomEmail)",
    "username":"#(randomUsername)",
    "password": "newuser23e"}
    }
    """
    When method POST
    Then status 200
    And match response ==
    """
    {
  "user": {
    "email": "#(randomEmail)",
    "username": "#(randomUsername)",
    "bio": "#null",
    "image": "#string",
    "token": "#string"
  }
}
    """


Scenario Outline: Scenario outline example
  * def randomEmail = dataGenerator.getEmail()
  * def randomUsername = dataGenerator.getUsername()
  
  Given path 'users'
  And request
    """
    {"user":
    {"email":"<Email>",
    "username":"<Username>",
    "password": "<Password>"}
    }
    """
  When method POST
  Then status 200
  #And match response.user.username == <Username>

  Examples:
  |Email                |Username |Password |
  |#(randomEmail)       |Mehdi2312|pass1245 |