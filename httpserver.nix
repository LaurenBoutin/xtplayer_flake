{ pkgs, qtpromise }:

let
  rev = "81f1d42378d95f7d40523739bb21b5eb09fc9fd1";


  inherit (pkgs) qt5 fetchFromGitHub stdenv perl;
	inherit (qt5) qmake wrapQtAppsHook;
in

stdenv.mkDerivation rec {
  pname = "HttpServer";
  version = rev;

  src = fetchFromGitHub {
		owner = "addisonElliott";
		repo = "HttpServer";
		inherit rev;
		sha256 = "sha256-farPj3Vo9xCuVVCCtV/KLc/ac2kSRRvMMuS8o3XBIX0=";
  };

  nativeBuildInputs = [ qmake wrapQtAppsHook perl ];
  buildInputs = [
    qt5.full
  ];

  # QtPromise is a header-only library and it is needed for HttpServer
  NIX_CFLAGS_COMPILE = "-I${qtpromise}/include";

  doCheck = false;

  patches = [ ./httpserver-tests-fix.patch ./httpserver-no-usr.patch ];
}
