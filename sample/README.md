# Sample builder

Sample Flutter builder based on `zekfad/flutter-builder`.

In this example container will pull/clone repository from Git repo via SSH.
You should place your key at `./ssh_key`, or change volume in compose file.

Add corresponding public key to your Deploy keys in repository settings
and edit `docker-compose.yaml` to use your repo URI, branch or commit SHA
if needed.

To build the image use:

```sh
docker compose build
```

And you can start build via:
```sh
docker compose up
```

Container will exit when build is completed or failed.
