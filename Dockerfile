ARG REGISTRY=repos.esac.esa.int:62220
FROM ${REGISTRY}/datalabs/jl_base:stable

ARG DEBIAN_FRONTEND=noninteractive

# --- Install mamba (fast conda solver) ------------------------------------
RUN conda install --quiet --yes -c conda-forge 'mamba' \
    && conda clean --all -f -y \
    && mamba shell init --shell bash --root-prefix="$(conda info --base)"

# --- (Optional) Create a conda environment from an environment.yml --------
# COPY environment.yml /tmp/environment.yml
# RUN mamba env create -f /tmp/environment.yml \
#     && conda clean --all -f -y

# --- (Optional) Install packages with pip ---------------------------------
# RUN pip install --no-cache-dir \
#     somepackage==1.0.0

# --- Copy recipe configuration files --------------------------------------
COPY jupyter_notebook_config.py /etc/
COPY user-01.sh /opt/datalab/init.d/user-01.sh

# --- Set permissions -------------------------------------------------------
RUN chmod +x /opt/datalab/init.d/user-01.sh

# --- Jupyter configuration path --------------------------------------------
ENV JUPYTER_CONFIG_PATH=/etc/
