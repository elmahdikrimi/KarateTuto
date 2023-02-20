Feature: Getting the Auth

Background:
    * url 'https://restful-booker.herokuapp.com/'
    #* def accessFeature = callonce read('classpath:helpers/CreateToken.feature')

Scenario: Getting the Auth
    Given path 'auth'
    And request
    """
        {
        "username" : "admin",
        "password" : "password123"
    }  
    """  
    When method POST
    Then status 200