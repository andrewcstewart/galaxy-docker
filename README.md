Docker in Galaxy in Docker
==========================

Running docker in galaxy .. in docker.   (Galaxy Hackathon 2014)

Usage
-----


Interactive setup
```
[sudo] docker build . -t "galaxy-docker"
[sudo] docker run -d -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock -v /galaxy --name galaxy galaxy-docker
```

or just grab the docker image from hub.docker.io
```
[sudo] docker run -d -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock -v /galaxy --name galaxy andrewcstewart/galaxy-docker
```

Then point your browser at http://localhost:8080.


Acknowledgements
----------------
This code is based on the prior work of John Chilton (https://bitbucket.org/jmchilton) and Björn Grüning (https://github.com/bgruening)...

 * https://github.com/bgruening/docker-recipes
 * https://bitbucket.org/galaxy/galaxy-central/pull-request/401/allow-tools-and-deployers-to-specify/diff
