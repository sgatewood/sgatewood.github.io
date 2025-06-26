{ pkgs }:
pkgs.mkShell {
  packages = with pkgs; [
    asciinema
    just
    libffi
    ruby_3_1
  ];
}
