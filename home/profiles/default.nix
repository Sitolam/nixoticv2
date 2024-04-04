{
  self,
  inputs,
  ...
}: let
  # get these into the module system
  extraSpecialArgs = {inherit inputs self;};

  homeImports = {
    "sitolam@nixotic" = [
      ../.
      ./nixotic
    ];
    "sitolam@rog" = [
      ../.
      ./rog
    ];
    server = [
      ../.
      ./server
    ];
  };

  inherit (inputs.hm.lib) homeManagerConfiguration;

  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
in {
  # we need to pass this to NixOS' HM module
  _module.args = {inherit homeImports;};

  flake = {
    homeConfigurations = {
      "sitolam_nixotic" = homeManagerConfiguration {
        modules = homeImports."sitolam@nixotic";
        inherit pkgs extraSpecialArgs;
      };

      "sitolam_rog" = homeManagerConfiguration {
        modules = homeImports."sitolam@rog";
        inherit pkgs extraSpecialArgs;
      };

      server = homeManagerConfiguration {
        modules = homeImports.server;
        inherit pkgs extraSpecialArgs;
      };
    };
  };
}
