FROM java:8-jre

# Set Java environment variables
ENV JAVA_HOME      /usr/bin/java
ENV PATH           ${PATH}:${JAVA_HOME}/bin

# Set MCR environment variables
ENV MATLAB_JAVA    ${JAVA_HOME}

ARG MCR_VERSION
ARG MCR_NUM

# Install packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    xorg \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Add MCR installer
## option 1) download automatically into layer
RUN mkdir /mcr-install
RUN wget https://www.mathworks.com/supportfiles/downloads/${MCR_VERSION}/deployment_files/${MCR_VERSION}/installers/glnxa64/MCR_${MCR_VERSION}_glnxa64_installer.zip -O /mcr-install/mcr.zip
## option 2) add into layer after downloading manually
#ADD MCR_${MCR_VERSION}.zip /mcr-install/mcr.zip

# Install MatLab runtime
RUN cd /mcr-install \
    && unzip mcr.zip \
    && mkdir /opt/mcr \
    && ./install -v -mode silent -agreeToLicense yes -destinationFolder /opt/mcr/ \
    && cd / \
    && rm -rf /mcr-install

# Set MCR environment variables
ENV LD_LIBRARY_PATH    ${LD_LIBRARY_PATH}:\
/opt/mcr/${MCR_NUM}/runtime/glnxa64:\
/opt/mcr/${MCR_NUM}/bin/glnxa64:\
/opt/mcr/${MCR_NUM}/sys/os/glnxa64:

ENV XAPPLRESDIR        /opt/mcr/${MCR_NUM}/X11/app-defaults

# Define default command
CMD ["bash"]
