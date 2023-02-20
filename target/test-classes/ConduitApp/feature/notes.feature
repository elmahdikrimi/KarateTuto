Feature: notes 
Background: 
    Given url ''
    * def token = ""
    * def gettoken = callOnce read("classpath:....")
@second
Scenario: notes 
    Given header Authorization = 'Token ' + token
    Given param limit=10
    Given params {limit = 10, offset = 0}
    And match response == '#array' '##string' '#[10]'

mvn test -Dkarate.options="--tags @second"
@ignore
@skipme

mvn test -Dkarate.options="--tags ~@skipme"
mvn test -Dkarate.options="classpath:app/features/fea.feature:7"

* def feature = call read("classpath:...feature") {"email":"mehdi", "pass":"mehdi"}
And match response.body == 
"""
    {
        "name":'#(email)',
        "password":'#(pass)'
    }
"""
    * def featureData = call read('classpath:...').username
And match response contains 
And match response !contains 
And match response contains ['','']
And match response == 
And match response != 
And match response contains any ['','']

And match each response == ''
And match response[*]
And match response..name == 

* def jsfile = read("classpath:file.js")
* def javafile = Java.type('helpers.stringGenerator')
* def name = javafile.getname()

Scenario outline:

Given path 'articles',id,param
And request 
"""
{
    "name":<name>,
    "email":<email>,
    "password":<password>
}
"""
When method POST
Then status 200
examples:
|name|email|password|
|#(password)|#(email)|#(password)|

@parallel=false

* def requestBody = read('classpath:request.json')
* print array2.length

* def afterScenario = function(){ karate.call('classpath:')}
* def afterFeature = function(){karate.call('classpath:')}
* def afterScenario = () => console.log('hello')

* def function = function (){if(response.id == 1) karate.call()}