{
  description = "package for XTPlayer, a cross-platform TCode player";

  inputs = {
    utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "nixpkgs/nixos-23.11";

    
  };

  outputs = inputs @ { utils, nixpkgs, ... }:
    utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages."${system}";

      qtcompress = import ./qtcompress.nix { inherit pkgs; };
      qtpromise = import ./qtpromise.nix { inherit pkgs; };
      httpserver = import ./httpserver.nix { inherit pkgs qtpromise; };
      
      xtengine = import ./xtengine.nix { inherit pkgs qtcompress qtpromise httpserver; };
      xtplayer = import ./xtplayer.nix { inherit pkgs qtcompress qtpromise httpserver xtengine; };
      
    in rec {
      packages = { inherit qtcompress httpserver qtpromise xtengine xtplayer; };
      defaultPackage = packages.qtcompress;
    });
}
