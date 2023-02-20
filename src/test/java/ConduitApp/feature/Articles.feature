Feature: Articles
Background:
  * url 'https://api.realworld.io/api/'
  * def articleRequest = read('classpath:ConduitApp/json/articleRequest.json')
  * def dataGenerator1 = Java.type('Helpers.DataGenerator')
  
* configure afterScenario = function(){console.log('mehdi')}
* configure afterFeature = function(){karate.call('classpath:ConduitApp/feature/SignUp.feature')}

  * set articleRequest.article.title = dataGenerator1.randomArticleGenerator().title
  * set articleRequest.article.description = dataGenerator1.randomArticleGenerator().description
  * set articleRequest.article.body = dataGenerator1.randomArticleGenerator().body
  
  #calling another feature path starts from Java
  * def tokenResponse =  call read('classpath:Helpers/CreateToken.feature')
  #Accessing the variable inside the feature
  * def token = tokenResponse.authToken
  #@ignore
  Scenario: Create a new article

    And print token
    #passing the token to the headers Authorization
    Given header Authorization = 'Token ' + token
    #switch to path articles
    Given path 'articles'
    #passing the body for the request (article)
    And request articleRequest
    When method POST
    Then status 200
    And match response.article.title == "Article JSons"

  Scenario: Create and Delete Article
    Given header Authorization = 'Token ' + token
    Given path 'articles'
    And request {"article": {"body": "Add And delete","description": "Delete","tagList": [],"title": "delete article2"}}
    When method POST
    Then status 200
    * def articleId = response.article.slug

    Given params {limit: 10, offset: 0}
    Given path 'articles'
    When method GET
    Then status 200
    And match response.articles[0].title == "delete article2"

    Given header Authorization = 'Token ' + token
    Given path 'articles',articleId
    When method DELETE
    Then status 200

    Given params {limit: 10, offset: 0}
    Given path 'articles'
    When method GET
    Then status 200
    And match response.articles[0].title != "delete article2"