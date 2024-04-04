{
  self,
  inputs,
  homeImports,
  ...
}: {
  flake.nixosConfigurations = let
    # shorten paths
    inherit (inputs.nixpkgs.lib) nixosSystem;
    howdy = inputs.nixpkgs-howdy;
    mod = "${self}/system";

    # get the basic config to build on top of
    inherit (import "${self}/system") desktop laptop;

    # get these into the module system
    specialArgs = {inherit inputs self;};
  in {
    nixotic = nixosSystem {
      inherit specialArgs;
      modules =
        laptop
        ++ [
          ./nixotic
          "${mod}/core/boot.nix"

          "${mod}/programs/gamemode.nix"
          "${mod}/programs/hyprland.nix"
          "${mod}/programs/steam.nix"

          "${mod}/network/spotify.nix"
          # "${mod}/network/syncthing.nix"

          "${mod}/services/kmonad"
          "${mod}/services/gnome-services.nix"
          "${mod}/services/location.nix"

          {
            home-manager = {
              users.sitolam.imports = homeImports."sitolam@nixotic";
              extraSpecialArgs = specialArgs;
            };
          }

          # enable unmerged Howdy
          {disabledModules = ["security/pam.nix"];}
          "${howdy}/nixos/modules/security/pam.nix"
          "${howdy}/nixos/modules/services/security/howdy"
          "${howdy}/nixos/modules/services/misc/linux-enable-ir-emitter.nix"

          inputs.agenix.nixosModules.default
          inputs.chaotic.nixosModules.default
        ];
    };

    # rog = nixosSystem {
    #   inherit specialArgs;
    #   modules =
    #     laptop
    #     ++ [
    #       ./rog
    #       "${mod}/core/lanzaboote.nix"

    #       "${mod}/programs/gamemode.nix"
    #       "${mod}/programs/hyprland.nix"
    #       "${mod}/programs/steam.nix"

    #       "${mod}/services/kmonad"
    #       {home-manager.users.mihai.imports = homeImports."mihai@rog";}
    #     ];
    # };

    # kiiro = nixosSystem {
    #   inherit specialArgs;
    #   modules =
    #     desktop
    #     ++ [
    #       ./kiiro
    #       {home-manager.users.mihai.imports = homeImports.server;}
    #     ];
    # };
  };
}
