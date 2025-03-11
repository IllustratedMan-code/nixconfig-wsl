{ pkgs, ... }:
let
  rpackages = with pkgs.rPackages; [
    ggplot2
    dplyr
    tidyverse
    languageserver
    httpgd
    MASS
    shiny
    DT
    printr
    pROC
  ];
  python-with-my-packages = pkgs.python3.withPackages (p:
    with p; [
      pandas
      numpy
      tqdm
      scipy
      openpyxl
      black
      matplotlib
      p.altair
      polars
      ipykernel
      pyarrow
    ]);
  R-with-my-packages = pkgs.rWrapper.override { packages = rpackages; };
  RStudio-with-my-packages =
    pkgs.rstudioWrapper.override { packages = rpackages; };
  sbcl-with-my-packages = pkgs.sbcl.withPackages
    (ps: with ps; [ bordeaux-threads usocket cl-json flexi-streams ]);
in {
  virtualisation.docker.enable = true;
  users.users.nixos.extraGroups = [ "docker" ];
  environment.systemPackages = [
    pkgs.pyright
    python-with-my-packages
    R-with-my-packages
    RStudio-with-my-packages
    sbcl-with-my-packages
    pkgs.gnumake
    pkgs.texliveFull
  ];
}
