FROM ubuntu

# install wget, unzip, packer,golang
RUN /bin/bash -lc "apt-get update"
RUN /bin/bash -lc "apt-get -y install wget"
RUN /bin/bash -lc "apt-get -y install unzip"

# install Git
RUN /bin/bash -lc "apt-get -y install git"

# install Golang
RUN /bin/bash -lc "wget https://storage.googleapis.com/golang/go1.5.linux-amd64.tar.gz"
RUN /bin/bash -lc "tar -C /usr/local -xzf go1.5.linux-amd64.tar.gz"
RUN /bin/bash -lc "mkdir -p /Go/src && mkdir -p /dev/Go/pkg && mkdir -p /dev/Go/bin"
ENV GOROOT /usr/local/go
ENV GOPATH /Go
ENV PATH $GOROOT/bin:$PATH

# install packer post-processor shell
RUN /bin/bash -lc "go get github.com/vtolstov/packer-post-processor-shell"
RUN /bin/bash -lc "go install github.com/vtolstov/packer-post-processor-shell"

# install packer
RUN /bin/bash -lc "wget https://releases.hashicorp.com/packer/0.8.6/packer_0.8.6_linux_amd64.zip"
RUN /bin/bash -lc "mkdir packer && unzip -d packer packer_0.8.6_linux_amd64.zip"
RUN /bin/bash -lc "mkdir -p ~/.packer.d/plugins && cp $GOPATH/bin/packer-post-processor-shell ~/.packer.d/plugins"
RUN /bin/bash -lc "mkdir ~/tmp"

# copy source
COPY src /buildstreet

# set work dir
WORKDIR /project

# run buildstreet script
ENTRYPOINT ["../buildstreet/buildstreet.sh"]
