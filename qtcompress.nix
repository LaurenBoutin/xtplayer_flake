{ pkgs }:

let
  rev = "23f8831826cd72aedf99fc3699148b6c994fd677";


  inherit (pkgs) qt5 fetchFromGitHub stdenv perl;
	inherit (qt5) qmake wrapQtAppsHook;
in

stdenv.mkDerivation rec {
  pname = "qtcompress";
  version = rev;

  src = fetchFromGitHub {
		owner = "nezticle";
		repo = "qtcompress";
		inherit rev;
		sha256 = "sha256-p4a599HRkhCwbazrzpqBsvJKchE2K3/+Sn95e8tiUfQ=";
  };

  nativeBuildInputs = [ qmake wrapQtAppsHook perl ];
  buildInputs = [
    qt5.full
  ];

  patches = [ ./qtcompress-install-headers-to-prefix.patch ];
}
