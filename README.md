# Sites #
## Introduction ##
This repository contains the source for all my different websites projects. It
is all __currently__ built with `mkdocs` via `python` to generate pure HTML 
static HTML webpages for speed and security.

## Usage ##
### Wrapper ###
The `run.sh` script is just a simple wrapper to be able to run a ephemeral setup
of python to install dependencies inside. This is also used for updates and can
be used the same way as a virtual Environment.

Start the container in interactive mode:
```bash
bash run.sh

```

Install dependencies and use the container:
```bash
pip install -r src/requirements.txt
cd blog
mkdocs serve --dev-addr 0.0.0.0:8000
```

Build the project:
```bash
pip install -r src/requirements.txt
cd blog
mkdocs build
```
