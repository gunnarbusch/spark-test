FROM radanalyticsio/openshift-spark:2.3-latest









FROM gettyimages/spark

RUN apt-get -qq update && apt-get -qq -y install curl bzip2 \
    && curl -sSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -bfp /usr/local \
    && rm -rf /tmp/miniconda.sh \
    && conda update conda \
    && apt-get -qq -y remove curl bzip2 \
    && apt-get -qq -y autoremove \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /var/log/dpkg.log \
    && conda clean --all --yes
ENV PATH /opt/conda/bin:$PATH

RUN conda install -c anaconda -c conda-forge flask pyspark
# RUN conda install -c anaconda -c conda-forge flask numpy pyspark rasterio
# RUN pip install geopyspark
# RUN geopyspark install-jar

RUN mkdir -p /usr/src/app
ADD . /usr/src/app

CMD python /usr/src/app/app.py
