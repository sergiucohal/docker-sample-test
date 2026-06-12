ARG REGISTRY=repos.esac.esa.int:62220
FROM ${REGISTRY}/datalabs/jl_base:0.8.0-stable-24.04 

ARG DEBIAN_FRONTEND=noninteractive

LABEL description="Demo datalab Docker"
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN apt-get update \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY jupyter_notebook_config.py /home/$USER/.jupyter/
COPY jupyter_notebook_config.py /etc/
ENV JUPYTER_CONFIG_PATH=/etc/

# uncomment the following lines if you have (e.g. notebook) files to share with users:
# (adapt as necessary)
RUN mkdir /media/notebooks/
COPY *.ipynb /media/notebooks/

WORKDIR /tmp

COPY environment.yml /tmp/

RUN conda env create -f /tmp/environment.yml \
  && conda clean -all -f -y \
  && conda run -n demo python -m ipykernel install --name=demo --display-name=demo

