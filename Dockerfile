FROM maven:3.8.5-openjdk-17 AS builder

COPY src src

COPY pom.xml pom.xml

RUN mvn clean package

FROM ubi8/openjdk-17-runtime:1.19-1

ARG PACKAGE=tekton-pipeline-java-demo-0.0.1-SNAPSHOT.jar

COPY --from=builder target/${PACKAGE} app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
