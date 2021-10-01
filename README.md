Base environment image for Puppeteer (Headless Chrome Node API) with support for jest-puppeteer runner

This is only for testing, do not use for production since permissions are given freely inside the container

docker hub: https://hub.docker.com/repository/docker/lironavon/docker-puppeteer-container

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
     # add git access inside the container
      - uses: actions/checkout@v2
        with:
          token: ${{ secrets.GITHUB_TOKEN }}

     # cache dependencies
      - uses: actions/cache@v2
        with:
          path: '**/node_modules'
          key: ${{ runner.os }}-modules-${{ hashFiles('**/yarn.lock') }}

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
FROM docker push lironavon/docker-puppeteer-container:16.1.0

USER root

...

CMD node your-application
```

inspired by:
https://github.com/zenato/docker-puppeteer