# ga4gh_directory

This is a simple docker for starting up a GA4GH server which serves access to test PROFYLE metadata.

Example:

```
$ docker pull quay.io/ljdursi/profyle_ingest_docker
$ mkdir test-docker
$ cd test-docker
$ git clone git@github.com:PROFYLE-TFRI/metadata.git
$ mkdir outdir
$ docker -run -v "${PWD}/metadata/root_folder_example":/profyle_dir \
    -v "${PWD}/outdir":/ga4gh_dir init /profyle_dir /ga4gh_dir
$ docker run -v "${PWD}/outdir":/ga4gh_dir -p 8000:8000 \
    profyle_ingest_docker serve /ga4gh_dir
```

And then, from another terminal:
```
$ curl -X POST --header 'Content-Type: application/json' --header 'Accept: application/json' \
    http://localhost:8000/datasets/search
{"datasets": [{"description": "PROFYLE test metadata", "id": "WyJQUk9GWUxFIl0", "name": "PROFYLE"}]}
```
