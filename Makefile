# Configurations: 用于交叉编译
# Toolchain location:
TOOLCHAIN = /workspace/gopbuild-4.14.98-2.3.3-ga/sdk/a64/toolchain
# Sysroot location: It should contain the header and library for target platform (e.g. ARM):
# ROOTFS = /workspace/gopbuild-4.14.98-2.3.3-ga/sdk/a64/target-rootfs
ROOTFS = /

# CROSS_COMPILE = $(TOOLCHAIN)/usr/bin/aarch64-poky-linux/aarch64-poky-linux-
CROSS_COMPILE = aarch64-none-linux-gnu-
# INC = -I$(ROOTFS)/usr/src/kernel/include \
        -I$(ROOTFS)/usr/include \
        -I$(ROOTFS)/usr/lib \
        -I$(ROOTFS)/usr/include/drm \
        -I$(ROOTFS)/usr/include/libdrm

# SYS_ROOT = --sysroot=$(ROOTFS)

TARGET = drmcap
OBJ = drmcap.o

CC = $(CROSS_COMPILE)gcc
CPP = $(CROSS_COMPILE)g++
LD = $(CROSS_COMPILE)gcc

LIBDRM = `pkg-config --cflags --libs libdrm`

# CFLAGS
CFLAGS = $(SYS_ROOT) $(INC) -DLINUX $(LIBDRM)

# LDFLAGS
LDFLAGS = $(SYS_ROOT) $(LIBDRM)

%.o:%.c
	$(CC) $(CFLAGS) -Wall -c $(@D)/$(<F) -o $(@D)/$(@F) -O2 -g

all: $(TARGET)

$(TARGET): $(OBJ)
	#$(CC) -o $(TARGET) $(OBJ) $(LDFLAGS) -ldrm -lm 
	$(CC) -o $(TARGET) $(OBJ) $(LDFLAGS) -ldrm -lm -static

.PHONY: clean

clean:
	- rm -f $(TARGET) $(OBJ)

