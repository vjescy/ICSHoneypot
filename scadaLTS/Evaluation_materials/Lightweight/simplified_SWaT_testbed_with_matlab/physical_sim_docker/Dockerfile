
ARG MATLAB_RELEASE="R2024b"

FROM mathworks/matlab:${MATLAB_RELEASE}

ARG MATLAB_RELEASE
ARG MATLAB_PRODUCT_LIST="MATLAB Simulink"
ARG MATLAB_INSTALL_LOCATION="/opt/matlab/${MATLAB_RELEASE}"

USER root
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt update \
    && apt-get install --no-install-recommends --yes \
    wget \
    ca-certificates \
    && apt-get clean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*


USER matlab
WORKDIR /home/matlab

RUN wget -q https://www.mathworks.com/mpm/glnxa64/mpm \
    && chmod +x mpm \
    && sudo HOME=${HOME} ./mpm install \
    --release=${MATLAB_RELEASE} \
    --destination=${MATLAB_INSTALL_LOCATION} \
    --products ${MATLAB_PRODUCT_LIST} \
    || (echo "MPM Installation Failure. See below for more information:" && cat /tmp/mathworks_root.log && false) \
    && sudo rm -rf mpm /tmp/mathworks_root.log \
    && sudo ln -s ${MATLAB_INSTALL_LOCATION}/bin/matlab /usr/bin/matlab

