tools
===

[![CircleCI](https://circleci.com/gh/vrain181/tools/tree/master.svg?style=svg)](https://circleci.com/gh/vrain181/tools/tree/master)

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