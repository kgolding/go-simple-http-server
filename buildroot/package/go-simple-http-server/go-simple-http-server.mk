################################################################################
#
# Go Simple Http Server
#
################################################################################

GO_SIMPLE_HTTP_SERVER_VERSION = 0.4
GO_SIMPLE_HTTP_SERVER_SITE = $(call github,kgolding,go-simple-http-server,$(GO_SIMPLE_HTTP_SERVER_VERSION))
GO_SIMPLE_HTTP_SERVER_LICENSE = MIT
GO_SIMPLE_HTTP_SERVER_LICENSE_FILES = LICENSE

GO_SIMPLE_HTTP_SERVER_DESTDIR = /usr/share/go-simple-http-server

# Remove go DWARF dubgging table to shrink the binary a bit
GO_SIMPLE_HTTP_SERVER_LDFLAGS = -s -w

define GO_SIMPLE_HTTP_SERVER_PRE_INSTALL_TARGET_HOOKS
    # Create directory
    $(INSTALL) -d $(TARGET_DIR)$(GO_SIMPLE_HTTP_SERVER_DESTDIR)/www/
    # Install www assets
    find $(@D)/www/ -type f -exec $(INSTALL) -m 0644 -D "{}" $(TARGET_DIR)$(GO_SIMPLE_HTTP_SERVER_DESTDIR)/www/ \;
endef

# Add Systemd service
define GO_SIMPLE_HTTP_SERVER_INSTALL_INIT_SYSTEMD
    # Install systemd service file
    $(INSTALL) -D -m 0644 $(@D)/systemd.service \
        $(TARGET_DIR)/usr/lib/systemd/system/go-simple-http-server.service

    # Enable the service to auto start by symlinking the file
    mkdir -p $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants
    ln -sf /usr/lib/systemd/system/go-simple-http-server.service \
        $(TARGET_DIR)//etc/systemd/system/multi-user.target.wants/go-simple-http-server.service
endef

# The binary will be installed as /usr/bin/go-simple-http-server
$(eval $(golang-package))
