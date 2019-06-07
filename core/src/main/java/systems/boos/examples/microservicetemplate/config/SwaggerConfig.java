package systems.boos.examples.microservicetemplate.config;

import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

@Configuration
@EnableSwagger2
@EnableAutoConfiguration
public class SwaggerConfig {
   @Bean
   public Docket api() {
      return new Docket(DocumentationType.SWAGGER_2)
         .select()
         .apis(RequestHandlerSelectors.any())
         .paths(PathSelectors.any())
         .build()
         .apiInfo(apiInfo());
   }

   private ApiInfo apiInfo() {
      ApiInfo apiInfo = new ApiInfo(
         "Microservice Template",
         "Template project from which new microservices are generated.",
         "0.0.1",
         "https://wonderbird.github.io",
         "Stefan Boos <kontakt@boos.systems>",
         "Private license. Please request a quote.",
         "https://wonderbird.github.io"
      );
      return apiInfo;
   }
}