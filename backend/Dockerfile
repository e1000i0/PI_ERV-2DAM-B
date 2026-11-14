# Etapa de compilación: Java 21 y Maven Wrapper del propio proyecto.
FROM eclipse-temurin:21.0.13_9-jdk AS build
WORKDIR /app
COPY .mvn/ .mvn/
COPY mvnw pom.xml ./
# Normaliza los finales de línea de mvnw por si el clon es de Windows (CRLF).
RUN sed -i 's/\r$//' mvnw && chmod +x mvnw && ./mvnw -B -q dependency:go-offline
COPY src/ src/
RUN ./mvnw -B -q -DskipTests package && mv target/hanger-*.jar target/app.jar

# Etapa de ejecución: solo el JRE 21 y el jar, sin privilegios de root.
FROM eclipse-temurin:21.0.13_9-jre
WORKDIR /app
RUN useradd --system --no-create-home hanger
COPY --from=build /app/target/app.jar app.jar
USER hanger
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
