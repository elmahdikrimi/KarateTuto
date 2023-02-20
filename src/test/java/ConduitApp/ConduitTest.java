package ConduitApp;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;

import com.intuit.karate.junit5.Karate;
import org.junit.jupiter.api.Test;
import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;

class ConduitTest {

    //this runs all the tests in the .feature file
    @Test
    void testParallel() {
        Results results = Runner.path("classpath:ConduitApp")
                .outputCucumberJson(true)
                .parallel(5);
        assertTrue(results.getFailCount() == 0,results.getErrorMessages());
    
    }

    public static void generateReport(String karateOutputPath) {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"}, true);
        List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("target"),"ConduitApp");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }

    //this runs all test with the tag @debug
    @Karate.Test
    Karate testTags() {
        return Karate.run().tags("@debug").relativeTo(getClass());
    }
}
