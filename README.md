# Nix flake for XTPlayer

[XTPlayer] is a video player with funscript and TCode support, used for driving your TCode-based fun toy, e.g. a multi-axis stroker robot.

[XTPlayer]: https://github.com/jcfain/XTPlayer


## Running

You can either: `nix run`

Or: `nix build` and then `./result/bin/XTPlayer`


## Status of this Flake

I can't guarantee that this flake is an entirely bug-free packaging of XTPlayer, but I was able to watch videos, connect a TCode toy and also watch them through the web interface.

In my experience, fullscreen video support in the application itself was janky (due to hitting some edge case),
so the built-in web interface may be preferable for watching in full screen.


## Enjoy

This flake is under the GPLv3 as XTPlayer itself is.

