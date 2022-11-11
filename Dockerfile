# Start from a core stack version
# For more information, please refer to https://aka.ms/vscode-docker-python
FROM python:3.8-slim

ARG USER="appuser"
ARG GROUP="${USER}"
ARG UID="1000"
ARG GID="100"
ARG TOKEN="mytoken"

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

RUN apt-get update \
    && apt-get install --yes \
        build-essential \
        wget \
        git \
        gdb \
    && rm -rf /var/lib/apt/lists/*

#############################################################################

# Install pip requirements
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir --requirement /tmp/requirements.txt

## Creates a non-root user with an explicit UID and adds permission to access the /app folder
## For more info, please refer to https://aka.ms/vscode-docker-python-configure-containers
WORKDIR /home/${USER}
RUN groupadd --force --gid "${GID}" --non-unique "${GROUP}" \
    && adduser --uid "${UID}" --gid "${GID}" --disabled-password --gecos "" "${USER}" \
    && chown -R ${USER} /home/${USER}
USER ${USER}

