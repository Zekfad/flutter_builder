# Sample builder

Sample Flutter builder based on `zekfad/flutter-builder`.

This sample show how can you use this image to build Android APK from private
git repository by pulling it via SSH (with key) and building via Flutter SDK.

In this example we use `SSH key` that should be located in build folder
under name of `ssh_key`.

Add corresponding public key to your Deploy keys and edit `docker-compose.yaml`
to use your repo URI.

To build the image use:

```sh
docker compose build
```

And you can start build via:
```sh
docker compose up
```

Container will exit when build is completed or failed.
