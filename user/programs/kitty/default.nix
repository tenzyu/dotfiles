{
  config,
  pkgs,
  ...
}: {
  programs.kitty = {
    enable = true;
    # TODO: isNixos flag
    # package = config.lib.nixGL.wrap pkgs.kitty;

    settings = {
      font_family = "FiraCode Nerd Font";
      font_size = 12;
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      remember_window_size = "no";
      initial_window_width = 950;
      initial_window_height = 500;
      cursor_blink_interval = "0.5";
      cursor_stop_blinking_after = 1;
      scrollback_lines = 2000;
      wheel_scroll_min_lines = 1;
      enable_audio_bell = "no";
      window_padding_width = 10;
      hide_window_decorations = "yes";
      background_opacity = "0.85";
      dynamic_background_opacity = "yes";
      confirm_os_window_close = 0;
      selection_foreground = "none";
      selection_background = "none";
    };
  };
}
