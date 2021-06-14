# docker-fedora-rpmbuild

This container allows you to build packages in a mock.

## Build

### Podman
```bash
git clone https://github.com/ElXreno/docker-fedora-rpmbuild
cd docker-fedora-rpmbuild
podman build -t docker-fedora-rpmbuild .
```

## Usage

### Podman
```bash
podman run --rm -it --privileged -v /path/to/spec/folder:/mockbuilder docker-fedora-rpmbuild
```

Replace `/path/to/spec/folder` by full path to the folder with required spec file.

The same command but with persistent cache:

```bash
podman run --rm -it --privileged -v mockcache:/var/cache/mock -v mock:/var/lib/mock -v /path/to/spec/folder:/mockbuilder docker-fedora-rpmbuild
```

And with full access to the files:

```bash
podman run --rm -it --privileged --userns=keep-id -v mockcache:/var/cache/mock -v mock:/var/lib/mock -v /path/to/spec/folder:/mockbuilder:Z docker-fedora-rpmbuild
```