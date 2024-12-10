{
  description = "tenzyu's configuration";

  outputs = inputs: let
    # deprecated {{{
    username = "tenzyu";
    hostname = "neko5";
    system = "x86_64-linux";
    specialArgs = {inherit inputs hostname username system;};
    # }}}

    forAllSystems = inputs.nixpkgs.lib.genAttrs [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
  in {
    formatter = forAllSystems (system: inputs.nixpkgs.legacyPackages.${system}.alejandra);

    nixosConfigurations.${hostname} = inputs.nixpkgs.lib.nixosSystem {
      inherit system specialArgs;

      modules = [
        ./profiles/neko5/hardware-configuration.nix
        ./profiles/neko5/configuration.nix
        ./profiles/neko5/home-configuration.nix
      ];
    };

    homeConfigurations.${username} = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      extraSpecialArgs = specialArgs;

      modules = [
        ./user/home/tenzyu.nix
      ];
    };
  };

  inputs = {
    ### nix ecosystem {{{
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ### }}}

    ### {{{
    # NOTE: This will require your git SSH access to the repo.
    #
    # WARNING:
    # Do NOT pin the `nixpkgs` input, as that will
    # declare the cache useless. If you do, you will have
    # to compile LLVM, Zig and Ghostty itself on your machine,
    # which will take a very very long time.
    #
    # Additionally, if you use NixOS, be sure to **NOT**
    # run `nixos-rebuild` as root! Root has a different Git config
    # that will ignore any SSH keys configured for the current user,
    # denying access to the repository.
    #
    # Instead, either run `nix flake update` or `nixos-rebuild build`
    # as the current user, and then run `sudo nixos-rebuild switch`.
    ghostty.url = "git+ssh://git@github.com/ghostty-org/ghostty";

    # NOTE: make sure to enable cachix first
    hyprland.url = "github:hyprwm/Hyprland";

    catppuccin.url = "github:catppuccin/nix";
    ### }}}
  };
}
