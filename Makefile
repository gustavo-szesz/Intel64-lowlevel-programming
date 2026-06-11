EXERCISE ?=

build:
	@if [ -z "$(EXERCISE)" ]; then \
		echo "Uso: make build EXERCISE=<pasta>"; \
		exit 1; \
	fi

	@ASM_FILE=$$(find $(EXERCISE) -maxdepth 1 -name "*.asm"); \
	BASENAME=$$(basename $$ASM_FILE .asm); \
	echo "Compilando $$ASM_FILE"; \
	nasm -felf64 $$ASM_FILE -o $(EXERCISE)/$$BASENAME.o; \
	ld -o $(EXERCISE)/$$BASENAME $(EXERCISE)/$$BASENAME.o

run:
	@if [ -z "$(EXERCISE)" ]; then \
		echo "Uso: make run EXERCISE=<pasta>"; \
		exit 1; \
	fi

	@ASM_FILE=$$(find $(EXERCISE) -maxdepth 1 -name "*.asm"); \
	BASENAME=$$(basename $$ASM_FILE .asm); \
	./$(EXERCISE)/$$BASENAME

clean:
	@if [ -z "$(EXERCISE)" ]; then \
		echo "Uso: make clean EXERCISE=<pasta>"; \
		exit 1; \
	fi

	@rm -f $(EXERCISE)/*.o
	@ASM_FILE=$$(find $(EXERCISE) -maxdepth 1 -name "*.asm"); \
	BASENAME=$$(basename $$ASM_FILE .asm); \
	rm -f $(EXERCISE)/$$BASENAME

list:
	@find . -maxdepth 1 -type d | grep -v '^\.$$'

.PHONY: build run clean list
