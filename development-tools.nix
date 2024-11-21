{ pkgs, ... }:
let
  python-with-my-packages = pkgs.python3.withPackages
    (p: with p; [ pandas numpy tqdm scipy openpyxl black ]);
in { environment.systemPackages = [ python-with-my-packages ]; }
