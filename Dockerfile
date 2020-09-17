FROM openjdk:8-jdk-alpine

COPY target/spring-boot-simple.jar /app.jar

RUN wget -O /apm-agent.jar https://search.maven.org/remotecontent?filepath=co/elastic/apm/elastic-apm-agent/1.8.0/elastic-apm-agent-1.8.0.jar

CMD java -jar /app.jar
