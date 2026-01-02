{
  description = "Assembly hacking development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            binutils  # gas, ld, objdump, readelf
            gdb       # debugger
            patchelf  # ELF manipulation
          ];

          shellHook = ''
            echo "To build all programs: make"
            echo "To clean: make clean"
            echo "For help: make help"
          '';
        };
      }
    );
}
