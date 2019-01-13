# Weave Scope for PKS

## What?

```
./get-weave-scope-for-pks.sh | kubectl apply -f -
```

This will:
- download the spec from `cloud.weave.works` [as documented][weave-docs]
- patch them with the above mentioned changes
- apply those to your currently targeted cluster

To patch the upstream specs the [bosh cli][bosh-cli] will be used, specifically
the `interpolate` command with [an `ops-file`][ops-file] holding the patches.

**Note:**

Keep in mind to enable priviliged containers in OpsManager.

## Why?

For PKS deployed clusters some things in the specs provided by weave need to be
changed. Currently those changes are:
- docker's socket is in `/var/vcap/sys/run/docker/docker.sock`
- weave net integration is specificaly disabled, as PKS comes with either NSX-T or flannel

## Others solutions tested:

### kustomize

While [`kustomize`][kustomize] looks interesting, esp. because it will be integrated in `kubectl` directly, I ran into som issues:

- `kustomize` cannot use a URL that does not point to a git rope as a *base*
- `kustomize` can only patch `Kind: List` specs (that's what we get from weave) with JSON patches
- JSON patch doe not work well for replacing with arrays of objects

### tbc (maybe)

- ...

[bosh-cli]: https://bosh.io/docs/cli-v2/
[ops-file]: https://bosh.io/docs/cli-ops-files/
[kustomize]: https://kustomize.io
[weave-docs]: https://www.weave.works/docs/scope/latest/installing/#k8s