{
  pkgs,
  config,
  ...
}: {
  boot = {
    # bootspec.enable = true;

    # initrd = {
      # systemd.enable = true;
      # supportedFilesystems = ["ext4"];
    # };

    # use latest kernel
    kernelPackages = pkgs.linuxPackages_latest;

    consoleLogLevel = 3;
    kernelParams = [
      "quiet"
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
    ];

    loader = {
    	timeout = 7;
    	grub = {
    		enable = true;
    		devices = ["nodev"];
    		efiSupport = true;
    		useOSProber = true;
    		configurationLimit = 5;
    		default = "0";
    		extraEntries = ''
    			menuentry "Reboot" {
    				reboot
    			}
    			menuentry "Poweroff" {
    				halt
    			};
    		'';
    	};
    	efi = {
    		canTouchEfiVariables = true;
    		efiSysMountPoint = "/boot";
    	};
    };
  };
  environment.systemPackages = [config.boot.kernelPackages.cpupower];
}
