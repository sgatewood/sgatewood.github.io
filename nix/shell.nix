{ pkgs }:
pkgs.mkShell {
  packages = with pkgs; [
    just
    libffi
    ruby_3_1
  ];
}
