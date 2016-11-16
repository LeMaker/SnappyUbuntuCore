include common.mk

KERNEL_SNAP_VERSION := `cat $(KERNEL_SRC)/prime/meta/snap.yaml | grep version: | awk '{print $$2}'`
KERNEL_SNAP := lemaker-guitar-kernel_$(KERNEL_SNAP_VERSION)_armhf.snap

all: build

clean:
	rm -f lemaker-guitar-kernel*.snap
	if [ -d $(KERNEL_SRC) ] ; then cd $(KERNEL_SRC); snapcraft clean; fi

distclean: clean
	rm -rf $(wildcard $(KERNEL_SRC))
	
build:
	if [ ! -d $(KERNEL_SRC) ] ; then git clone $(KERNEL_REPO) -b $(KERNEL_BRANCH) kernel; fi
	cd $(KERNEL_SRC); snapcraft clean; snapcraft login; snapcraft --target-arch armhf snap; snapcraft logout
	cp $(KERNEL_SRC)/$(KERNEL_SNAP) $(OUTPUT_DIR)
	
.PHONY: build
