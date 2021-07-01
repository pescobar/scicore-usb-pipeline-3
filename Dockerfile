FROM continuumio/miniconda3:4.7.12
MAINTAINER Pablo Escobar <pablo.escobarlopez@unibas.ch>

# install some system deps
# poppler-utils provides utility "pdfunite"
RUN apt-get update && apt-get install -y \
    poppler-utils \
    unzip \
    wget \
 && rm -rf /var/lib/apt/lists/*

# add conda channels
RUN conda config --add channels conda-forge
RUN conda config --add channels bioconda


# bioconda installations
RUN conda install --yes -c bioconda prokka==1.12
RUN conda install --yes -c bioconda quast==5.0.2
RUN conda install --yes -c bioconda blast==2.5.0
RUN conda install --yes -c bioconda unicycler==0.4.8
RUN conda install --yes -c bioconda abricate==0.5
#RUN conda install --yes -c bioconda bowtie2==2.3.5.1
RUN conda install --yes -c bioconda trimmomatic==0.39
RUN conda install --yes -c bioconda bwa==0.7.17

# Install R and ggplot2
RUN conda install --yes -c r-ggplot2

# Downlod quast dbs
RUN quast-download-gridss
RUN quast-download-silva

#RUN quast-download-busco
# previous command fails so we manually download quast dbs
# https://github.com/bioconda/bioconda-recipes/issues/18646
RUN wget -O /opt/conda/lib/python3.7/site-packages/quast_libs/busco/bacteria.tar.gz https://busco.ezlab.org/v2/datasets/bacteria_odb9.tar.gz
RUN wget -O /opt/conda/lib/python3.7/site-packages/quast_libs/busco/eukaryota.tar.gz https://busco.ezlab.org/v2/datasets/eukaryota_odb9.tar.gz
RUN wget -O /opt/conda/lib/python3.7/site-packages/quast_libs/busco/fungi.tar.gz https://busco.ezlab.org/v2/datasets/fungi_odb9.tar.gz
