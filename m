Date: Sat, 5 May 2001 10:49:00 -0700 (PDT)
From: Paul White <pwhite@networkrobots.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: IP Connection Tracking & Net Filter
Message-ID: <Pine.LNX.4.21.0105051045550.13276-100000@stimpy.networkrobots.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


All,

Does anyone have IP Connection Tracking and Netfilter working on LinuxPPC?

I am currently using Kernel version 2.4.0 (drived from the linuxppc_24 tree).
It is compiled for an MPC7410 embedded platform.  When compiling connection
tracking and netfilter in, I receive the following error at bootup:

Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: enabling 8 loop devices
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0xf1800020 (irq = 7) is a ST16650
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
SCSI subsystem driver Revision: 1.00
request_module[scsi_hostadapter]: Root fs not mounted
request_module[scsi_hostadapter]: Root fs not mounted
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb.c: registered new driver hid
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
gal_eth_open : Assigned IRQ 8 to gal_eth0
ip_conntrack (256 buckets, 2048 max)
Kernel panic: Received Error on CPU BUS

In interrupt handler - not syncing
Rebooting in 180 seconds..

Thanks...

Paul W.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
