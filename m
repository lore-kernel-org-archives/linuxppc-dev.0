Message-ID: <3E535227.B4F4FFE4@bmrtech.com>
Date: Wed, 19 Feb 2003 17:45:11 +0800
From: Jikun Sun <jack.sun@bmrtech.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: m8xxhci.o USB driver problems on RPXLITE_DW board
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sir,

We are testing usb driver 'm8xxhci.o' of Monta Vista Linux3.0 on
RPXLITE_DW board. But it could not work properly.
The following are configration and log information:

Board: RPXLITE_DW  LITE23EZ6
Software: MontaVista Linux 3.0 embedded-planet-rpxlite LSP

Linux kernel configuration for usb drivers
# USB support
CONFIG_USB=y
# Miscellaneous USB options
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
# USB Controllers
CONFIG_USB_MPC8xx=y

Linux kernel bootup information:
...
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
m8xxhci: initializing controller
usb.c: new USB bus registered, assigned bus number 1
m8xxhci: MPC823e (mask 1)
hub.c: USB hub found
hub.c: 1 port detected
m8xxhci: initializing done
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 2048)
Sending BOOTP requests . OK
IP-Config: Got BOOTP answer from 192.9.200.83, my address is
192.9.200.145
IP-Config: Complete:
      device=eth0, addr=192.9.200.145, mask=255.255.255.0,
gw=255.255.255.255,
     host=192.9.200.145, domain=, nis-domain=(none),
     bootserver=192.9.200.83, rootserver=192.9.200.83,
rootpath=/opt/hardhat/det
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.9.200.83
Looking up port of RPC 100005/1 on 192.9.200.83
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 80k init
wait_for_qe(qe=c02ca17c) done; urb 00000000, status -110
wait_for_qe(qe=c02ca17c) done; urb 00000000, status -110
wait_for_qe(qe=c02ca17c) done; urb 00000000, status -110
wait_for_qe(qe=c02ca17c) done; urb 00000000, status -110
wait_for_qe(qe=c02ca17c) done; urb 00000000, status -110
wait_for_qe(qe=c02ca17c) done; urb 00000000, status -110
wait_for_qe(qe=c02ca17c) done; urb 00000000, status -110
wait_for_qe(qe=c02ca17c) done; urb 00000000, status -110
wait_for_qe(qe=c02ca17c) done; urb 00000000, status -110
wait_for_qe(qe=c02ca17c) done; urb 00000000, status -110


Why wait_for_qe occurs continuesly?
How could I driver a usbmouse or usb storage on the board?
Please help me some sources of m8xxhci.o.


Jikun Sun

BMR

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
