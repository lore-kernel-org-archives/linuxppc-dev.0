MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: More USB questions (for the MPC8xx)
Date: Wed, 21 Mar 2001 19:23:49 -0000
Message-ID: <EADB10BAC266A14A85ECBF8686A73E310A911B@kolkrabbi.flaga.is>
From: =?iso-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kd@flaga.is>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks for the answare.
I got a USB hub and now the hub and mouse are dected correctly.

K.D.

>From dmesg:

usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
m8xxhci: initializing controller
m8xxhci_setup()
usb.c: new USB bus registered, assigned bus number 1
m8xxhci_start_controller()
m8xxhci: MPC823B mask 1
m8xxhci: USING BRG4 for USB clock!
cp_brgc4 0x0 before
cp_brgc4 0x10000
ring sizes: rx 32, tx 40
USB microcode patch installed
m8xxhci_init() enable USB controller
m8xxhci_timer_start()
intfreq 48, busfreq 48, count 3000
m8xxhci: USING TIMER1 FOR SOF!
usb bus: idle
m8xxhci: initializing done
m8xxhci: control thread starting
m8xxhci: device found!
m8xxhci_connect_device()
m8xxhci_alloc_dev(usb_dev=c01d9400)
usb.c: kmalloc IF c01b94e0, numif 1
usb.c: new device strings: Mfr=0, Product=0, SerialNumber=0
hub.c: USB hub found
hub.c: 4 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: power on to power good time: 100ms
hub.c: hub controller current requirement: 100mA
hub.c: port removable status: RRRR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface c01b94e0
usb.c: registered new driver hid
hub.c: port 1 connection change
hub.c: port 1, portstatus 301, change 1, 1.5 Mb/s
m8xxhci_alloc_dev(usb_dev=c01d9c00)
hub.c: port 1, portstatus 303, change 10, 1.5 Mb/s
hub.c: USB new device connect on bus1/1, assigned device number 2
usb.c: kmalloc IF c01b9820, numif 1
usb.c: skipped 1 class/vendor specific interface descriptors
usb.c: new device strings: Mfr=1, Product=2, SerialNumber=0
usb.c: USB device number 2 default language ID 0x409
Manufacturer: Microsoft
Product: Microsoft IntelliMouse® Explorer
complete urb c01d8d30, actual_length 0, status -1
unlink_urb(urb=c01d8d30,qtype=2) status -110
unlink_urb(urb=c01d8d30) done
input0: USB HID v0.01 Mouse [Microsoft Microsoft IntelliMouse® Explorer]
on usb1
:2.0
usb.c: hid driver claimed interface c01b9820

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
