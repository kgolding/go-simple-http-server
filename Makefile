.PHONY: default
default: install

PREFIX = /usr

.PHONY: install-assets
install-assets:
	mkdir -p $(DESTDIR)$(PREFIX)/share/go-simple-http-server
	cp -f www/* $(DESTDIR)$(PREFIX)/share/go-simple-http-server/

.PHONY: install-unit
install-unit:
	mkdir -p $(DESTDIR)$(PREFIX)/lib/systemd/system
	sed -e "s%@DESTDIR@%$(DESTDIR)%g" \
		-e "s%@PREFIX@%$(PREFIX)%g" \
		systemd.service.in > $(DESTDIR)$(PREFIX)/lib/systemd/system/go-simple-http-server.service

.PHONY: install
install: install-assets install-unit
