#!/bin/sh
container_name="mysql"
container_id=$(docker ps -aqf "name=${^containername$}")

#explanation:
#   -q for quiet. output only the ID
#   -a for all. works even if your container is not running
#   -f for filter.
#   ^ container name must start with this string
#   $ container name must end with this string
#   docker ps -aqf "name=^containername$"

absolute_path=$(docker inspect -f '{{ .Mounts }}' ${container_id})


# List all destination in docker container !
docker ps -a --format '{{ .ID }}' | xargs -I {} docker inspect -f '{{ .Name }}{{ printf "\n" }}{{ range .Mounts }}{{ printf "\n\t" }}{{ .Type }} {{ if eq .Type "bind" }}{{ .Source }}{{ end }}{{ .Name }} => {{ .Destination }}{{ end }}{{ printf "\n" }}' {}
docker ps -a --format '{{ .ID }}' | xargs -I {} docker inspect -f '{{ .Name }}{{ printf "\n" }}{{ range .Mounts }}{{ printf "\n\t" }}{{ .Type }} {{ if eq .Type "bind" }}{{ .Source }}{{ end }}{{ .Name }} => {{ .Destination }}{{ end }}{{ printf "\n" }}' {}
docker container inspect \
 -f '{{ range .Mounts }}{{ .Name }}:{{ .Destination }} {{ end }}' \
 CONTAINER_ID_OR_NAME

 docker-compose ps -q | xargs docker container inspect  -f '{{ range .Mounts }}{{ .Name }}:{{ .Destination }} {{ end }}' 