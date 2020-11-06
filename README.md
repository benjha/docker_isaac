# ISAAC-Server on SLATE

- ISAAC

https://github.com/ComputationalRadiationPhysics/isaac


- OLCF's SLATE

https://docs.olcf.ornl.gov/services_and_applications/slate/overview.html#what-is-slate
 

## Getting Started on SLATE

- Request a Slate project allocation. Every GEN, DD, ALCC and INCITE project can request an allocation
in Slate:

https://docs.olcf.ornl.gov/services_and_applications/slate/getting_started.html#requesting-a-slate-project-allocation

- Logging-in and swapping projects

https://docs.olcf.ornl.gov/services_and_applications/slate/getting_started.html#logging-in

- You can track changes using SLATE GUI available in

https://console-openshift-console.apps.marble.ccs.ornl.gov/


## Instructions

- Create a Docker recipe and host it in a repository. 

https://github.com/benjha/docker_isaac/blob/main/Dockerfile

- Login to Slate's Marble and activate CSC434 project

```
oc login https://api.marble.ccs.ornl.gov
oc project csc434
```

- Build the Docker Image

https://docs.olcf.ornl.gov/services_and_applications/slate/image_building.html#build-types

```
oc new-build https://github.com/benjha/docker_isaac 
```

to verify available images, type

```
oc get imagestream
```

this is a sample of the output

```
NAME           IMAGE REPOSITORY                                        TAGS      UPDATED
centos         registry.apps.marble.ccs.ornl.gov/csc434/centos         centos7   19 minutes ago
dockerisaac    registry.apps.marble.ccs.ornl.gov/csc434/dockerisaac    latest    2 minutes ago
iperf3docker   registry.apps.marble.ccs.ornl.gov/csc434/iperf3docker   latest    8 days ago
ubuntu         registry.apps.marble.ccs.ornl.gov/csc434/ubuntu         18.04     8 days ago
``` 

- Create a Deployment

https://docs.olcf.ornl.gov/services_and_applications/slate/workloads/deployment.html

Create the Deployment YAML specification, then customized as need it, e.g. configuring cpu and memory limits, exposing ports, mounting ALPINE, etc.

```
oc create deployment isaac-server --image image-registry.openshift-image-registry.svc:5000/csc434/dockerisaac --dry-run -o yaml > issac_server_deployment.yaml
```

a note about mounting ALPINE

https://docs.olcf.ornl.gov/services_and_applications/slate/access_olcf_resources/mount_fs.html


create the deployment from your YAML configuration

```
oc create -f isaac_server_deployment.yaml
```

After creating a deployment, a POD will be spawned. 

- Create a Service

The next step is to open POD comunications so it can handle incoming/outgoing messages between SUMMIT and between the outside world.

ISAAC-Server will use a service:

https://docs.olcf.ornl.gov/services_and_applications/slate/networking/services.html

to allow communication between SUMMIT and ISAAC-Server, and between ISAAC-Server and ISAAC-Client. `isaac_server.yaml' provides service configuration 



- Create Network Policies

communications are enabled by NodePorts:

https://docs.olcf.ornl.gov/services_and_applications/slate/networking/nodeport.html#slate-nodeports
  
and ISAAC Server - ISAAC Client communications are enabled by Routes:

https://docs.olcf.ornl.gov/services_and_applications/slate/networking/route.html

