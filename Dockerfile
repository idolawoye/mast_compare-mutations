# dockerfile_mast_mutations.dockerfile
# Use a specific platform base image
# version 1.1.0
FROM --platform=linux/amd64 continuumio/miniconda3:latest

# Set conda to use linux-64 subdir explicitly
RUN conda config --set subdir linux-64

# Create conda environment with both tools from bioconda
RUN conda create -n mutation-env -c bioconda -c conda-forge \
    python=3.10 \
    pandas \
    biopython \
    python-docx \
    jinja2 \
    pysam \
    pip \
    && conda clean -a

RUN /opt/conda/envs/mutation-env/bin/pip install docxtpl

# Add environment to PATH
ENV PATH /opt/conda/envs/mutation-env/bin:$PATH

# Set working directory
WORKDIR /data

# Verify installations
RUN /opt/conda/envs/mutation-env/bin/pip show pandas

CMD ["/bin/bash"]
