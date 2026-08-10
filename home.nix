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
};

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
  ];
}
