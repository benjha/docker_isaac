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

To proxy traffic to a POD, services are needed:

https://docs.olcf.ornl.gov/services_and_applications/slate/networking/services.html

ISAAC-Server and ISAAC-Client uses two services respectively:

`isaac_server_sim_service.yaml`, is for traffic between SUMMIT and ISAAC-Server. This service is of type `NodePort` and uses a Network Policy.

The second service, `isaac_server_webserver_service.yaml`, is used by ISAAC-Client and proxies traffic for HTTPS and Websockets. This services uses a Route.

Type

```
oc create -f isaac_server_sim_service.yaml
oc create -f isaac_server_webserver_service.yaml
```

to create these services.


- Create a Network Policy for `isaac_server_sim_service.yaml` Service

A network policy allows communication between PODs and other OLCF network points, in this case, Summit:

https://docs.olcf.ornl.gov/services_and_applications/slate/networking/networkpolicy.html

The network policy for `isaac_server_sim_service.yaml` is defined in `isaac_server_sim_net_policy.yml`. To initialize it, type:

```
oc create -f isaac_server_sim_net_policy.yml
```

- Create a Route for `isaac_server_webserver_service.yaml` Server

The `isaac_server_webserver_service.yaml` service uses a Route: 

https://docs.olcf.ornl.gov/services_and_applications/slate/networking/route.html

to expose HTTPS and Websockets communications to the outside world. Type

```
oc create -f isaac_server_webserver_route.yaml
```

to expose HTTPS communications  and

```
oc create -f isaac_server_websockets_route.yaml
```

to expose Websockets communicatios.



