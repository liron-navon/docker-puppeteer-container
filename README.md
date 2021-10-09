Base environment image for Puppeteer (Headless Chrome Node API) with support for jest-puppeteer runner, if you have any issues please report it here or check [Puppeteer’s troubleshooting doc](https://github.com/puppeteer/puppeteer/blob/main/docs/troubleshooting.md)

docker hub: https://hub.docker.com/repository/docker/lironavon/docker-puppeteer-container

For versions check docker hub, or look at the git tags - each tag is a version of node.js, so for example the v16.10.0 tag uses a base of node:16.10.0-slim

## Getting started

### Use with github actions

```yml
name: Tests
on:
  push:
    branches: [ master ]
  pull_request:
    branches: [ master ]

jobs:
  build:
    runs-on: ubuntu-20.04
    container: lironavon/docker-puppeteer-container:16.10.0
    steps:
     # installl dependencies and run tests
      - name: install dependencies
        run: yarn install

      - name: test packages
        run: yarn test
```

### Start node application

```bash
docker run -i --rm --cap-add=SYS_ADMIN \
    --name puppeteer-chrome zenato/puppeteer \
    node -e "`cat yourscript.js`"
```

### Start with your docker application
Write your Dockerfile and run:

```
FROM lironavon/docker-puppeteer-container:16.1.0

USER root

# do whatever need to be done
...

CMD node your-application
```

inspired by:
https://github.com/zenato/docker-puppeteer