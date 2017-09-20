BUILDROOT_DIR=buildroot
BUILDROOT_IMAGES=$(BUILDROOT_DIR)/output/images
CONFIG_DIR=configs

qemu_img:
	cp $(CONFIG_DIR)/qemu_config $(BUILDROOT_DIR)/.config
	mkdir -p $(BUILDROOT_IMAGES)
	cp vexpress-v2p-ca9.dtb $(BUILDROOT_DIR)/output/images/
	make -C $(BUILDROOT_DIR) 

opi_lite:
	cp $(CONFIG_DIR)/opi_lite_config $(BUILDROOT_DIR)/.config
	rm -f build/patch/kernel/sun8i-default/0017-linux-sunxi-add-missing-compiler-gcc5.h-from-master.patch
	mkdir -p $(BUILDROOT_IMAGES)
	cp sun8i-h3-orangepi-lite.dtb $(BUILDROOT_DIR)/output/images/
	make -C $(BUILDROOT_DIR) 
	mv $(BUILDROOT_IMAGES)/sdcard.img .

run_qemu:
	cd $(BUILDROOT_IMAGES) ; \
	qemu-system-arm -kernel zImage -dtb vexpress-v2p-ca9.dtb -append "root=/dev/mmcblk0 console=ttyAMA0" --nographic -M vexpress-a9 -sd rootfs.ext2

clean:
	make -C $(BUILDROOT_DIR) clean
