{ pkgs }:
pkgs.mkShell {
  packages = with pkgs; [
    asciiquarium
    asciinema
    just
    libffi
    ruby_3_1
  ];
}
