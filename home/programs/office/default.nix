{pkgs, ...}: {
  imports = [
    ./zathura.nix
  ];

  home.packages = with pkgs; [
    libreoffice
    onlyoffice-bin
#   obsidian
    xournalpp
  ];
}
