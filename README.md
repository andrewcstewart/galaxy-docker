Docker in Galaxy in Docker
==========================

Running docker in galaxy .. in docker.   (Galaxy Hackathon 2014)


The purpose of this repository is just to document and demosntrate the proces of configuring a Galaxy container in Docker that can run jobs in separate Docker containers.  For the priamry "Galaxy and Docker" code base see https://github.com/bgruening/docker-recipes



Install
-------

First you need Docker.  https://docs.docker.com/installation/

If you're on Mac, there are 'official' instructions at https://docs.docker.com/installation/mac/ but there is also https://github.com/noplay/docker-osx which as the added benefit of port mapping between OS X and the VM running Docker (so Galaxy ends up getting served at http://locakdocker:8080/


Usage
-----

Interactive setup
```
[sudo] docker build . -t "galaxy-docker"
[sudo] docker run -d -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock -v /galaxy --name galaxy galaxy-docker
```

Or just grab the docker image from hub.docker.io
```
[sudo] docker run -d -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock -v /galaxy --name galaxy andrewcstewart/galaxy-docker
```

Or you can try using fig (http://orchardup.github.io/)
```
fig up
```


Then point your browser at http://localhost:8080/


Acknowledgements
----------------
This code is based on the prior work of John Chilton (https://bitbucket.org/jmchilton) and Björn Grüning (https://github.com/bgruening)...

 * https://github.com/bgruening/docker-recipes
 * https://bitbucket.org/galaxy/galaxy-central/pull-request/401/allow-tools-and-deployers-to-specify/diff
