let
  screenshotarea = "hyprctl keyword animation 'fadeOut,0,0,default'; grimblast --notify copysave area; hyprctl keyword animation 'fadeOut,1,4,default'";

  # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
  workspaces = builtins.concatLists (builtins.genList (
      x: let
        ws = let
          c = (x + 1) / 10;
        in
          builtins.toString (x + 1 - (c * 10));
      in [
        "$mod, ${ws}, workspace, ${toString (x + 1)}"
        "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
        "$mod ALT, ${ws}, movetoworkspacesilent, ${toString (x + 1)}"
      ]
    )
    10);
in {
  wayland.windowManager.hyprland.settings = {
    # mouse movements
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
      "$mod ALT, mouse:272, resizewindow"
    ];

    # binds
    bind = let
      monocle = "dwindle:no_gaps_when_only";
    in
      [
        # Window/Session actions
        "$mod, Q, killactive," # killactive, kill the window on focus
        "$mod SHIFT, E, exec, pkill Hyprland" # kill hyprland session
        "$mod, W, togglefloating," # toggle the window on focus to float
        "$mod, ENTER, fullscreen," # toggle the window on focus to fullscreen
        "$mod, G, togglegroup," # toggle the window on focus to group
        "$mod SHIFT, N, changegroupactive, f" # change the active group
        "$mod SHIFT, P, changegroupactive, b" # change the active group
        "$mod, L, exec, loginctl lock-session" # lock screen
        "$mod, Backspace, exec, wlogout -p layer-shell" # logout menu

        # Application shortcuts
        "$mod, T, exec, run-as-service foot" # open terminal
        "$mod, E, exec, run-as-service yazi" # open file manager
        "$mod, C, exec, run-as-service vscode" # open vscode
        "$mod, F, exec, run-as-service firefox" # open browser

        # toggle "monocle" (no_gaps_when_only)
        "$mod, M, exec, hyprctl keyword ${monocle} $(($(hyprctl getoption ${monocle} -j | jaq -r '.int') ^ 1))"

        # Screenshot/Screencapture
        # stop animations while screenshotting; makes black border go away
        ", Print, exec, ${screenshotarea}"
        "$mod SHIFT, R, exec, ${screenshotarea}" # select area to screen capture

        "CTRL, Print, exec, grimblast --notify --cursor copysave output"
        "$mod SHIFT CTRL, R, exec, grimblast --notify --cursor copysave output" # screen captures everything

        "ALT, Print, exec, grimblast --notify --cursor copysave screen"
        "$mod SHIFT ALT, R, exec, grimblast --notify --cursor copysave screen" # screen captures the active screen

        "$mod, O, exec, run-as-service wl-ocr" # select # select area to perform OCR on

        # Move focus with mod + arrow keys
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, slash, movefocus, u" # (for smaller keyboards)
        "$mod, down, movefocus, d"
        "ALT, Tab, movefocus, d"

        # move to the first empty workspace instantly with mod + CTRL + [↓]
        "$mod CTRL, down, worspace, empty"

        # Move active window around current workspace with mod + SHIFT + CTRL [↔ ↑↓]
        "$mod SHIFT CTRL, left, movewindow, l"
        "$mod SHIFT CTRL, right, movewindow, r"
        "$mod SHIFT CTRL, up, movewindow, u"
        "$mod SHIFT CTRL, slash, movewindow, u" # (for smaller keyboards))
        "$mod SHIFT CTRL, down, movewindow, d"

        # Scroll trhough existing workspace with mod + scroll
        "$mod, mouse_down, workspace, m+1"
        "$mod, mouse_up, workspace, m-1"

        # Special workspaces (scratchpad)
        "$mod, M, movetoworkspace, special"
        "$mod, S, togglespecialworkspace"

        # cycle workspaces
        "$mod, bracketleft, workspace, m-1"
        "$mod, bracketright, workspace, m+1"

        # cycle monitors
        "$mod SHIFT, bracketleft, focusmonitor, l"
        "$mod SHIFT, bracketright, focusmonitor, r"

        # send focused workspace to left/right monitors
        "$mod SHIFT ALT, bracketleft, movecurrentworkspacetomonitor, l"
        "$mod SHIFT ALT, bracketright, movecurrentworkspacetomonitor, r"

        # Toggle layout
        "$mod, J, togglesplit,"
        "$mod, P, pseudo,"
      ]
      ++ workspaces; # Switch workspaces with mod + workspace and move active window to a workspace with mod + SHIFT + workspace

    binde = [
      # Resize windows
      "$mod SHIFT, right, resizeactive, 10 0"
      "$mod SHIFT, left, resizeactive, -10 0"
      "$mod SHIFT, up, resizeactive, 0 -10"
      "$mod SHIFT, slash, resizeactive, 0 -10"
      "$mod SHIFT, down, resizeactive, 0 10"
    ];

    bindr = [
      # launcher
      "$mod, SUPER_L, exec, pkill .anyrun-wrapped || run-as-service anyrun"
    ];

    bindl = [
      # media controls
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
      ", XF86AudioNext, exec, playerctl next"

      # volume
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ];

    bindle = [
      # volume
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%-"

      # backlight
      ", XF86MonBrightnessUp, exec, brillo -q -u 300000 -A 5"
      ", XF86MonBrightnessDown, exec, brillo -q -u 300000 -U 5"
    ];
  };
}
