# dlsyscourse-homework
Repo for https://dlsyscourse.org assignments

Usage:

Create my.env file in this folder and put MUGRADER_GRADE_KEY=<YOUR_KEY> in it.
Then build and run jupyter server with `just build` and `just start` commands, and you're good to go - you can use VS Code to attach to the jupyter server hosted in docker container.

TODO:
Set up a [devcontainer](https://containers.dev/implementors/json_reference/) so you could build your C++ code inside docker container using VS Code. See:
- https://code.visualstudio.com/docs/remote/containers
- https://code.visualstudio.com/docs/remote/containers#_create-a-devcontainerjson-file