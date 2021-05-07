# HOW TO RUN DATABASE CORRECTLY

First of all, this folder is the one that will host the MySQL database 
container's info. <br>

## Running Docker's Container

To run the database, we should be on the terminal, at the same level as the 
docker-compose file inside the "db" folder. <br>
After that, we run:

``` bash
docker-compose up
```

<br>

This should create and run the MySQL container. <br>

To stop the container, we can do it manually or we can run:

``` bash
docker-compose down 
```

<br>

## Important Info

The volumes for the docker-container are specified as a relative-path. <br>
When running the docker-compose, they will be created and I am only adding
the "mysql-dump" to version control (because "binds" is added to .gitignore).
