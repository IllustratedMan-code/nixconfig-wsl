{ config, pkgs, ... }:

{
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";
  home.stateVersion = "24.05";

  xdg.dataFile."typst/packages/local/assignments/1.0.0".source =
    ./assignments-typst;

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
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraLuaConfig = ''
      vim.opt.termguicolors = false
    '';
  };
  programs.git = {
    enable = true;
    lfs.enable = true;
  };
}
