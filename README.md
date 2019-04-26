#tools

##Development Tools


Image in order to develop infrastructure as a code based on cloud resources


##Usage
You can use image in different way

###Simple Run:

```
docker run -it salvax86/tools:1.0.0
```

###Remember credentials:

```
docker run -it -v ~/.aws:~/.aws salvax86/tools:1.0.0
```

###Install other tools:

```
docker run -it -v ~/.aws:~/.aws -v <path>/<script>/<location>:/tmp/script salvax86/tools:1.0.0
```