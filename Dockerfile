FROM maven:3.9.12-eclipse-temurin-21 AS builder

WORKDIR /app

COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

RUN chmod +x mvnw

RUN --mount=type=cache,target=/root/.m2 \
    ./mvnw dependency:go-offline -B

COPY src src

RUN --mount=type=cache,target=/root/.m2 \
    ./mvnw clean package -DskipTests

FROM eclipse-temurin:21-jre

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

RUN groupadd --system --gid 1001 spring && \
    useradd --system --uid 1001 --gid spring --create-home spring

WORKDIR /app

COPY --from=builder --chown=spring:spring /app/target/*.jar app.jar

ENV JAVA_TOOL_OPTIONS="-XX:MaxRAMPercentage=70 -XX:InitialRAMPercentage=25 -XX:+UseG1GC -XX:+ExitOnOutOfMemoryError -XX:MaxMetaspaceSize=384m -XX:+HeapDumpOnOutOfMemoryError"

EXPOSE 8080

USER spring

HEALTHCHECK --interval=30s --timeout=3s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:8080/actuator/health/readiness || exit 1

ENTRYPOINT ["java", "-jar", "app.jar"]