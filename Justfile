user_id := shell("id -u")

local:
    docker run --user 0:{{ user_id }} -it --rm -p 8080:8080 -v {{ justfile_directory() }}/local-data:/usr/local/structurizr -v {{ justfile_directory() }}/structurizr.properties:/usr/local/structurizr/structurizr.properties structurizr/structurizr local

export:
    docker run --user 0:{{ user_id }} --rm -v {{ justfile_directory() }}/local-data:/usr/local/structurizr -v {{ justfile_directory() }}/structurizr.properties:/usr/local/structurizr/structurizr.properties structurizr/structurizr export -w 2-rso/workspace.dsl -o export/static -f static

validate-github-actions:
    python3 -c 'from pathlib import Path; import yaml; files = sorted((*Path(".github").rglob("*.yml"), *Path(".github").rglob("*.yaml"))); assert files, "No YAML files found under .github"; [yaml.load(path.read_text(), Loader=yaml.BaseLoader) for path in files]; print(f"Validated {len(files)} GitHub Actions YAML file(s).")'
