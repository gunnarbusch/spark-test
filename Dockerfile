FROM continuumio/miniconda3

RUN conda install -c anaconda -c conda-forge flask pyspark
# RUN conda install -c anaconda -c conda-forge flask numpy pyspark rasterio
# RUN pip install geopyspark
# RUN geopyspark install-jar

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ADD . /usr/src/app

CMD python app.py
