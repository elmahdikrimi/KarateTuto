package Helpers;

import com.github.javafaker.Faker;

import net.minidev.json.JSONObject;

public class DataGenerator {
    public static String getEmail(){
        Faker faker = new Faker();
        String email = faker.name().firstName().toLowerCase() + faker.random().nextInt(0,100) + "@gmail.com";
        return email;
    }
    public static String getUsername(){
        Faker faker = new Faker();
        return faker.name().username();
    }

    //A function that generates a json object 
    public static JSONObject randomArticleGenerator(){
        Faker faker = new Faker();
        String title = faker.gameOfThrones().character();
        String description = faker.gameOfThrones().quote();
        String body = faker.gameOfThrones().quote();
        JSONObject json = new JSONObject();
        json.put("title",title);
        json.put("description",description);
        json.put("body",body);
        return json;
    }
}
