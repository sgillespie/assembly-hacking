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
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            # Assembler (GNU assembler)
            binutils  # Provides 'as' (gas), 'ld', and other tools
            
            # Debugger
            gdb
            
            # Binary inspection tools
            # Note: objdump and readelf are part of binutils
            
            # ELF manipulation
            patchelf
          ];

          shellHook = ''
            echo "Assembly hacking development environment"
            echo "Available tools:"
            echo "  as       - GNU assembler (gas)"
            echo "  ld       - GNU linker"
            echo "  gdb      - GNU debugger"
            echo "  objdump  - Display information from object files"
            echo "  readelf  - Display information about ELF files"
            echo "  patchelf - Modify ELF executables and libraries"
            echo ""
            echo "To build all programs: make"
            echo "To clean: make clean"
            echo "For help: make help"
          '';
        };
      }
    );
}
