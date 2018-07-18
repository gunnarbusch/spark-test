FROM radanalyticsio/radanalytics-pyspark-py36:latest

# Install conda

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

RUN conda install -c anaconda -c conda-forge flask numpy pyspark rasterio

RUN pip install geopyspark 
# RUN geopyspark install-jar

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
ADD . /usr/src/app

CMD python app.py
