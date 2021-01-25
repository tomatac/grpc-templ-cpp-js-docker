grpc-templ-cpp-js-docker
=======================

## A gRPC / gRPC-Web Template Project including a C++ Server and a Javascript Client using a Docker Container Development Environment with VS Code
-----------------------

This project can be used as a template to build **gRPC / gRPC-Web applications** with **C++ backend** and **javascript Web UI** within a **Docker container** using **VS Code**

This template will build an end-to-end Echo application example with 3 components:
 - Front-end JS client (using gRPC-Web)
 - C++ gRPC backend server
 - Envoy proxy (required by the gRPC-Web)

The interesting aspects of the project are:
- **Docker container development environment for gRPC**
    - Creates an easy reproducible environment.
    - Makes it easy to share a project with other developers or move the development environment to a new machine
    - Keeps the main operating system clean making it easy to work with multiple projects
    - Makes it easy to test different library versions or operating systems. Just change the Dockerfile and you can run your application in a completely new environment in minutes.

- **VS Code integration with Docker containers** 
    - It speeds up the development working with the Docker containers
    - The application is compiled and ran inside the container with full step by step debugging capabilities
    - For more information see [Working with Containers Guide and Extension](https://code.visualstudio.com/docs/containers/overview) on Microsoft website

- **Docker-Compose runtime** 
    - The 3 components of the application can be easily run with one command that start 3 docker containers

## Steps to build and test the project
### Compile the proto files for c++ and javascript applications
This must be done first
```sh
$ ./build-protos.sh 
```

### Compile the Server C++ Code
```sh
$ cd srv-cpp/build
$ cmake ..
$ make
```

### Compile the Client JavaScript Code
Compile the client side JavaScript code into something that can be consumed by the browser.

```sh
$ cd client-web
$ npm install
$ npx webpack client.js
```

`Webpack` is used to give an entry point `client.js`.  This will resolve all the `require()` statements and produce a `./dist/main.js` file that can be embedded in the `index.html` file.

## Run the example
Run the containers that make up the application:
```sh
$ docker-compose up
```

Finally, open a browser tab, and go to this page:
```
http://localhost:8081/echotest.html
```

## ACKNOWLEDGMENTS:
This template is built based on the [Google Echo application example](https://github.com/grpc/grpc-web/tree/master/net/grpc/gateway/examples/echo).

See also the [Google's quick start example for gRPC-Web](https://grpc.io/docs/platforms/web/quickstart/)



