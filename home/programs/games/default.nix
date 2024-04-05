{
  pkgs,
  inputs,
  ...
}:
# games
{
  home.packages = with pkgs; [
    inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
    gamescope
    atlauncher
    # (lutris.override {extraPkgs = p: [p.libnghttp2];})
    winetricks
    protontricks
  ];
}
