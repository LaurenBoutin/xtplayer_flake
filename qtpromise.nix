{ pkgs }:

let
  rev = "f382ad25fc8e3f07139426747cb980d37fe9af73";

  inherit (pkgs) fetchFromGitHub;
in

fetchFromGitHub {
	owner = "simonbrunel";
	repo = "qtpromise";
	inherit rev;
	sha256 = "sha256-+pi4bCGlnBDqzsihvnImajZgD0m/KdMYzLlNMss2UFs=";
}
