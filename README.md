# docker-matlab-runtime
Docker image containing the Matlab Compiler Runtime, based on `java:8-jre`.

### Instructions

1. Find the release and version you want to build for:

    * visit https://www.mathworks.com/products/compiler/matlab-runtime.html
    * `MCR_VERSION` will be the release name (ex: R2018a)
    * `MCR_NO` will be the runtime version number without periods and with a 'v' prepended (ex: 9.4 --> v94)

1. Build the image:

       docker build --build-arg MCR_NO=v94 --build-arg MCR_VERSION=R2018a -t mcr:R2018a .

1. Use the image in other dockerfiles:

       FROM mcr:R2018a
       ...
