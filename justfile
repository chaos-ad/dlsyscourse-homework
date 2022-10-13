env_file := 'my.env'
jupyter_port := '10005'
jupyter_token := 'mysecret'
docker_image_name := 'dlsyscourse:dev'
docker_instance_name := 'dlsyscourse'

##############################################################################

build:
    docker build \
        --rm \
        --pull \
        --network host \
        --build-arg USER=$(id -un) \
        --build-arg UID="$(id -u)" \
        --build-arg GID="$(id -g)" \
        -f Dockerfile \
        -t {{docker_image_name}} \
        .

run command:
    docker run --rm -it \
        --network host \
        -v "${PWD}/hw0:/home/$(id -un)/code/dlsyscourse-homework/hw0" \
        -v "${PWD}/hw1:/home/$(id -un)/code/dlsyscourse-homework/hw1" \
        --env-file {{env_file}} \
        --name {{docker_instance_name}} \
        {{docker_image_name}} \
        {{command}}

shell: (run '/bin/bash')

start:
    docker run -d \
        --network host \
        -v "${PWD}/hw0:/home/$(id -un)/code/dlsyscourse-homework/hw0" \
        -v "${PWD}/hw1:/home/$(id -un)/code/dlsyscourse-homework/hw1" \
        --env-file {{env_file}} \
        --name {{docker_instance_name}} \
        {{docker_image_name}} \
        jupyter notebook \
            --allow-root \
            --ip=0.0.0.0 \
            --port={{jupyter_port}} \
            --NotebookApp.token='{{jupyter_token}}' \
            --NotebookApp.password='{{jupyter_token}}' \
    && echo -e "Jupyter container started, you can access it using:\n\
        \thttp://localhost:{{jupyter_port}}/?token={{jupyter_token}} - from VS Code\n \
        \thttp://localhost:{{jupyter_port}}/lab?token={{jupyter_token}} - from Web"

exec command:
    docker exec -it {{docker_instance_name}} {{command}}

attach: (exec '/bin/bash')

stats:
    docker stats {{docker_instance_name}}

pause:
    docker stop {{docker_instance_name}}

resume:
    docker start {{docker_instance_name}}

restart:
    docker restart {{docker_instance_name}}

stop:
    docker rm --force {{docker_instance_name}}

##############################################################################
