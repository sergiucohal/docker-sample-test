# Internal Developer: create a jupyterlab datalab

This repository provides an example for the creation of an ESA Datalabs JupyterLab datalab for internal developers.

The datalab can be created with either uploading individual files, a zip file or a git repository.

Note that this `readme.md` is *not* required to create a datalab.


## File or repository structure

A typical simple repository example is:

- `Dockerfile` --> custom Dockerfile to install APT packages and create a custom conda environment
- `environment.yml` --> auxillary file used to conda install python packages
- `jupyter_notebook_conf.py` --> Jupyter notebook configuration file (to set the default kernel)
- `notebook.ipynb` --> simple example jupyter notebook
- `datalab-meta.yml` --> pre-filled metadata key:value pairs (used to create the datalab)
- `logo.svg` --> datalab jupyterlab logo in SVG format

Note that if using a zip archive or git repository these files need to be in the root (!)


## Metadata file

The structure of a metadata yml file is as follows (here only the mandatory keyworeds are included; see ESA Datalabs help pages for the full list of possible keywords):

    # Mandatory fields:

    title: Name of your datalab
    alternateName: Shorter name or acronym for your datalab
    abstract: A short description of your Datalab
    contactPoint.email: email adress
    creator.name: name
    version: 0.0.1

See the `datalab-meta.yml` file for a concrete example.
