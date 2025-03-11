{ config, pkgs, ... }:

{
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";
  home.stateVersion = "24.05";

  xdg.dataFile."typst/packages/local/assignments/1.0.0".source =
    ./assignments-typst;
  home.file."texmf/tex/latex/custom/assignments.cls" =
    ./assignments-latex/assignments.cls;

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

  programs.helix = {
    enable = true;
    settings = {
      theme = "everforest_light";
      editor.cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };
      editor.gutters = [ "line-numbers" "diff" ];

    };

    languages = {
      language = [
        {
          name = "python";
          language-servers = [ "pyright" ];
        }
        {
          name = "nix";
          formatter = { command = "nixpkgs-fmt"; };
        }
      ];
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
