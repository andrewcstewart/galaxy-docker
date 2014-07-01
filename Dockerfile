# Galaxy
#   forked from bgruening/galaxy-stable
# VERSION       0.1

FROM centos

MAINTAINER Andrew Stewart, andrew.c.stewart@gmail.com

# add epel and make sure the package repository is up to date
RUN rpm -iUvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum update -y

# Install and run docker client
RUN yum install -y docker-io
# RUN service docker start
# RUN chkconfig docker on


# Install all requirements that are recommend by the Galaxy project
RUN yum install -y mercurial
# RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y autoconf
# RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y automake
# RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y build-essential
# RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y gfortran
# RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y cmake
# RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y git-core
# RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y libatlas-base-dev
# RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y libblas-dev
# RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y liblapack-dev
# RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y mercurial
# RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y subversion
# RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y python-dev
# RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y pkg-config
# RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y openjdk-7-jre
# RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y python-setuptools

# Download and update Galaxy to the latest stable release
RUN hg clone https://bitbucket.org/galaxy/galaxy-central/
WORKDIR /galaxy-central
# RUN hg pull
# RUN hg update latest_2014.06.02

# Configure Galaxy to use the Tool Shed
RUN mkdir /shed_tools
RUN mkdir /galaxy-central/tool_deps

# Initialize and make modifications to universe_wsgi.ini
RUN cp /galaxy-central/universe_wsgi.ini.sample /galaxy-central/universe_wsgi.ini
RUN sed -i 's|#admin_users = None|admin_users = admin@galaxy.org|g' /galaxy-central/universe_wsgi.ini
RUN sed -i 's|#host = 127.0.0.1|host = 0.0.0.0|g' /galaxy-central/universe_wsgi.ini
RUN sed -i 's|#port = 8080|port = 8080|g' /galaxy-central/universe_wsgi.ini
# RUN sed -i 's|#tool_config_file|tool_config_file|g' /galaxy-central/universe_wsgi.ini
# RUN sed -i 's|#tool_path|tool_path|g' /galaxy-central/universe_wsgi.ini
RUN sed -i 's|#brand = None|brand = Galaxy Docker Build|g' /galaxy-central/universe_wsgi.ini

# Fetching all Galaxy python dependencies
RUN python /galaxy-central/scripts/fetch_eggs.py


# Include all needed files from the host
ADD ./misc/job_conf.xml /galaxy-central/job_conf.xml
ADD ./misc/welcome.html /galaxy-central/static/welcome.html
ADD ./misc/tool_conf.xml /galaxy-central/tool_conf.xml
RUN mkdir /galaxy-central/tools/docker
ADD ./misc/docker_test.xml /galaxy-central/tools/docker/docker_test.xml

# Designated mounted volumes
VOLUME ["/galaxy-central/"]

# Expose port 80 to the host
EXPOSE :8080

# Autostart script that is invoked during container start
CMD ["./run.sh"]
