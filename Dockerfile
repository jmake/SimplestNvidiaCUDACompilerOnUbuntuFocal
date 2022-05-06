## 
## SEE : 
##   jupyter/base-notebook @ https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html
##
FROM jupyter/base-notebook:latest AS NOTEBOOK_SETUP 
RUN conda install -c conda-forge cxx-compiler vim 
RUN conda install -c anaconda numpy
RUN conda install -c anaconda swig
RUN conda install -c anaconda make
RUN conda install -c anaconda cmake


FROM NOTEBOOK_SETUP AS NOTEBOOK_EXECUTE

ENV IPYNB_FILE="nvcc_ubuntufocal.ipynb"

ENV NB_USER="jovyan" 

USER root 

WORKDIR /home/jovyan/work 

COPY ${IPYNB_FILE} /home/jovyan/work 

RUN chown -R ${NB_USER} /home/jovyan/work

USER ${NB_USER}

RUN jupyter nbconvert --execute --clear-output ${IPYNB_FILE} 

COPY ${IPYNB_FILE} from_docker.ipynb

RUN tar -cvzf results.tar.gz /home/jovyan/work/*.*  
