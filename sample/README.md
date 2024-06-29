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

And you can start flutter build via:
```sh
docker compose up
```

Additionally you can request a dirty build (without `flutter clean`) and
local build (using volume mounted at `/root/repo` instead of Git).

Container will exit when build is completed or failed.

Remember to keep your build script and tools updated:
* Check if you need to migrate build scripts: https://docs.flutter.dev/release/breaking-changes/flutter-gradle-plugin-apply
* For `gradle_build_tools_version` see: https://mvnrepository.com/artifact/com.android.tools.build/gradle?repo=google
* For gradle wrapper see: https://services.gradle.org/distributions/
