Docker in Galaxy in Docker
==========================

Running docker in galaxy .. in docker.   (Galaxy Hackathon 2014)

Usage
-----


Interactive setup
'''
[sudo] docker run -i -t -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock -v /galaxy --name galaxy centos /bin/bash
'''

Then from within that container...
'''
yum update; yum install -y mercurial docker-io
hg clone https://bitbucket.org/galaxy/galaxy-central
'''

Need to modify job.conf such that docker destination runs docker as...
'''
docker run --volumes-from galaxy [etc]
'''
