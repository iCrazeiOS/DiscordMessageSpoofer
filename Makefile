export PREFIX=$(THEOS)/toolchain/Xcode11.xctoolchain/usr/bin/
export SDKVERSION = 12.2
export ARCHS = arm64 arm64e

INSTALL_TARGET_PROCESSES = Discord


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = DiscordMessageSpoofer

DiscordMessageSpoofer_FILES = Tweak.xm
DiscordMessageSpoofer_FRAMEWORKS = UIKit
DiscordMessageSpoofer_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
