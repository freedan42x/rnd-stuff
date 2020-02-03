{ config, pkgs, ... }:


let
  unstableTarball =
    fetchTarball
      https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
  all-hies = 
    import (fetchTarball 
      https://github.com/infinisil/all-hies/tarball/master) {};
in


{


  imports =
    [
      ./hardware-configuration.nix
    ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    extraModulePackages = [
      config.boot.kernelPackages.broadcom_sta
    ];
  };


  swapDevices = [
    { 
      device = "/var/swap"; 
      size = 8192; 
    } 
  ];  


  hardware = {
    enableAllFirmware = true;
    firmware = [
      pkgs.broadcom-bt-firmware
    ];
    pulseaudio.enable = true;
  };


  networking = {
    wireless.enable = true;
    hostName = "Nix-Chan";
  };


  time.timeZone = "Europe/Kiev";


  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };


  environment.systemPackages = with pkgs; [
    # Social
    hexchat
    slack
    discord
    unstable.tdesktop

    # Haskell
    unstable.ghc
    cabal-install
    unstable.haskellPackages.Agda
    haskellPackages.ieee754 
    haskellPackages.alex
    haskellPackages.happy
    haskellPackages.hoogle
    haskell.compiler.ghcjs
    cabal2nix
    unstable.stack
    (all-hies.selection { selector = p: { inherit (p) ghc865; }; })

    # Software
    zerotierone
    thunderbird
    kdeApplications.okular
    squirrel-sql
    google-chrome
    vscode
    atom
    emacs

    # Tools / Libraries
    flameshot
    git
    xsel
    zlib
    gtk-engine-murrine
    lxappearance-gtk3
    gdk_pixbuf
    adapta-gtk-theme
    cachix
    rofi
    xdotool
    xfce.xfce4_whiskermenu_plugin
    xfce.xfce4_cpugraph_plugin
    xfce.xfce4-hardware-monitor-plugin
    xfce.xfce4_timer_plugin
    xfce.xfce4taskmanager
    gnumake42
    gcc
    tree
    nodejs-11_x
    electron

    # Games
    unstable.openraPackages.mods.raclassic
  ];


  sound.enable = true;


  services = {
    xserver = {
      enable = true;
      layout = "us";
      xkbOptions = "eurosign:e";
      displayManager.sddm.enable = true;
      desktopManager = {
        xfce.enable = true;
        default = "xfce";
      };
    };
    zerotierone = {
      enable = true;
      joinNetworks = [ "0cccb752f7b87cb4" ];
    };
  };


  users.users.freedan42x = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };


  nix.trustedUsers = [ "root" "freedan42x" ];


  system.stateVersion = "19.03";


}
