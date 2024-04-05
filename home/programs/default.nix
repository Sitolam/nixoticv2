{pkgs, ...}: {
  imports = [
    ./anyrun
    ./browsers/thorium.nix
    ./browsers/firefox.nix
    ./media
    ./gtk.nix
    ./office
  ];

  home.packages = with pkgs; [
    tdesktop

    overskride
    mission-center
    wineWowPackages.wayland
  ];
}
