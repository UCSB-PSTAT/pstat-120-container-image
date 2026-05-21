FROM ucsb/rstudio-base:latest

LABEL maintainer="LSIT Systems <lsitops@ucsb.edu>"

USER root

ENV TZ America/Los_Angeles
RUN apt update && \
    apt install -y texlive-full lmodern libbz2-dev nano && \
    apt clean && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN conda install -c r \
    r-dt \
    r-fivethirtyeight \
    r-kableextra \
    r-learnr \
    r-mosaic \
    r-mosaiccore \
    r-mosaicdata \
    r-network && \
    /usr/local/bin/fix-permissions "${CONDA_DIR}" || true



RUN R -e 'pak::pak("hadley/emo")' && \
    R -e "install.packages(c('cherryblossom','Lock5Data','openintro','palmerpenguins','tutorial.helpers'), repos = 'https://cloud.r-project.org/', Ncpus = parallel::detectCores())"

USER $NB_USER

