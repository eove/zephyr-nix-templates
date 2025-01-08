{
  fetchFromGitHub,
  fetchgit,
  stdenv,

  autoconf,
  automake,
  fd,
  git,
  gnum4,
  gnumake,
  hidapi,
  libftdi1,
  libtool,
  libusb1,
  pkg-config,
  texinfo,
  which,
  ...
}:
stdenv.mkDerivation rec {
  pname = "openocd-cubeide";
  version = "1.13.0";

  nativeBuildInputs = [
    autoconf
    automake
    fd
    git
    gnumake
    gnum4
    libtool
    pkg-config
    which
  ];

  buildInputs = [
    hidapi
    libftdi1
    libusb1
  ];

  # Use fetchgit instead of fetchFromGitHub because the later does not support submodules.
  src = fetchgit {
    url = "https://github.com/STMicroelectronics/OpenOCD";
    rev = "openocd-cubeide-v${version}";
    hash = "sha256-Q8lIqzpr5MYbMDyY2Lx5OlRPT1HaHqwusMQ6oQ6o7oE=";

    # Fetch of submodules is done here instead of in bootstrap script.
    fetchSubmodules = true;
  };

  patchPhase = ''
    # Bad packages forget about updating versions.
    sed -i -E 's|0.12.0|cubeide-${version}|g' configure.ac
    # Compiler complains about bad usage of calloc.
    fd -e c -e h -x sed -i -E 's|calloc\(sizeof\(([^\)]+)\), ([^\)]+)\)|calloc(\2, sizeof(\1))|g'
  '';

  configurePhase = ''
    # No submodule init here.
    ./bootstrap nosubmodule
    # Set the right prefix because /usr/local is the default.
    ./configure --prefix=/
  '';

  buildPhase = ''
    make -j
  '';

  installPhase = ''
    make DESTDIR=$out install
  '';
}
