# Docker file for the Indigeneous vs Non-indigenous aggregate sentence predictor
# Rada Rudyak, Dec, 2021

# use rocker/tidyverse as the base image and
FROM rocker/tidyverse

# install R packages
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
  && install2.r --error \
    --deps TRUE \
    cowsay \
    here \
    feather \
    ggridges \
    ggthemes \
    e1071 \
    caret 

# install the kableExtra package using install.packages
RUN Rscript -e "install.packages('kableExtra')"
RUN Rscript -e "install.packages('knitr')"
RUN Rscript -e "install.packages('docopt')"
RUN Rscript -e "install.packages('janitor')"
RUN Rscript -e "install.packages('infer')"
RUN Rscript -e "install.packages('testthat')"

# install the anaconda distribution of python
RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-2019.10-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
    /opt/conda/bin/conda clean -afy && \
    /opt/conda/bin/conda update -n base -c defaults conda

# put anaconda python in path
ENV PATH="/opt/conda/bin:${PATH}"

RUN conda config --add channels conda-forge

# install docopt python package
RUN conda install -y -c conda-forge \ 
    docopt \
    requests \
    numpy \ 
    pandas \
    altair \
    altair_saver


    
