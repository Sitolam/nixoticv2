{
  lib,
  self,
  inputs,
  ...
}: {
  imports = [
    ./specialisations.nix
    ./terminal
    ./services/ags
    inputs.nur.hmModules.nur
    inputs.matugen.nixosModules.default
    inputs.nix-index-db.hmModules.nix-index
    inputs.hyprlock.homeManagerModules.default
    inputs.hypridle.homeManagerModules.default
    self.nixosModules.theme
  ];

  home = {
    username = "sitolam";
    homeDirectory = "/home/sitolam";
    stateVersion = "23.11";
    extraOutputsToInstall = ["doc" "devdoc"];
  };

  # disable manuals as nmd fails to build often
  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  # let HM manage itself when in standalone mode
  programs.home-manager.enable = true;

  nixpkgs.overlays = [
    inputs.nur.overlay
    (final: prev: {
      lib = prev.lib // {colors = import "${self}/lib/colors" lib;};
    })
  ];
}
