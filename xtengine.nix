{ pkgs, httpserver, qtpromise, qtcompress }:

let
  rev = "e1a75fa3e7cdea7b827a7a1a292a6e23aff4b32a";

  repoSrc = fetchFromGitHub {
		owner = "jcfain";
		repo = "XTEngine";
		inherit rev;
		sha256 = "sha256-c1b+E1uq2vPQcfu+xIuoOmkIAqSE0/yW9CvUqk6mqSU=";
  };

  inherit (pkgs) qt5 fetchFromGitHub stdenv perl;
	inherit (qt5) qmake wrapQtAppsHook;
in

stdenv.mkDerivation rec {
  pname = "XTEngine";
  version = rev;
  src = "${repoSrc}/src";

  nativeBuildInputs = [ qmake wrapQtAppsHook perl ];
  buildInputs = [
    qt5.full qt5.qtgamepad qt5.qtspeech qtcompress httpserver
  ];

  # Copy ALL header files including directory hierarchy (QMake's INSTALLS is not capable of doing this; this is a bit hacky)
  postInstall = ''
    mkdir -p $out/include/xtengine
    (cd $src && find ./ -type f -name "*.h" -exec cp --parents {} $out/include/xtengine/ --no-preserve=mode \;)
  '';

  # QtPromise is a header-only library and it is needed for XTEngine
  NIX_CFLAGS_COMPILE = "-I${qtpromise}/include";

  # I think httpserver-include is misguided and we should add httpServer to the -I flags instead...
  patches = [ ./xtengine-httpserver-include.patch ./xtengine-install-prefix.patch ];
}
