{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    sean-flake-utils.url = "github:sgatewood/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      treefmt-nix,
      sean-flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        treefmtEval = treefmt-nix.lib.evalModule pkgs ./nix/treefmt.nix;
        devShell = import ./nix/shell.nix {
          inherit pkgs;
        };
        pkgVersionSnapshotTest = sean-flake-utils.lib.pkgVersionSnapshotTest {
          inherit pkgs;
          inherit devShell;
          snapshotFileName = "flake.lock.pkgs.yaml";
          snapshotFileDir = ./.;
        };
      in
      {
        devShells.default = devShell;
        formatter = treefmtEval.config.build.wrapper;
        checks.formatting = treefmtEval.config.build.check self;
        checks.pkgVersionSnapshotTest = pkgVersionSnapshotTest.check;
        apps.pkgVersionSnapshotTestUpdate = pkgVersionSnapshotTest.updateApp;
      }
    );
}
