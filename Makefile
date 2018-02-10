BUILDROOT_DIR=buildroot
BUILDROOT_IMAGES=$(BUILDROOT_DIR)/output/images
CONFIG_DIR=configs

#qemu_img:
#	cp $(CONFIG_DIR)/qemu_config $(BUILDROOT_DIR)/.config
#	mkdir -p $(BUILDROOT_IMAGES)
#	cp vexpress-v2p-ca9.dtb $(BUILDROOT_DIR)/output/images/
#	make -C $(BUILDROOT_DIR) 
all: opi_lite

opi_lite:
	cp $(CONFIG_DIR)/opi_lite_config $(BUILDROOT_DIR)/.config
	make -C $(BUILDROOT_DIR)
	mv $(BUILDROOT_IMAGES)/sdcard.img .

#run_qemu:
#	cd $(BUILDROOT_IMAGES) ; \
#	qemu-system-arm -kernel zImage -dtb vexpress-v2p-ca9.dtb -append "root=/dev/mmcblk0 console=ttyAMA0" --nographic -M vexpress-a9 -sd rootfs.ext2

menuconfig:
	make -C $(BUILDROOT_DIR) menuconfig

clean:
	make -C $(BUILDROOT_DIR) clean
