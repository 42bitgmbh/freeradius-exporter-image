# syntax=docker/dockerfile:1.12
# Container image of bvantagelimited/freeradius_exporter, which publishes binaries but no image. Builds the upstream
# tag below unchanged; the image tag on ghcr.io is that version. Renovate bumps both pins.

# renovate: datasource=github-tags depName=bvantagelimited/freeradius_exporter
ARG FREERADIUS_EXPORTER_VERSION=0.2.0

FROM golang:1.26.10-alpine@sha256:87c65a688975c0b1d4585d204874c45ca78354670e3a5f11368c5a492303d696 AS build
ARG FREERADIUS_EXPORTER_VERSION
ADD --keep-git-dir=false https://github.com/bvantagelimited/freeradius_exporter.git#${FREERADIUS_EXPORTER_VERSION} /build
WORKDIR /build
RUN go mod download && CGO_ENABLED=0 go build -trimpath -ldflags "-s -w" -o /freeradius_exporter .

FROM scratch
ARG FREERADIUS_EXPORTER_VERSION
LABEL org.opencontainers.image.title="freeradius_exporter" \
      org.opencontainers.image.version="${FREERADIUS_EXPORTER_VERSION}" \
      org.opencontainers.image.licenses="Apache-2.0" \
      org.opencontainers.image.source="https://github.com/42bitgmbh/freeradius-exporter-image" \
      org.opencontainers.image.description="bvantagelimited/freeradius_exporter ${FREERADIUS_EXPORTER_VERSION}, unchanged"
COPY --from=build /freeradius_exporter /freeradius_exporter
USER 65534:65534
EXPOSE 9812
ENTRYPOINT ["/freeradius_exporter"]
