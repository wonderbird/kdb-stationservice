package systems.boos.examples.microservicetemplate;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * Entry point of the Spring Boot MVC application.
 */
@SpringBootApplication
public class Application
{

   /**
    * Entry point of the Spring Boot MVC application.
    * @param args command line arguments
    */
   public static void main(final String[] args)
   {
      SpringApplication.run(Application.class, args);
   }

}
