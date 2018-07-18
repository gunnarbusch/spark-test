FROM radanalyticsio/radanalytics-pyspark-py36:latest

# Install conda

USER root
RUN yum -y update \
    && yum -y install curl bzip2 \
    && curl -sSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -bfp /usr/local/ \
    && rm -rf /tmp/miniconda.sh \
    && conda install -y python=3 \
    && conda update conda \
    && conda clean --all --yes \
    && rpm -e --nodeps curl bzip2 \
    && yum clean all

USER root
RUN conda install -c anaconda -c conda-forge flask numpy pyspark rasterio
USER root
RUN pip install geopyspark 
# RUN geopyspark install-jar

USER root
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
ADD . /usr/src/app

# USER 185
# ENTRYPOINT ["/opt/app-root/etc/bootstrap.sh"]
# CMD ["/usr/libexec/s2i/usage && python app.py"]
