From: Jens Schwepe <calimero@stonehenge.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: imac+elotouch
Date: Mon, 13 Sep 1999 16:36:18 +0200
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <99091316543101.02957@merlin>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
here we´ve got an iMac running current linuxppc-R5 with an Elo touchscreen
attached to usb-hub by a KeySpan serial/usb adapter.
There´s a (serial) module coming with normal X11, so I guess I just have to
find the right usb-port to use in the XF86-config.
I just hope that my guess was right, or do I have to use/program a special
usb-module to add to the kernel ?
I´m curious about that because of the Kernel Messages that follow:

(I cut out alot for your convenience)
-device tree used 35168 bytes
-Total memory = 96MB; using 512kB for hash table (at c0280000)
-Linux version 2.2.6-15apmac (root@video.linuxppc.org) (gcc version
-egcs-2.91.66 19990314 (egcs-1.1.2 release)) #1 Mon May 31 03:54:09 EDT 1999
-USB: Universal USB Driver v$Revision: 1.60 $ USB-OHCI: USB Open Host Controller
-Interface Driver USB-OHCI: Disabling OHCI legacy support on controller
-0xc5fd7140 USB-HUBM: Root hub at host 0
-USB-OHCI: Host Controller 0xc5fd7020 (0) at PCI bus 0 dev 20 fn 0 initialized
-USB-HUBD: UUSBD Hub Driver v$Revision: 1.36 $
-USB-HIDD: USB Human Interface Devices Driver v$Revision: 1.6 $
-USB-HIDBP: USB HID Boot Protocol Driver v$Revision: 1.10 $
-USB-HUBM: Starting kusbdd (pid 2)
-USB-HUBM: Device attachment detected on port 0 of hub 0xc5fd7040 (0 -1)
-USBD: Device id 0x80d59b8 (0 1) at port 0, hub (0 -1): (no information
-available) USB-HUBM: Hub at device id 0x080d59b8 (0 1), port 0
-USB-HUBM: Device attachment detected on port 1 of hub 0xc5fd7040 (0 -1)
-USB-HUBM: Ran out of hub queuing slots [with 5]
-USBD: Device id 0xe9471e58 (0 2) at port 1, hub (0 -1): Elo TouchSystems,
-Inc. Elo TouchSystems USB Touchscreen s/n 9800005C USB-HIDBP: Pretended to
-configure as HID Boot Protocol non-HIDBP class interface 0 of device (0 2)
-USB-HIDD: No physical descriptors on interface 0 of device id 0xe9471e58 (0 2)
-request_module[usb-hidd-parser]: Root fs not mounted USB-HIDD: Cannot load HID
-parser for processing HID report descriptors on interface 0 of device id
-0xe9471e58 (0 2) USB: generic.c:138: Assertion failed:
-((&tr->snode.usecnt)->counter) == 0 USBD: Error while trying to configure
-device (0 2) with driver `USB Human Interface Devices Driver v$Revision: 1.6 $'
-(0xc5fdb900): errno/usb -1/0. Trying next USBD: Device 0xc5fae240 (0 2) could
-not be configured; newly loaded drivers will try to configure it USB-HUBM:
-Device attachment detected on port 0 of hub 0xc5fae120 (0 1) USBD: Device id
-0xc3e494bb (0 3) at port 0, hub (0 1): Alps Electric M2452 USB-HIDBP: HID Boot
-Protocol Keyboard at interface 0 of device (0 3) USB-HUBM: Device attachment
-detected on port 1 of hub 0xc5fae120 (0 1) USBD: Device id 0x6411c619 (0 4) at
-port 1, hub (0 1): Logitech M4848 USB-HIDBP: HID Boot Protocol Mouse at
-interface 0 of device (0 4) USBD: 1 USB host found

thnx alot for your interest
  --
__________________________________

Jens Schwepe
Ahlhorner Str. 57A
27793 Wildeshausen
Tel.: 04431-92833
FAX : 04431-92834
Funk: 0172-4443443

Email:
schwepe@stonehenge.de

"Mutter ist der Name fuer Gott
 auf den Lippen und in den Herzen der Kinder dieser Welt."
(THE CROW)
___________________________________

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
