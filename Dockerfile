# Two stage build
# 1) build stage: compile the jar
# 2) create the final container
#
# Idea adopted from:
# https://vuejs.org/v2/cookbook/dockerize-vuejs-app.html

# build stage
FROM maven:3-jdk-11 as build-stage
WORKDIR /app
COPY . .
RUN mvn -pl core package -DskipTests=true

# production stage
# Adopted from https://spring.io/guides/gs/spring-boot-docker/
FROM adoptopenjdk/openjdk11:alpine
VOLUME /tmp
RUN mkdir /opt/app
COPY --from=build-stage /app/core/target/kdb-stationservice-exec.jar /opt/app/app.jar
EXPOSE 8080
ENTRYPOINT ["java","-Xms32m","-Xmx256m","-Djava.security.egd=file:/dev/./urandom","-jar","/opt/app/app.jar"]
