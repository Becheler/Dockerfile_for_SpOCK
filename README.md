# Dockerfile_for_SpOCK

Getting SpOCK working in a Docker image for a cross-platform reproducible environment.

* You will need to [get Docker](https://docs.docker.com/get-docker/) first. 
* The current image:
    * has a size of 1.83 GB (around 8x lighter than a full Ubuntu distribution)
    * takes less than 10 minutes to build from scratch
    * takes less than 1 minute to download from DockerHub.

### Downloading the pre-built image from DockerHub

This will save you the time of building the image from scratch everytime (see following section).

```bash
docker pull docker push arnaudbecheler/spock-container:latest
```
To see what images are present locally, use the `docker images` command.

### Launching the container

To launch an **interactive terminal** (option `-it`) of the newly created image, use the `docker run` command:
```bash
docker run -ti anaudbecheler/spock-container /bin/bash
```

### Building the Docker image on your local system using the repo Dockerfile

That is useful to test modifications of the Dockerfile, or visualize what is actually happening when the image is built.
It is a bit longer than pulling the pre-built image from DockerHub (it will take around 5mn).

```bash
git clone Becheler/Dockerfile_for_SpOCK
cd Dockerfile_for_SpOCK
docker build -t spock-image .
docker images
```

### Converting Docker Images to Singularity for Use on NASA Pleiades

For security reasons, Docker containers are not supported on Pleiades, but you can [convert them 
to Singularity containers](https://www.nas.nasa.gov/hecc/support/kb/converting-docker-images-to-singularity-for-use-on-pleiades_643.html).

On a Pleiades front-end system (PFE), do the following to create a singularity image or a singularity sandbox:

```bash
pfe$ module load singularity
pfe% singularity pull lolcow.sif docker://godlovedc/lolcow
# or
pfe$ singularity build --sandbox lolcow docker://godlovedc/lolcow
```
