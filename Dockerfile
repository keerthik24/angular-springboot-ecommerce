# Stage-1: Angular Frontend
FROM node:latest as builder

WORKDIR /app

RUN npm install -g @angular/cli

COPY package*.json ./

RUN npm install

COPY . .

RUN ng build --

# Stage-2: Spring Boot Backend
FROM openjdk:17-jdk-alpine

WORKDIR /app

COPY --from=builder /app/target/<your-spring-boot-app>.jar ./app.jar

EXPOSE 5000

CMD ["java", "-jar", "app.jar"]
