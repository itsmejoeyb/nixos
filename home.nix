{ config, pkgs, ... }:

{
  home.username = "joey";
  home.homeDirectory = "/home/joey";
  nixpkgs.config.allowUnfree = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    initLua = builtins.readFile ./nvim/init.lua;
  };

  xdg.configFile."nvim/lua" = { source = ./nvim/lua; recursive = true; };
  xdg.configFile."nvim/colors" = { source = ./nvim/colors; recursive = true; };
  xdg.configFile."nvim/plugin" = { source = ./nvim/plugin; recursive = true; };
  xdg.configFile."nvim/lazy-lock.json".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/nvim/lazy-lock.json";
  xdg.configFile."nvim/.stylua.toml".source = ./nvim/.stylua.toml;

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    SUDO_EDITOR = "nvim";
  };

  programs.dank-material-shell = {
    enable = true;
  };

  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    discord
    alacritty
    pnpm
    nodejs
    localsend
    codex
    tmux
    ghostty
    fzf
    zsh-autosuggestions
    zsh-syntax-highlighting
    libwebp
    gnumake
    gcc
    unzip
    ripgrep
    fd
    lazygit
    stylua
    tree-sitter
    python3
  ];
}
