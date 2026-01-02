# assembly-hacking

Various scripts and assembly templates for debugging and learning x86-64 assembly.

## Structure

- `src/` - Assembly source files (.asm)
- `Makefile` - Build system for compiling assembly programs
- `flake.nix` - Nix development environment with all necessary tools

## Sample Programs

- `hello.asm` - Simple "Hello, World!" program demonstrating syscalls
- `simd_example.asm` - SIMD vector operations using SSE instructions
- `arithmetic.asm` - Basic arithmetic operations (add, multiply)

## Building

### Using Nix (Recommended)

If you have Nix with flakes enabled:

```bash
# Enter the development environment
nix develop

# Build all programs
make

# Build a specific program
make hello

# Clean build artifacts
make clean
```

### Using System Tools

If you have `as` and `ld` installed:

```bash
# Build all programs
make

# Build a specific program
make hello

# Clean build artifacts
make clean
```

## Development Environment

The Nix flake provides:
- **as** (gas) - GNU Assembler
- **ld** - GNU Linker
- **gdb** - GNU Debugger
- **objdump** - Display information from object files
- **readelf** - Display information about ELF files
- **patchelf** - Modify ELF executables and libraries

## Running Programs

After building, you can run the programs directly:

```bash
./hello
./simd_example
./arithmetic
```

## Debugging

Use `gdb` to debug programs:

```bash
gdb ./hello
```

Inspect object files:

```bash
objdump -d hello.o
readelf -a hello
```
