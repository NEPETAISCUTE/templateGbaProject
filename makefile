#
# Makefile for first.gba
#

PATH := $(DEVKITARM)/bin:$(PATH)

# --- Project details -------------------------------------------------

PROJ    := nepanim
TARGET  := $(PROJ)

OBJS    := $(PROJ).o sprites.o sprPal.o

# --- Build defines ---------------------------------------------------

PREFIX  := arm-none-eabi-
CC      := $(PREFIX)gcc
LD      := $(PREFIX)gcc
OBJCOPY := $(PREFIX)objcopy
R2C := raw2c

ARCH    := -mthumb-interwork -mthumb
SPECS   := -specs=gba.specs

LIBS := -ltonc
LPATH := -L/opt/devkitpro/libtonc/lib

IPATH := -I/opt/devkitpro/libtonc/include

CFLAGS  := $(ARCH) -O2 -Wall -fno-strict-aliasing -Wno-array-bounds -Wno-stringop-overflow $(IPATH)
LDFLAGS := $(ARCH) $(SPECS) $(LPATH) $(LIBS)


.PHONY : build clean

# --- Build -----------------------------------------------------------
# Build process starts here!
build: $(TARGET).gba

# Strip and fix header (step 3,4)
$(TARGET).gba : $(TARGET).elf
	$(OBJCOPY) -v -O binary $< $@
	-@gbafix $@

# Link (step 2)
$(TARGET).elf : $(OBJS)
	$(LD) $^ $(LDFLAGS) -o $@

# Compile (step 1)
$(OBJS) : %.o : %.c
	$(CC) -c $< $(CFLAGS) -o $@

# generate C files (step 0)
$(CHARS).chr: 
	$(R2C) $<
		
# --- Clean -----------------------------------------------------------

clean : 
	@rm -fv *.gba
	@rm -fv *.elf
	@rm -fv *.o

#EOF