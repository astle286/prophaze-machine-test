
FROM maven:3.9.11-eclipse-temurin-21 AS builder

WORKDIR /app


COPY pom.xml .

RUN mvn dependency:go-offline


COPY src ./src


RUN mvn clean package -DskipTests


FROM eclipse-temurin:21-jre

RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -m spring

WORKDIR /app

COPY --from=builder /app/target/*.jar app.jar


RUN chown -R spring:spring /app

USER spring

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=5s --start-period=30s \
CMD curl --fail http://localhost:8080/actuator/health || exit 1

ENTRYPOINT ["java","-jar","app.jar"]