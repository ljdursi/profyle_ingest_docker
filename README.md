# ga4gh_directory

This is a simple docker for starting up a GA4GH server which serves access to test PROFYLE metadata.

Example:

```
docker pull quay.io/ljdursi/profyle_ingest_docker
# Using default tag: latest
# latest: Pulling from ljdursi/profyle_ingest_docker
#
# 70039e55cb: Pulling fs layer
# d7169c87d8: Pulling fs layer
# 3d2e473703: Pulling fs layer
# d4cd57d159: Pulling fs layer
# 8febf8a6d3: Pulling fs layer
# ed95caeb02: Pulling fs layer
# 7f9efcbf4f: Pulling fs layer
# 501ec70e54: Pulling fs layer
# 3a53f5c279: Pulling fs layer
# Digest:bsha256:b5033d7c29e6b99d97b024e85c6d1ac9457ead55fc4905255d1d9ea128173ccb.007kB/1.007kBB
# status: Downloaded newer image for quay.io/ljdursi/profyle_ingest_docker:latest

mkdir test-docker

cd test-docker

git clone git@github.com:PROFYLE-TFRI/metadata.git
# Cloning into 'metadata'...
# remote: Counting objects: 390, done.K
# remote: Total 390:(delta(0),/reused 0 (delta 0), pack-reused 390K
# Receiving objects: 100% (390/390), 47.40 KiB | 0 bytes/s, done.
# Resolving deltas: 100% (132/132), done.

mkdir outdir

ls
# metadata	outdir

docker run -v /tmp/test-docker/metadata/root_folder_example:/profyle_dir \
           -v /tmp/test-docker/outdir:/ga4gh_dir \
           quay.io/ljdursi/profyle_ingest_docker init /profyle_dir /ga4gh_dir
# PRO-00001A
# PRO-00002B
# PRO-00003C
# PRO-00012N
# PRO-00013P
# PRO-00015S
# PRO-00016T
# PRO-00017U
# PRO-00019W
# PRO-000BC1
# PRO-000BC2
# Verifying Dataset PROFYLE

docker run -v /tmp/test-docker/outdir:/ga4gh_dir -p 8000:8000 quay.io/ljdursi/profyle_ingest_docker serve /ga4gh_dir
#  * Running on http://0.0.0.0:8000/ (Press CTRL+C to quit)
#  * Restarting with stat
#  * Debugger is active!
#  * Debugger pin code: 818-054-806
```

And then, from another terminal:
```
curl -X POST --header 'Content-Type: application/json' --header 'Accept: application/json' \
    http://localhost:8000/datasets/search \
    | jq '.'
#   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
#                                  Dload  Upload   Total   Spent    Left  Speed
# 100   100  100   100    0     0  11150      0 --:--:-- --:--:-- --:--:-- 12500
# {
#   "datasets": [
#     {
#       "description": "PROFYLE test metadata",
#       "id": "WyJQUk9GWUxFIl0",
#       "name": "PROFYLE"
#     }
#   ]
# }
```
