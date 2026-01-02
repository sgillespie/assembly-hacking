AS = as
LD = ld

ASFLAGS = 
LDFLAGS = -lc

SRC_DIR = src
BIN_DIR = bin

# Find all .asm files in the source directory
ASM_SOURCES = $(wildcard $(SRC_DIR)/*.asm)
# Object files
OBJECTS = $(patsubst $(SRC_DIR)/%.asm,$(BIN_DIR)/%.o,$(ASM_SOURCES))

.PRECIOUS: $(OBJECTS)

# Generate target names (remove .asm extension)
TARGETS = $(patsubst $(SRC_DIR)/%.asm,$(BIN_DIR)/%,$(ASM_SOURCES))

# Default target - build all executables
.PHONY: all
all: $(BIN_DIR) $(TARGETS)

# Create bin directory if it doesn't exist
$(BIN_DIR):
	mkdir -p $(BIN_DIR)

# assemble .asm files to .o files
$(BIN_DIR)/%.o: $(SRC_DIR)/%.asm
	$(AS) $(ASFLAGS) $< -o $@

# link .o files to executables
$(BIN_DIR)/%: $(BIN_DIR)/%.o
	$(LD) $(LDFLAGS) $< -o $@

.PHONY: clean
clean:
	rm -r $(BIN_DIR)

# Help target
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  all     - Build all assembly programs (default)"
	@echo "  clean   - Remove object files and executables"
	@echo "  help    - Show this help message"
	@echo ""
	@echo "Individual targets: $(TARGETS)"
