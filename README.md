# docker-rerun
A modular shell framework to organize scripts https://github.com/rerun/rerun

This image includes rerun and the necessary dependencies of rerun stubbs:docs.

## Versions

* CentOS 6.x
* Discount Markdown Library, 2.1.8a
* Python 2.7 w/ pip
* Pygments Python Syntax Highlighter 2.0.2

## Adding your own modules
On image run, you can mount a volume to `/usr/lib/rerun/modules` with your own modules.

`docker run -v $path/modules:/usr/lib/rerun/modules -ti lukeheidecke/rerun bash`
