{ pkgs, ... }:

{
  home.username = "joey";
  home.homeDirectory = "/home/joey";

  home.stateVersion = "26.05";

  home.packages = with pkgs; [
  ];
}
