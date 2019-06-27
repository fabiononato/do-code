#!/bin/sh

if [ -d /etc/apt ]; then
        [ -n "$http_proxy" ] && echo "Acquire::http::proxy \"${http_proxy}\";" > /etc/apt/apt.conf; \
        [ -n "$https_proxy" ] && echo "Acquire::https::proxy \"${https_proxy}\";" >> /etc/apt/apt.conf; \
        [ -f /etc/apt/apt.conf ] && cat /etc/apt/apt.conf
fi

# Setting up environment
echo "conda update -n base conda -y && conda env update"
conda update -n base conda -y && conda env update

# download the coder binary, untar it, and allow it to be executed
wget https://github.com/cdr/code-server/releases/download/1.1156-vsc1.33.1/code-server1.1156-vsc1.33.1-linux-x64.tar.gz \
    && tar -xzvf code-server*-linux-x64.tar.gz && chmod +x code-server*-linux-x64/code-server

# Moving entrypoint to a path location
cp /docker-entrypoint.sh /usr/local/bin/

./code-server*linux-x64/code-server --install-extension formulahendry.code-runner
./code-server*linux-x64/code-server --install-extension tushortz.python-extended-snippets
./code-server*linux-x64/code-server --install-extension ms-python.python
./code-server*linux-x64/code-server --install-extension vahidk.tensorflow-snippets
