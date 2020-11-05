# ISAAC server on SLATE

- ISAAC

https://github.com/ComputationalRadiationPhysics/isaac


- OLCF's SLATE

https://docs.olcf.ornl.gov/services_and_applications/slate/overview.html#what-is-slate
 

## Getting Started on Slate

- Request a Slate project allocation. Every GEN, DD, ALCC and INCITE project can request an allocation
in Slate:

https://docs.olcf.ornl.gov/services_and_applications/slate/getting_started.html#requesting-a-slate-project-allocation

- Logging-in and swapping projects

https://docs.olcf.ornl.gov/services_and_applications/slate/getting_started.html#logging-in


## Instructions

- Create a Docker recipe and host it in a repository. 

https://github.com/benjha/docker_isaac/blob/main/Dockerfile

- Login to Slate's Marble and activate CSC434 project

```
oc login https://api.marble.ccs.ornl.gov
oc project csc434
```

- Build the Docker image

https://docs.olcf.ornl.gov/services_and_applications/slate/image_building.html#build-types

```
$oc new-build https://github.com/benjha/docker_isaac

--> Found Docker image 7e6257c (2 months old) from Docker Hub for "centos:centos7"

    * An image stream tag will be created as "centos:centos7" that will track the source image
    * A Docker build using source code from https://github.com/benjha/docker_isaac will be created
      * The resulting image will be pushed to image stream tag "dockerisaac:latest"
      * Every time "centos:centos7" changes a new build will be triggered

--> Creating resources with label build=dockerisaac ...
    imagestream.image.openshift.io "centos" created
    imagestream.image.openshift.io "dockerisaac" created
    buildconfig.build.openshift.io "dockerisaac" created
--> Success
``` 
