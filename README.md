Docker in Galaxy in Docker
==========================

Running docker in galaxy .. in docker.   (Galaxy Hackathon 2014)

Usage
-----


Interactive setup
```
[sudo] docker run -d -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock -v /galaxy --name galaxy centos
```

Then point your browser at http://localhost:8080.
