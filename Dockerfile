FROM debian:latest AS build
RUN apt-get update && apt-get install -y openjdk-17-jdk
COPY . .
RUN ./gradlew build -x test

FROM openjdk:17-jdk-slim
COPY --from=build /build/libs/*.jar app.jar
ENV SPRING_PROFILES_ACTIVE=dev
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
