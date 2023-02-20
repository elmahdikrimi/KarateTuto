Feature:Tests for the home page
Background: Defined url
  Given url apiUrl

  @debug
  Scenario: Get All Tags
    Given path 'tags'
    When method GET
    Then status 200
    #And match response.tags contains ['codebaseShow','cupiditate']
    And match response.tags !contains 'Mehdi'
    And match response.tags == "#array"
    And match each response ==
    """

    """


  Scenario: Get 10 Articles from the page
      #removing parameters from the url and adding them as param
      #before url https://api.realworld.io/api/articles?limit=10&offset=0
      #after url https://api.realworld.io/api/articles with params bellow
      #Given param limit = 10
      #Given param offset = 0
      Given params {limit: 10, offset: 0}
      Given path 'articles'
      When method GET
      Then status 200
      And match response.articles == '#[10]'
      #And match response.articlesCount == 197