# Install firefox.
FROM gitpod/workspace-full

RUN sudo apt-get update 
RUN sudo apt -y install firefox
