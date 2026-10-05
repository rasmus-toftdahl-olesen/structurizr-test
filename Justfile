user_id := shell("id -u")

local:
    docker run --user 0:{{ user_id }} -it --rm -p 8080:8080 -v {{ justfile_directory() }}/local-data:/usr/local/structurizr -v {{ justfile_directory() }}/structurizr.properties:/usr/local/structurizr/structurizr.properties structurizr/structurizr local

export:
    docker run --user 0:{{ user_id }} -it --rm -v {{ justfile_directory() }}/local-data:/usr/local/structurizr -v {{ justfile_directory() }}/structurizr.properties:/usr/local/structurizr/structurizr.properties structurizr/structurizr export -w 2-rso/workspace.dsl -o export/static -f static
