
Feature: Home Work

    Background: Preconditions
        * url apiUrl 
        * def slugReader = read('classpath:ConduitApp/json/articleRequest.json')
        * def slugs = slugReader.article.slugs

    Scenario: Favorite articles
        # Step 1: Get atricles of the global feed
        Given params {limit: 10, offset: 0}
        Given path 'articles'
        When method GET
        Then status 200
        # Step 2: Get the favorites count and slug ID for the first article, save it to variables
        Given def slug = response.articles[0].slug
        Given def favCount = response.articles[0].favoritesCount
        
        # Step 3: Make POST request to increse favorites count for the first article
        Given path 'articles/',slug
        When method POST
        Then status 200
        # Step 4: Verify response schema
        And match response == 
        """
            {
                "articles":"#array"[
                    "id":"#integer",
                    "title":"#string",
                    "description":"#string"
                    "body":"#string"

                ]
            }
        """
        # Step 5: Verify that favorites article incremented by 1
        * def initialCount = favCount
        And match response.articles[0].favoritesCount == initialCount + 1 
            #Example
            #* def initialCount = 0
            #* def response = {"favoritesCount": 1}
            #* match response.favoritesCount == initialCount + 1

        # Step 6: Get all favorite articles
        Given path 'articles'
        Given params {"favorited":"newuser23", "limit":5, "offset":0}
        When method GET 
        Then status 200
        # Step 7: Verify response schema
        # Step 8: Verify that slug ID from Step 2 exist in one of the favorite articles
        And match reponse.articles[*].slug contains slug

    Scenario: Comment articles

        # Step 1: Get atricles of the global feed
       
        Given path 'articles', slug, '/comments'
        And print slugs
        # Step 2: Get the slug ID for the first arice, save it to variable
        # Step 3: Make a GET call to 'comments' end-point to get all comments
        # Step 4: Verify response schema
        # Step 5: Get the count of the comments array lentgh and save to variable
            #Example
            * def responseWithComments = [{"article": "first"}, {article: "second"}]
            * def articlesCount = responseWithComments.length
        # Step 6: Make a POST request to publish a new comment
        # Step 7: Verify response schema that should contain posted comment text
        # Step 8: Get the list of all comments for this article one more time
        # Step 9: Verify number of comments increased by 1 (similar like we did with favorite counts)
        # Step 10: Make a DELETE request to delete comment
        # Step 11: Get all comments again and verify number of comments decreased by 1