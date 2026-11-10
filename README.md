# freeradius-exporter-image

Container image of [bvantagelimited/freeradius_exporter](https://github.com/bvantagelimited/freeradius_exporter)
(Apache-2.0), which publishes binaries but no image. The upstream source is built unchanged.

```
ghcr.io/42bitgmbh/freeradius-exporter:<upstream version>   # e.g. 0.2.0, moved on rebuilds
ghcr.io/42bitgmbh/freeradius-exporter:sha-<commit>         # one per build of this repo
```

- Version: `ARG FREERADIUS_EXPORTER_VERSION` in the `Dockerfile` (upstream git tag). Go base image pinned by digest.
- Renovate bumps both; a merge to `main` builds and pushes (`.github/workflows/build.yml`), PRs only build.
- amd64 only.

Used by the `scep-gateway` stack of the DC1 compose repo (service `freeradius-exporter`, host network, `:9812`),
against the FreeRADIUS Status-Server on `127.0.0.1:18121`:

```
freeradius_exporter -config=/conf/exporter.json -web.listen-address=:9812 -web.allowed-ips=<monitoring host>
```

The package is private like the other 42bitgmbh images; Komodo pulls it with the `ghcr` registry account.
