FROM ufoym/deepo

#
# Tools
#
RUN apt-get update && \
    apt-get install -yq \
    ack \
    iputils-ping \
    sqlite3 \
    postgresql-client \
    sudo \
    openjdk-8-jdk \
    leiningen \
    tmux \
    tree \
    less \
    openssh-server openssh-client
    

RUN pip3 install \
    wheel \
    gensim \
    nltk \
    jupyterlab \
    pandas \
    matplotlib \
    scikit-learn \
    flask \
    flask-cors \
    gunicorn
    
ENV TZ=America/Toronto
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    apt-get install -yq tzdata

# Gotty
RUN cd /usr/bin && \
    wget -q -O - \
    https://github.com/yudai/gotty/releases/download/v1.0.1/gotty_linux_amd64.tar.gz \
    | tar xvfz -

# Golang
RUN add-apt-repository ppa:longsleep/golang-backports && \
    apt-get update && \
    apt-get install -yq golang-go

# Gradle
RUN wget https://services.gradle.org/distributions/gradle-5.0-bin.zip -P /tmp && \
    unzip -d /opt/gradle /tmp/gradle-*.zip && \
    ln -sf /opt/gradle/gradle-5.0/bin/* /usr/bin

# Haskell
RUN apt-get install -yq haskell-platform

# Clojure
RUN curl -sSL https://download.clojure.org/install/linux-install-1.10.1.469.sh | bash && \
    apt-get install rlwrap

RUN git clone https://github.com/clojupyter/clojupyter.git && \
    cd clojupyter && \
    lein uberjar

RUN mkdir -p /usr/local/share/jupyter/kernels/clojure && \
    cp /clojupyter/target/clojupyter-*-standalone.jar \
       /usr/local/share/jupyter/kernels/clojure/clojupyter-standalone.jar

COPY clojure_kernel.json /usr/local/share/jupyter/kernels/clojure/kernel.json

# Vim configuration
COPY tmux.conf /etc/tmux.conf
COPY vim /etc/vim
COPY bash.bashrc /etc/bash.bashrc
COPY start.sh /bin/start.sh
