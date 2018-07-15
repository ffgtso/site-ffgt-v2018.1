##	gluon site.mk makefile example

##	GLUON_SITE_PACKAGES
#		specify gluon/openwrt packages to include here
#		The gluon-mesh-batman-adv-* package must come first because of the dependency resolution

GLUON_SITE_PACKAGES := \
	gluon-mesh-batman-adv-14 \
	gluon-node-info-ffgt \
	gluon-respondd \
	gluon-autoupdater \
	ffgt-geolocate \
	ffgt-siteselect \
	ffgt-banner \
	ffgt-setup-mode \
	gluon-luci-wifi-config-ffgt \
	gluon-luci-portconfig-ffgt \
	gluon-config-mode-autoupdater-ffgt \
	gluon-config-mode-contact-info \
	gluon-config-mode-core \
	gluon-config-mode-geo-location-ffgt \
	gluon-config-mode-hostname-ffgt \
	gluon-config-mode-mesh-vpn \
	gluon-ebtables-filter-multicast \
	gluon-ebtables-filter-ra-dhcp \
	gluon-luci-admin \
	gluon-luci-private-wifi \
	ffrn-lowmem-patches \
	gluon-next-node \
	gluon-mesh-vpn-fastd \
	gluon-radvd \
	gluon-setup-mode \
	gluon-status-page-ffgt \
	gluon-ssid-changer \
	gluon-ffgt-hacks \
	kmod-l2tp kmod-l2tp-ip kmod-l2tp-eth ip-full \
	haveged \
	iptables \
	iwinfo

# 2017-11-26 left out for now:
#	ffho-autoupdater-wifi-fallback \
#	ffho-luci-autoupdater-wifi-fallback \


USB_BASIC := \
	kmod-usb-core \
	kmod-usb2 \
	kmod-usb-hid


USB_NIC := \
	kmod-usb-net \
	kmod-usb-net-asix \
	kmod-usb-net-rtl8150 \
	kmod-usb-net-rtl8152 \
	kmod-usb-net-dm9601-ether

ifeq ($(GLUON_TARGET),x86-generic)
	GLUON_SITE_PACKAGES += \
		$(USB_BASIC) \
		kmod-usb-ohci-pci \
		resize2fs \
		$(USB_NIC)
endif

ifeq ($(GLUON_TARGET),x86-64)
	GLUON_SITE_PACKAGES += \
		$(USB_BASIC) \
		$(USB_NIC) \
		resize2fs \
		kmod-igb #APU2
endif

##	DEFAULT_GLUON_RELEASE
#		version string to use for images
#		gluon relies on
#			opkg compare-versions "$1" '>>' "$2"
#		to decide if a version is newer or not.

DEFAULT_GLUON_RELEASE := 0.6+exp$(shell date '+%Y%m%d')


##	GLUON_RELEASE
#		call make with custom GLUON_RELEASE flag, to use your own release version scheme.
#		e.g.:
#			$ make images GLUON_RELEASE=23.42+5
#		would generate images named like this:
#			gluon-ff%site_code%-23.42+5-%router_model%.bin

# Allow overriding the release number from the command line
GLUON_RELEASE ?= $(DEFAULT_GLUON_RELEASE)

# Default priority for updates.
GLUON_PRIORITY ?= 0

# Region code required for some images; supported values: us eu
GLUON_REGION ?= eu

# Languages to include
GLUON_LANGS ?= en de
GLUON_ATH10K_MESH ?= 11s