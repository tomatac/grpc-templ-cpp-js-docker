grpc-templ-cpp-js-docker
=======================

## A gRPC / gRPC-Web Template Project including a C++ Server and a Javascript Client using a Docker Container Development Environment with VS Code

This project can be used as a template to build **gRPC / gRPC-Web applications** with **C++ backend** and **javascript Web UI** within a **Docker container** using **VS Code**

This template will build an end-to-end Echo application example with 3 components:
 - Front-end JS client (using [gRPC-Web](https://grpc.io/docs/platforms/web/))
 - C++ [gRPC](https://grpc.io/) backend server
 - Envoy proxy ([required by the gRPC-Web](https://grpc.io/blog/state-of-grpc-web/))

The interesting aspects of the project are:
- **Docker container development environment for gRPC**
    - Creates an easy reproducible environment.
    - Makes it easy to share a project with other developers or move the development environment to a new machine
    - Keeps the main operating system clean making it easy to work with multiple projects
    - Makes it easy to test different library versions or operating systems. Just change the Dockerfile and you can run your application in a completely new environment in minutes.
    - See the [Dockerfile](https://github.com/tomatac/grpc-templ-cpp-js-docker/blob/main/.devcontainer/Dockerfile) in the current repository

- **VS Code integration with Docker containers** 
    - It speeds up the development working with the Docker containers
    - The application is compiled and ran inside the container with full step by step debugging capabilities
    - For more information see [Working with Containers Guide and Extension](https://code.visualstudio.com/docs/containers/overview) on Microsoft website
    - See the [devcontainer.json](https://github.com/tomatac/grpc-templ-cpp-js-docker/blob/main/.devcontainer/devcontainer.json) in the current repository    

- **Docker-Compose runtime** 
    - The 3 components of the application can be easily run with one command that start 3 docker containers
    - See the [docker-compose.yml](https://github.com/tomatac/grpc-templ-cpp-js-docker/blob/main/docker-compose.yml) in the current repository

## Steps to build and test the project

### Prepare your environment 
- install [Docker](https://docs.docker.com/get-docker/)
- install [VS Code](https://code.visualstudio.com/download)
- install [Remote Development VS Code extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack)
- `git clone https://github.com/tomatac/grpc-templ-docker-cmake.git`
- open the project folder in VS Code
- watch the VS Code messages on the lower right hand side of the screen. Because this project include a "*.devcontainer*" folder VS code recognize it as a container based development environment. A message should pop up asking to “*Reopen folder to develop in a container*”. Select “**Reopen in Container**”
- VS Code will reopen and start to build the container based on the *Dockerfile* from *.devcontainer* folder.
- Another message should pop up on lower right hand side of the screen giving the opportunity to **Show Log** as the container is getting built
- go to the VS Code terminal and build the application
    - note the current folder */workspaces/grpc-templ-cpp-js-docker*. This is the default [bind mount](https://docs.docker.com/storage/bind-mounts/) of the VS Code project folder into the local file system of the container. You can see here the same files as in the project folder.

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

`Webpack` is used to pack all the javascript files.  This will resolve all the `require()` statements and produce a `./dist/main.js` file that can be embedded in the `index.html` file.

## Test the application
Run the containers that make up the application:
```sh
$ docker-compose up --build
```

Open a browser tab, and go to this page:
```
http://localhost:8081/echotest.html
```
Input some data like `test` in the text box and press `Send`. Data should be displayed twice below (on the left hand side and the right hand side of the window).

Test the streaming function of the server. Input a number and some data like `5 test` in the text box and press `Send`. Data should be streamed back 5 times by the server.


## ACKNOWLEDGMENTS:
This template is built based on the [Google gRPC-Web Echo application example](https://github.com/grpc/grpc-web/tree/master/net/grpc/gateway/examples/echo).

See also the [Google's quick start example for gRPC-Web](https://grpc.io/docs/platforms/web/quickstart/)

## CONTRIBUTIONS:
I welcome comments and improvements ideas to this project.

