#!/bin/bash
set -ex

cd generator
./generate_secrets.sh all `./generate_secrets.sh fsid` "$@"

mkdir secrets
kubectl create namespace ceph --dry-run -o yaml > secrets/namespace-ceph.yaml
kubectl create secret generic ceph-conf-combined --from-file=ceph.conf --from-file=ceph.client.admin.keyring --from-file=ceph.mon.keyring \
    --namespace=ceph --dry-run -o yaml > secrets/secret-ceph-conf-combined.yaml
kubectl create secret generic ceph-bootstrap-rgw-keyring --from-file=ceph.keyring=ceph.rgw.keyring --namespace=ceph --dry-run -o yaml > secrets/secret-ceph-bootstrap-rgw-keyring.yaml
kubectl create secret generic ceph-bootstrap-mds-keyring --from-file=ceph.keyring=ceph.mds.keyring --namespace=ceph --dry-run -o yaml > secrets/secret-ceph-bootstrap-mds-keyring.yaml
kubectl create secret generic ceph-bootstrap-osd-keyring --from-file=ceph.keyring=ceph.osd.keyring --namespace=ceph --dry-run -o yaml > secrets/secret-ceph-bootstrap-osd-keyring.yaml
kubectl create secret generic ceph-bootstrap-rbd-keyring --from-file=ceph.keyring=ceph.rbd.keyring --namespace=ceph --dry-run -o yaml > secrets/secret-ceph-bootstrap-rbd-keyring.yaml
kubectl create secret generic ceph-client-key --from-file=ceph-client-key --namespace=ceph --dry-run -o yaml > secrets/secret-ceph-client-key.yaml
kubectl create secret generic ceph-secret-admin --from-file=ceph-client-key --type=kubernetes.io/rbd --namespace=ceph --dry-run -o yaml > secrets/secret-ceph-secret-admin.yaml

cd ..
