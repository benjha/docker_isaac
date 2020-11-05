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

type

```
$oc new-build https://github.com/benjha/docker_isaac
    
```

then

```
oc start-build dockerisaac --follow
```

to verify available images, type

```
oc get imagestream
```

then you will get

```
NAME           IMAGE REPOSITORY                                        TAGS      UPDATED
centos         registry.apps.marble.ccs.ornl.gov/csc434/centos         centos7   19 minutes ago
dockerisaac    registry.apps.marble.ccs.ornl.gov/csc434/dockerisaac    latest    2 minutes ago
iperf3docker   registry.apps.marble.ccs.ornl.gov/csc434/iperf3docker   latest    8 days ago
ubuntu         registry.apps.marble.ccs.ornl.gov/csc434/ubuntu         18.04     8 days ago
``` 

- Create a deployment

https://docs.olcf.ornl.gov/services_and_applications/slate/workloads/deployment.html


