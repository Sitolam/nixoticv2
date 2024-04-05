{pkgs, ...}: {
  imports = [
    ./zathura.nix
    ./vscodium.nix
  ];

  home.packages = with pkgs; [
    betterbird
    libreoffice
    onlyoffice-bin
    #   obsidian
    xournalpp
  ];
}
