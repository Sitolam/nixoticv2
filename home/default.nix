{ config, pkgs, inputs, ... }:

# graphical session configuration
# includes programs and services that work on both Wayland and X

let
  c = import ./colors.nix;
in
{
  imports = [
    ./cli.nix # base config
  ];

  # install programs
  home.packages = with pkgs; [
    # messaging
    discord
    element-desktop
    tdesktop
    # torrents
    transmission-remote-gtk
    # misc
    libnotify
  ];

  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      name = "Orchis-dark-compact";
      package = pkgs.orchis;
    };
  };

  # programs
  programs.alacritty = {
    enable = true;
    settings = {
      window.dynamic_padding = true;
      window.padding = {
        x = 5;
        y = 5;
      };
      scrolling.history = 10000;
      font =
        let
          font = "JetBrainsMono Nerd Font";
        in
        {
          normal.family = font;
          bold.family = font;
          italic.family = font;
          size = 11.0;
        };
      draw_bold_text_with_bright_colors = true;
      colors =
        let
          x = c: "0x${c}";
        in
        {
          primary = {
            background = x c.bg;
            foreground = x c.fg;
          };
          normal = {
            black = x c.normal.black;
            red = x c.normal.red;
            green = x c.normal.green;
            yellow = x c.normal.yellow;
            blue = x c.normal.blue;
            magenta = x c.normal.magenta;
            cyan = x c.normal.cyan;
            white = x c.normal.white;
          };
          bright = {
            black = x c.bright.black;
            red = x c.bright.red;
            green = x c.bright.green;
            yellow = x c.bright.yellow;
            blue = x c.bright.blue;
            magenta = x c.bright.magenta;
            cyan = x c.bright.cyan;
            white = x c.bright.white;
          };
        };
      background_opacity = 0.7;
      live_config_reload = true;
    };
  };

  programs.firefox = {
    enable = true;
    profiles.mihai.name = "mihai";
  };

  programs.kitty = {
    enable = true;
    font.name = "JetBrainsMono Nerd Font";
    font.size = 12;
    settings =
      let
        x = c: "#${c}";
      in
      {
        scrollback_lines = 10000;
        window_padding_width = 4;

        allow_remote_control = "yes";

        # colors
        background_opacity = "0.7";
        foreground = x c.fg;
        background = x c.bg;
        # black
        color0 = x c.normal.black;
        color8 = x c.bright.black;
        # red
        color1 = x c.normal.red;
        color9 = x c.bright.red;
        # green
        color2 = x c.normal.green;
        color10 = x c.bright.green;
        # yellow
        color3 = x c.normal.yellow;
        color11 = x c.bright.yellow;
        # blue
        color4 = x c.normal.blue;
        color12 = x c.bright.blue;
        # magenta
        color5 = x c.normal.magenta;
        color13 = x c.bright.magenta;
        # cyan
        color6 = x c.normal.cyan;
        color14 = x c.bright.cyan;
        # white
        color7 = x c.normal.white;
        color15 = x c.bright.white;
      };
  };

  programs.newsboat = {
    enable = false;
    autoReload = true;
    urls = [
      {
        title = "Drew DeVault's Blog";
        url = "https://drewdevault.com/blog/index.xml";
      }
      {
        title = "Christine Dodrill's Blog";
        url = "https://christine.website/blog.rss";
      }
    ];
  };

  programs.texlive = {
    enable = false;
    package = pkgs.texlive.combined.scheme-basic;
  };

  programs.zathura = {
    enable = true;
    options = {
      recolor = true;
      recolor-darkcolor = "#${c.fg}";
      recolor-lightcolor = "rgba(0,0,0,0)";
      default-bg = "rgba(0,0,0,0.7)";
      default-fg = "#${c.fg}";
    };
  };

  # services
  services = {
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      defaultCacheTtl = 300;
      defaultCacheTtlSsh = 300;
      pinentryFlavor = "gnome3";
    };

    syncthing.enable = true;

    udiskie.enable = true;
  };

  xresources.properties =
    let
      x = c: "#${c}";
    in
    {
      #! special
      "*.foreground" = x c.fg;
      "*.background" = x c.bg;

      # black
      "*.color0" = x c.normal.black;
      "*.color8" = x c.bright.black;
      # red
      "*.color1" = x c.normal.red;
      "*.color9" = x c.bright.red;
      # green
      "*.color2" = x c.normal.green;
      "*.color10" = x c.bright.green;
      # yellow
      "*.color3" = x c.normal.yellow;
      "*.color11" = x c.bright.yellow;
      # blue
      "*.color4" = x c.normal.blue;
      "*.color12" = x c.bright.blue;
      # magenta
      "*.color5" = x c.normal.magenta;
      "*.color13" = x c.bright.magenta;
      # cyan
      "*.color6" = x c.normal.cyan;
      "*.color14" = x c.bright.cyan;
      # white
      "*.color7" = x c.normal.white;
      "*.color15" = x c.bright.white;
    };
}
