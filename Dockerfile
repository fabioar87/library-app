FROM amazoncorretto:17-alpine

ENV APP_HOME=/app

WORKDIR $APP_HOME

COPY target/library-app-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8081

ENTRYPOINT ["java", "-jar", "app.jar"]