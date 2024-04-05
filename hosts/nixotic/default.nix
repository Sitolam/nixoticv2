{
  self,
  # inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./powersave.nix
    ./nvidia.nix
  ];

  #  age.secrets.spotify = {
  #    file = "${self}/secrets/spotify.age";
  #    owner = "mihai";
  #    group = "users";
  #  };

  boot.kernelParams = [
    "quiet"
    "loglevel=3"
    # hopefully fixing nvme issues
    "nvme_core.default_ps_max_latency_us=0"
    "pcie_aspm=off"
  ];

  hardware = {
    enableRedistributableFirmware = true;
    opentabletdriver.enable = true;
    xpadneo.enable = true;
  };

  networking.hostName = "nixotic";

  # security.tpm2.enable = true;

  services = {
    fwupd.enable = true;
    # for SSD/NVME
    fstrim.enable = true;

    # howdy = {
    #   enable = true;
    #   package = inputs.nixpkgs-howdy.legacyPackages.${pkgs.system}.howdy;
    #   settings = {
    #     core = {
    #       no_confirmation = true;
    #       abort_if_ssh = true;
    #     };
    #     video.dark_threshold = 90;
    #   };
    # };

    # linux-enable-ir-emitter = {
    #   enable = true;
    #   package = inputs.nixpkgs-howdy.legacyPackages.${pkgs.system}.linux-enable-ir-emitter;
    # };
  };
}
