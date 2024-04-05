{lib, ...}:
# default configuration shared by all hosts
{
  imports = [
    ./security.nix
    ./users.nix
    ../nix
    ../programs/zsh.nix
  ];

  documentation.dev.enable = true;

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "nl_BE.UTF-8";
      LC_IDENTIFICATION = "nl_BE.UTF-8";
      LC_MEASUREMENT = "nl_BE.UTF-8";
      LC_MONETARY = "nl_BE.UTF-8";
      LC_NAME = "nl_BE.UTF-8";
      LC_NUMERIC = "nl_BE.UTF-8";
      LC_PAPER = "nl_BE.UTF-8";
      LC_TELEPHONE = "nl_BE.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
    # saves space
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "nl_BE.UTF-8/UTF-8"
    ];
  };

  # don't touch this
  system.stateVersion = lib.mkDefault "23.11";

  time.timeZone = lib.mkDefault "Europe/Brussels";

  # compresses half the ram for use as swap
  zramSwap.enable = false;
}
