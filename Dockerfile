FROM ubuntu:noble

RUN apt-get update && apt-get install -y git make gcc g++ \
    device-tree-compiler zlib1g-dev squashfs-tools

#########################################################################################
WORKDIR /fwtoolset/Android

RUN git clone https://github.com/techexpertize/SignApk.git

#813a5e9a5aca12a5acc801df711da22baf64952d
RUN git clone https://github.com/anestisb/android-unpackbootimg.git && \
    cd android-unpackbootimg && make && install mkbootimg /usr/local/bin && install unpackbootimg /usr/local/bin

RUN git clone https://github.com/anestisb/android-simg2img && \
    cd android-simg2img && make && make install

RUN git clone https://github.com/anestisb/vdexExtractor.git && \
    sed -i 's#dexInstr_getVarArgs(u2 \*, u4\[\]);#dexInstr_getVarArgs(u2 *, u4[kMaxVarArgRegs]);#' vdexExtractor/src/dex_instruction.h && \
    cd vdexExtractor && ./make.sh && install bin/vdexExtractor /usr/local/bin


#########################################################################################

WORKDIR /fwtoolset/Amlogic

RUN git clone https://github.com/steeve/aml-imgpack.git

RUN git clone https://github.com/khadas/utils.git khadas-utils && \
    install khadas-utils/aml_image_v2_packer /usr/local/bin

#RUN git clone https://github.com/7Ji/ampack.git && \
#    cd ampack && \
#    cargo build --release && \
#    install /src/ampack/target/release/ampack /usr/local/bin

##########################################################################################
WORKDIR /fwtoolset/SpreadTrum

RUN git clone https://github.com/divinebird/pacextractor && \
    cd pacextractor && make && install pacextractor /usr/local/bin

##########################################################################################
#other links
#https://github.com/plougher/squashfs-tools.git
#apt install android-tools-fsutils - sparse to ext4

##########################################################################################
RUN ls -l /usr/local/bin
