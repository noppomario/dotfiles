#!/bin/bash
podman run -it --rm \
  --privileged \
  --network host \
  -v $(pwd)/setup.sh:/setup.sh \
  fedora:43 bash -c "
    bash /setup.sh
    bash
  "
