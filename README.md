# runtime-env-var-frontend

This project contains a PoC based on [link (redhat.com)](https://developers.redhat.com/blog/making-environment-variables-accessible-in-front-end-containers#).

It makes it possible to inject environment variables during runtime to a frontend project (in our case Vite+React)

This implementation is agnostic regarding orchestration technology - especially useful for k8s, Nomad, ECS and other orchestrators

# Usage (docker)

```bash
docker build -t runtime-env-var-frontend .
docker run -p 8080:80 --rm -e ENV=FOOOOO -e API_URL=BAAAAAR runtime-env-var-frontend
```

# What about local work?
Feel free to modify the values in `./src/config.json`, they will be reset to `$...` in build-time .

# What is the difference between build-time and run-time?
Build time is what happens during the *build* of the container image, so for example `docker build...` or whatever your CI does.
Note, that in the case of a frontend SPA after building you get some js and css files.

Run time is what happens after you *run* your container image. For example using `docker run...` or by starting a pod in k8s.

