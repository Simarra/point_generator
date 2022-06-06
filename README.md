nix-shell --packages cabal2nix --run "cabal2nix ." > default.nix 
nix-shell --packages cabal2nix --run "cabal2nix --shell ." > shell.nix

