inputs:

let
  inherit (inputs) self;
  inherit (self.lib) mkHome extraSpecialArgs;

  sharedModules = [
    ../.
    ../files
    ../shell
    ../games.nix
    ../media.nix
    ../editors/helix
  ];

  homeImports = {
    "mihai@io" = sharedModules ++ [ ../wayland ./mihai-io ../editors/emacs ];
    "mihai@tosh" = sharedModules ++ [ ../wayland ./mihai-tosh ];
    server = [ ../cli.nix ];
  };
in
{
  inherit homeImports extraSpecialArgs;

  homeConfigurations = {
    "mihai@io" = mkHome {
      username = "mihai";
      extraModules = homeImports."mihai@io";
    };

    "mihai@tosh" = mkHome {
      username = "mihai";
      extraModules = homeImports."mihai@tosh";
    };

    "server" = mkHome {
      username = "mihai";
      extraModules = homeImports.server;
    };
  };
}