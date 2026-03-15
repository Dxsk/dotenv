{
  description = "Dragon Fire Desktop - CachyOS Dotfiles via Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    git-identity-manager = {
      url = "github:Dxsk/git-identity-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, git-identity-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      # Override via --impure, or set defaults in env.nix
      username = let env = builtins.getEnv "USER"; in if env != "" then env else "user";
      homeDir = let env = builtins.getEnv "HOME"; in if env != "" then env else "/home/${username}";
    in
    {
      homeConfigurations."${username}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
        extraSpecialArgs = { inherit inputs system username homeDir; };
      };
    };
}
