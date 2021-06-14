FROM fedora:34

# For caching and more fresh system,comment it
# if you want to save more disk space.
RUN dnf upgrade --refresh -y

# nosync: work-around to install nosync.i686.
RUN dnf install mock rpmdevtools rpm-build fedpkg nosync -y && \
    dnf install nosync.i686 -y && \
    dnf install fish -y && \
    dnf clean all

RUN useradd mockbuilder && usermod -a -G mock mockbuilder && \
    mkdir /mockbuilder && chown mockbuilder:mockbuilder /mockbuilder && \
    su - mockbuilder -c rpmdev-setuptree && \
    su - mockbuilder -s /bin/fish -c 'set --universal fish_user_paths $fish_user_paths /usr/sbin'
COPY mock.cfg /home/mockbuilder/.config/
USER mockbuilder
WORKDIR /mockbuilder

# You can override entrypoint by passing --entrypoint parameter.
ENTRYPOINT nice -n 19 /bin/fish
