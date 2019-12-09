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

# Vim configuration
COPY tmux.conf /etc/tmux.conf
COPY vim /etc/vim
COPY bash.bashrc /etc/bash.bashrc
COPY start.sh /bin/start.sh
