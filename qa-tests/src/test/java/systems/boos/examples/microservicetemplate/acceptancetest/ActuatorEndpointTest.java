package systems.boos.examples.microservicetemplate.acceptancetest;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.context.SpringBootTest.WebEnvironment;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.web.server.LocalServerPort;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.context.junit4.SpringRunner;

import static org.junit.Assert.assertTrue;

@TestPropertySource(locations = "classpath:qa-tests.properties")
@SpringBootTest(webEnvironment = WebEnvironment.RANDOM_PORT, classes = systems.boos.examples.microservicetemplate.Application.class)
@RunWith(SpringRunner.class)
public class ActuatorEndpointTest
{
   @LocalServerPort
   private int port;

   @Autowired
   private TestRestTemplate restTemplate;

   @Test
   public void test()
   {
      assertTrue("test failed", true);
   }
}
