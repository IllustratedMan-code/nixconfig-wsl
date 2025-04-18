# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  imports = [ ./development-tools.nix ];
  wsl.defaultUser = "nixos";
  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
    zathura
    nixd
    nixfmt-classic
    qmk
    pdftk
    ghostscript_headless
    ripgrep-all
    ocrmypdf
    pandoc
    mdbook
    nil
    typst
    zip
  ];
  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    corefonts
    vistafonts
  ];
  environment.sessionVariables = { QT_QPA_PLATFORM = "wayland"; };
  programs.direnv.enable = true;
  programs.zsh.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  hardware.keyboard.qmk.enable = true;
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
