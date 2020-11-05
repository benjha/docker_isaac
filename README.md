# ISAAC server on SLATE

- ISAAC

https://github.com/ComputationalRadiationPhysics/isaac


- OLCF's SLATE

https://docs.olcf.ornl.gov/services_and_applications/slate/overview.html#what-is-slate
 

## Getting Started on Slate

- Request a Slate project allocation. Every GEN, DD, ALCC and INCITE project can request an allocation
in Slate:

https://docs.olcf.ornl.gov/services_and_applications/slate/getting_started.html#requesting-a-slate-project-allocation

- Logging in and swapping projects

https://docs.olcf.ornl.gov/services_and_applications/slate/getting_started.html#logging-in


## Instructions

- Create a Docker recipe and host it in a repository. 

https://github.com/benjha/docker_isaac/blob/main/Dockerfile

- Login to Slate's Marble and activate CSC434 project

```
oc login https://api.marble.ccs.ornl.gov
oc project csc434
```

