Date: 18 Feb 2002 07:11:12 -0000
Message-ID: <20020218071112.18296.qmail@mailweb19.rediffmail.com>
MIME-Version: 1.0
From: "Sarnath  Kannan" <sparc64@rediffmail.com>
Reply-To: "Sarnath  Kannan" <sparc64@rediffmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: USB in RPXLITE 823
Content-type: text/plain;
	charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I compiled the Monta 2.4.2 kernel with USB support
and run it on RPXLite with MPC 823. The kernel panicked.

I wanted to test the USB part alone. Hence i copied the usb.c to arc/ppc/8xx_io and m8xxhci.c to drivers/usb
and made appropriate changes to kernel config.in files
and tried to compile it (i did these to 2.4.7 tree).
When i do this the kernel comes up and when it tries to
NFS mount the root file system
it hangs (or) stalls , i dont know.

Am i missing something ?
Or am i doing something terrible wrong ?

Thanks for any help
Sarnath

================= Start Dump =================
Linux/PPC load: console=ttyS0,9600 root=/dev/nfs nfsroot=192.168.201.86:/rpx_roo
t ip=192.168.201.87:192.168.201.86:192.168.201.86:255.255.255.0:milo::
Uncompressing Linux... done.
Now booting the kernel
Linux version 2.4.7-timesys-2.1 (root@boost) (gcc version 2.95.2 19991024 (relea
se)) #80 Mon Feb 18 12:03:04 IST 2002
USB uCode patch installed
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,9600 root=/dev/nfs nfsroot=192.168.201.86:/rp
x_root ip=192.168.201.87:192.168.201.86:192.168.201.86:255.255.255.0:milo::
Decrementer Frequency = 240000000/60
Memory: 57204k available (1720k kernel code, 968k data, 56k init, 0k highmem)
Calibrating delay loop... 63.69 BogoMIPS
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
devfs: v0.107 (20010709) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
pty: 256 Unix98 ptys configured
block: queued sectors max/low 37821kB/12607kB, 128 slots per queue
RAMDISK driver
 RAM disks of 4096K size 1024 blocksize
eth0: CPM ENET Version 0.2 on SCC2, 00:10:ec:00:2c:31
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
m8xxhci: initializing controller
usb.c: new USB bus registered, assigned bus number 1
m8xxhci: MPC823B mask 1
m8xxhci: initializing done
active_qe 00000000
delay_qe_list 00000000
qtype 0:
qtype 1:
qtype 2:
qtype 3:
frame lists: current 00000000, next 00000000
current: 00000000; <unset>
usb.c: registered new driver usbdevfs
usb.c: null device being checked!!!
usb.c: registered new driver hub
usb.c: null device being checked!!!
usb.c: registered new driver keyboard
usb.c: null device being checked!!!
usbkbd.c: :USB HID Boot Protocol keyboard driver
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP TCP, IGMP
IP: routing cache hash table of 8 buckets, 2Kbytes
TCP: Hash tables configured (established 64 bind 115)
IP-Config: Complete:
      device=eth0, addr=192.168.201.87, mask=255.255.255.0, gw=192.168.201.86,
     host=milo, domain=, nis-domain=(none),
     bootserver=192.168.201.86, rootserver=192.168.201.86, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.168.201.86

================= End Dump =================


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
