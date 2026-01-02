# Makefile for assembly-hacking project
# Builds x86-64 assembly files for learning and experimentation

# Assembler and linker
AS = as
LD = ld

# Flags
ASFLAGS = 
LDFLAGS = 

# Source directory
SRC_DIR = src

# Find all .asm files in the source directory
ASM_SOURCES = $(wildcard $(SRC_DIR)/*.asm)

# Generate target names (remove .asm extension)
TARGETS = $(patsubst $(SRC_DIR)/%.asm,%,$(ASM_SOURCES))

# Object files
OBJECTS = $(patsubst $(SRC_DIR)/%.asm,%.o,$(ASM_SOURCES))

# Default target - build all executables
.PHONY: all
all: $(TARGETS)

# Pattern rule to assemble .asm files to .o files
%.o: $(SRC_DIR)/%.asm
	$(AS) $(ASFLAGS) $< -o $@

# Pattern rule to link .o files to executables
%: %.o
	$(LD) $(LDFLAGS) $< -o $@

# Clean target - remove all object files and executables
.PHONY: clean
clean:
	rm -f $(OBJECTS) $(TARGETS)

# Help target
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  all     - Build all assembly programs (default)"
	@echo "  clean   - Remove object files and executables"
	@echo "  help    - Show this help message"
	@echo ""
	@echo "Individual targets: $(TARGETS)"
	@echo ""
	@echo "Example usage:"
	@echo "  make              # Build all programs"
	@echo "  make hello        # Build just the hello program"
	@echo "  make clean        # Clean up build artifacts"
