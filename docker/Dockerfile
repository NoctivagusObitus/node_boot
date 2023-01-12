FROM trini/u-boot-gitlab-ci-runner:jammy-20221130-11Jan2023

RUN echo "install cross compiler" \
	&& sudo apt-get update \
	&& sudo apt-get upgrade -y \
	&& sudo apt-get install -y \
		gcc-arm-linux-gnueabi \
		libncurses5-dev \
		gawk
