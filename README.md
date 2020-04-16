# Project Calm

A distraction free inbox focused on considered productive conversations.

## Development

- Start your service with `docker-compose up`
- Run project test suite with `docker-compose run calm mix test`
- Start IEx session in running service # Find a container id using docker ps
  docker exec -it <container-id> bash

      # In container
      iex --sname debug --remsh app@$(hostname)
