{ pkgs, httpserver, qtpromise, qtcompress, xtengine }:

let
  rev = "9ac5cc2c7fc5524f1a179bb6989d1a54c1ef62ad";

  repoSrc = fetchFromGitHub {
		owner = "jcfain";
		repo = "XTPlayer";
		inherit rev;
		sha256 = "sha256-Urqw/ODbkWnSYznayKvAefTn3VC6zrV9Iw+vVtU7uoE=";
  };

  inherit (pkgs) qt5 fetchFromGitHub stdenv perl;
	inherit (qt5) qmake wrapQtAppsHook;
in

stdenv.mkDerivation rec {
  pname = "XTPlayer";
  version = rev;
  src = "${repoSrc}/src";

  nativeBuildInputs = [ qmake wrapQtAppsHook perl ];
  buildInputs = [
    qt5.full qt5.qtgamepad qt5.qtspeech qtcompress httpserver xtengine
  ];

  # QtPromise is a header-only library
  # XTEngine headers need to be includable with `#include "lib/....h"`
  NIX_CFLAGS_COMPILE = "-I${qtpromise}/include -I${xtengine}/include/xtengine";

  postBuild = ''
    mkdir $out
    cp -r $src/themes $out/themes
    cp -r $src/www $out/www
  '';

  patches = [ ./xtplayer-buildout.patch ];
}
