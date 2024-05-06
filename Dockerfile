# Stage-1: Angular Frontend
FROM node:latest
WORKDIR /app
RUN npm install -g @angular/cli
COPY package*.json ./
RUN npm install
COPY . .
RUN ng build --
EXPOSE 5000
CMD ["ng", "server", "--host", "0.0.0.0", "--port", "5000", "--disable-host-check"]

# Stage-2: Spring Boot Backend
FROM openjdk:17-jdk-apline
WORKDIR /app
COPY --from=builder /app/target/<your-spring-boot-app>.jar ./app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
