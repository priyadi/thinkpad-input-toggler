DIR=/usr/local/lib/input-toggler

all: keypress-listener

install: keypress-listener
	test -d /etc/interception/udevmon.d/ || (echo "No /etc/interception/udevmon.d/ directory found. Please install interception first." && exit 1)
	mkdir -p $(DIR)
	install -m 755 keypress-listener $(DIR)/keypress-listener
	install -m 755 input-toggler.sh $(DIR)/input-toggler.sh
	install -m 644 keyboard-on.png $(DIR)/keyboard-on.png
	install -m 644 keyboard-off.png $(DIR)/keyboard-off.png
	install -m 644 input-toggler.yaml /etc/interception/udevmon.d/input-toggler.yaml
	systemctl enable --now udevmon.service

keypress-listener: keypress-listener.c
	gcc -O2 -Wno-unused-result -o keypress-listener keypress-listener.c