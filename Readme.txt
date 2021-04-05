#######################
#                     #
# Docker Deploy Steps #
#                     #
#######################

1-First time we need to create a custom network named "rmadridbasket":
	$ docker network create rmadridbasket

  That will be the network used by the containers for comunicate with the mysql server

2-Create and run the mysql server:

	$ docker-compose up

  This command will take the configuration of the docker-compose.yml file for create a new mysql server with a database named "rmadridbasket"

3-Create the database schema (create tables):
  In the one of the projects (rmadrid-basket-es or rmadrid-basket-es-admin) configure in the application.properties:

	spring.datasource.url = jdbc:mysql://localhost:3308/rmadridbasket?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC
	spring.jpa.hibernate.ddl-auto = update

  Compile the project from terminal

	$ mvn spring-boot:run

  This point must be done each time we want to create a new table or alter an existing one.

4-Execute the database migrations (inserts, updates...)
  In the one of the projects (rmadrid-basket-es or rmadrid-basket-es-admin) configure in the application.properties:

	spring.flyway.enabled=true

  Compile the project from terminal

        $ mvn spring-boot:run

  This point must be done each time we want to execute a new migration script

5-Deploy Project
  Go to the project root directory and execute:
	$ mvn clean package
	$ docker build -t rmadridbasket-admin/alpine-server:1.0 .
	$ docker run -it --name rmadridbasket-admin --network rmadridbasket -p 127.0.0.1:8080:8080 rmadridbasket-admin/alpine-server:1.0 /bin/sh

