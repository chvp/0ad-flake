{
  description = "A flake to run older versions of 0ad";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs, ... }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      pkgSet = pkgs.zeroadPackages;
    in
    {
      packages.x86_64-linux = rec {
        zeroad-unwrapped = pkgSet.zeroad-unwrapped.overrideAttrs (old: rec {
          version = "0.0.24b";
          src = pkgs.fetchurl {
            url = "http://releases.wildfiregames.com/0ad-${version}-alpha-unix-build.tar.xz";
            sha256 = "1a1py45hkh2cswi09vbf9chikgxdv9xplsmg6sv6xhdznv4j6p1j";
          };
        });
        zeroad-data = pkgSet.zeroad-data.overrideAttrs (old: rec {
          version = "0.0.24b";
          src = pkgs.fetchurl {
            url = "http://releases.wildfiregames.com/0ad-${version}-alpha-unix-data.tar.xz";
            sha256 = "0b53jzl64i49rk3n3c3x0hibwbl7vih2xym8jq5s56klg61qdxa1";
          };
        });
        zeroad = (pkgSet.zeroad.override { inherit zeroad-data zeroad-unwrapped; });
      };
      defaultPackage.x86_64-linux = self.packages.x86_64-linux.zeroad-unwrapped;
    };
}
