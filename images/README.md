## Dockerfile build

This is used for distribution of IPoIB CNI binary in a Docker image.

Typically you'd build this from the root of your IPoIB CNI clone, and you'd set the `DOCKERFILE` to specify the Dockerfile during build time, `TAG` to specify the image's tag:

```
$ DOCKERFILE=Dockerfile TAG=ipoib-cni make image
```

---

## Daemonset deployment

You may wish to deploy SR-IOV CNI as a daemonset, you can do so by starting with the example Daemonset shown here:

```
$ kubectl create -f ./images/ipoib-cni-daemonset.yaml
```

Note: The likely best practice here is to build your own image given the Dockerfile, and then push it to your preferred registry, and change the `image` fields in the Daemonset YAML to reference that image.

---

### Development notes

Example docker run command:

```
$ docker run -it -v /opt/cni/bin/:/host/opt/cni/bin/ --entrypoint=/bin/sh mellanox/ipoib-cni
```