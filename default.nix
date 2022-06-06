{ mkDerivation, base, containers, lib, random }:
mkDerivation {
  pname = "haskell-poc";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base containers random ];
  license = "unknown";
  hydraPlatforms = lib.platforms.none;
}
