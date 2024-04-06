{pkgs, ...}: {
  imports = [
    ./anyrun
    # ./browsers/thorium.nix
    ./browsers/firefox.nix
    ./media
    ./gtk.nix
    ./office
  ];

  home.packages = with pkgs; [
    tdesktop
    vesktop
    overskride
    mission-center
    wineWowPackages.wayland
    brightnessctl
  ];
}
