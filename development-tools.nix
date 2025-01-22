{ pkgs, ... }:
let
  python-with-my-packages = pkgs.python3.withPackages
    (p: with p; [ pandas numpy tqdm scipy openpyxl black matplotlib ]);
  R-with-my-packages = pkgs.rWrapper.override {
    packages = with pkgs.rPackages; [ ggplot2 dplyr tidyverse ];
  };
  RStudio-with-my-packages = pkgs.rstudioWrapper.override {
    packages = with pkgs.rPackages; [ ggplot2 dplyr xts ];
  };
  sbcl-with-my-packages = pkgs.sbcl.withPackages
    (ps: with ps; [ bordeaux-threads usocket cl-json flexi-streams ]);
in {
  environment.systemPackages = [
    python-with-my-packages
    R-with-my-packages
    RStudio-with-my-packages
    sbcl-with-my-packages
  ];
}
