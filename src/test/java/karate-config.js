function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: 'https://api.realworld.io/api/',
  }
  if (env == 'dev') {
config.name="waa"
config.job="api tester"
  } else if (env == 'QA') {
    config.userName = "mehdi"
    config.passWord = "mehdi123"
  }

  var access2 = karate.callSingle('classpath:..feature',config).access2
  karate.configure('headers',{Authorization: access2})
  //setting the access token by calling the feature and passing object config
  var accessToken = karate.callSingle('classpath:Helpers/CreateToken.feature',config).authToken
  karate.configure('headers',{Authorization: 'Token '+ accessToken})

  karate.configure('retry',{count:10, interval: 5000})
  return config;
}

