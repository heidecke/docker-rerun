A modular shell framework to organize scripts https://github.com/rerun/rerun

This image includes rerun and the necessary dependencies of rerun stubbs:docs.

Usage
-----
The rerun Docker image entrypoint script will pass all options to the rerun command.

### Local Modules
On image run, you can mount a volume to `/app/modules` with your own modules. They will
then be added to `/usr/lib/rerun/modules` automatically at runtime.

`docker run -v $localpath/modules:/app/modules -t heidecke/rerun`

### Accessing the shell
The `-s` argument will allow you to use a local module repository and access the bash shell prompt.

`docker run -v $localpath/modules:/app/modules -ti heidecke/rerun -s`

### Running stubbs:docs to output documentation to a host directory

```
$ module=vip; \
> localmods=~/Code/modules; \
> localout=~/Code/docs/$module; \
> docker run -v $localmods:/app/modules \
>            -v $localout:/app/output \
>            -e USER=$USER \
>            -ti rerun stubbs:docs \
>            --module $module \
>            --dir /app/output
Unix manual: /app/output/vip.1
HTML site: /app/output/index.html
$
```

Versions
--------

* CentOS 6.x
* Discount Markdown Library, 2.1.8a
* Python 2.7 w/ pip
* Pygments Python Syntax Highlighter 2.0.2
