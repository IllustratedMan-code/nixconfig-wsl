{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  xdg.dataFile."typst/packages/local/assignments/1.0.0".source =
    ./assignments-typst;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initExtraBeforeCompInit = builtins.readFile ./zshrc.sh;

    shellAliases = {
      ll = "ls -l";
      nrs = "nixos-rebuild switch --flake ~/nixconfig#nixos";
      sudo = "sudo ";
      vim = "nvim";
      vi = "nvim";
      rg = "rga";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };

  };
  programs.git = {
    enable = true;
    lfs.enable = true;
  };
}
