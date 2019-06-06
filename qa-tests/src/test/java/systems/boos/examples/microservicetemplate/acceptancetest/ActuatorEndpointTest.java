package systems.boos.examples.microservicetemplate.acceptancetest;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.context.SpringBootTest.WebEnvironment;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.web.server.LocalServerPort;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.junit4.SpringRunner;
import systems.boos.examples.microservicetemplate.Application;

import static org.junit.Assert.assertEquals;

@RunWith(SpringRunner.class)
@SpringBootTest(webEnvironment = WebEnvironment.RANDOM_PORT, classes = Application.class)
public class ActuatorEndpointTest
{
   @LocalServerPort
   private int port;

   @Autowired
   TestRestTemplate restTemplate = new TestRestTemplate();

   HttpHeaders headers = new HttpHeaders();

   @Test
   public void test()
   {
      HttpEntity<String> entity = new HttpEntity<>(null, headers);

      ResponseEntity<String> response =
         restTemplate.exchange(createUrlWithPort("/actuator"), HttpMethod.GET, entity, String.class);

      assertEquals("wrong status code", HttpStatus.OK, response.getStatusCode());
   }

   private String createUrlWithPort(final String aUri)
   {
      return "http://localhost:" + port + aUri;
   }
}
