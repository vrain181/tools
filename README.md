tools
===

[![Automated](https://img.shields.io/docker/automated/salvax86/tools.svg?style=plastic)](https://cloud.docker.com/repository/docker/salvax86/tools)
[![Codeship Status for vrain181/tools](https://app.codeship.com/projects/1e6d8f90-db99-0137-f27e-5e8489b72046/status?branch=master)](https://app.codeship.com/projects/371433)

Development Tools
---

Image in order to develop infrastructure as a code based on cloud resources


Usage
---

You can use image in different way

* Simple Run:

```
docker run -it salvax86/tools:1.0.0
```

* Remember credentials:

```
docker run -it -v ~/.aws:~/.aws salvax86/tools:1.0.0
```

* Install other tools:

Image will check if a file, named script.sh, is located in /tmp/script. If you mount your script in /tmp/script, it will
install everything automatically. 

```
docker run -it -v ~/.aws:~/.aws -v <script>/<location>:/tmp/script salvax86/tools:1.0.0
```
