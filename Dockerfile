FROM eclipse-temurin:17-jdk-jammy AS build
COPY . .
RUN chmod +x gradlew
RUN ./gradlew build -x test

FROM eclipse-temurin:17-jdk-jammy
COPY --from=build /build/libs/*.jar app.jar
ENV SPRING_PROFILES_ACTIVE=dev
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
