Return-Path: <kernelppc@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by ozlabs.org (Postfix) with ESMTP id B4D56DDEBF
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Jan 2008 03:59:29 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so2752501uge.0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 03 Jan 2008 08:59:28 -0800 (PST)
From: "mojtaba" <kernelppc@gmail.com>
To: <linuxppc-embedded@ozlabs.org>
References: <169c03cb0801021932s6671526dve15d1948da52ae30@mail.gmail.com> 
In-Reply-To: 
Subject: RE: File system problem
Date: Thu, 3 Jan 2008 18:00:14 +0100
Message-ID: <004901c84e2a$1cac5c70$56051550$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Jean-Samuel,

Actually, I removed the console and null created by buildroot and create
them manually using make node. This time the system freezes at this =
point.
"Freeing unused kernel memory: 76k init"


loaded at:     00400000 004CE1A0                               =20
board data at: 004CC120 004CC19C                               =20
relocated to:  0040405C 004040D8                               =20
zimage at:     00404E94 004CB08A                               =20
avail ram:     004CF000 10000000                               =20

Linux/PPC load: console=3DttyS0,9600 root=3D/dev/xsa2 init=3D/bin/sh

Uncompressing Linux...done.                          =20
Now booting the kernel                     =20
Linux version 2.6.24-rc3 (mojtaba@ubuntu2) (gcc version 4.2.2) #1 Wed =
Jan 2
14:3

7:58 CET 2008            =20
Xilinx ML300 Reference System (Virtex-II Pro)

Zone PFN ranges:               =20
  DMA             0 ->    65536                              =20
  Normal      65536 ->    65536                              =20
  HighMem     655               =20
Movable zone start PFN for each node                                   =20
early_node_map[1] active PFN ranges                                  =20
    0:        0 ->    65536                          =20
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: =
65024

Kernel command line: console=3DttyS0,9600 root=3D/dev/xsa2 =
init=3D/bin/sh

Xilinx INTC #0 at 0x41200000 mapped to 0xEF5FE000

PID hash table entries: 1024 (order: 10, 4096 bytes)

Console: colour dummy device 80x25                                 =20
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)

Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)

Memory: 258048k available (1288k kernel code, 436k data, 76k init, 0k
highmem)

Mount-cache hash table entries: 512                                  =20
net_namespace: 64 bytes                      =20
NET: Registered protocol family 16                                 =20
sysctl table check failed: /kernel/l2cr .1.31 Missing strategy

Call Trace:          =20
[cfc1fe20] [c0008148] show_stack+0x58/0x188 (unreliable)

[cfc1fe68] [c0038908] set_fail+0x50/0x68

[cfc1fe80] [c0038f7c] sysctl_check_table+0x65c/0x6ac

[cfc1fee8] [c0038f8c] sysctl_check_table+0x66c/0x6ac

[cfc1ff50] [c0026c58] register_sysctl_table+0x64/0xb4

[cfc1ff50] [c0026c58] register_sysctl_table+0x64/0xb4

[cfc1ff70] [c019b228] kernel_init+0x104/0x290

[cfc1fff0] [c0004af8] kernel_thread+0x44/0x60

io scheduler noop registered                           =20
io scheduler anticipatory registered                                   =20
io scheduler deadline registered                               =20
io scheduler cfq registered (default)                                    =
=20
Generic RTC Driver v1.07                       =20
Macintosh non-volatile memory driver v1.1

Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing =
disabled

serial8250.0: ttyS0 at MMIO 0x40401003 (irq =3D 2) is a 16550A

console [ttyS0] enabled                      =20
xsysace xsysace.0: Xilinx SystemACE revision 1.0.12

xsysace xsysace.0: capacity: 1981728 sectors

 xsa: xsa1 xsa2 xsa3                   =20
Xilinx SystemACE device driver, major=3D254

i8042.c: No controller found.                            =20
mice: PS/2 mouse device common for all mice

VFS: Mounted root (ext2 filesystem) readonly.

Freeing unused kernel memory: 76k init                                   =
  =20
Warning: unable to open an initial console.

init has generated signal 11 but has no handler for it

Kernel panic - not syncing: Attempted to kill init!

Rebooting in 180 seconds..<NULL>                               =20

loaded at:     00400000 004CE1A0                               =20
board data at: 004CC120 004CC19C                               =20
relocated to:  0040405C 004040D8                               =20
zimage at:     00404E94 004CB08A                               =20
avail ram:     004CF000 10000000                               =20

Linux/PPC load: console=3DttyS0,9600 root=3D/dev/xsa2 init=3D/bin/sh

Uncompressing Linux...done.                          =20
Now booting the kernel                     =20
Linux version 2.6.24-rc3 (mojtaba@ubuntu2) (gcc version 4.2.2) #1 Wed =
Jan 2
14:3

7:58 CET 2008            =20
Xilinx ML300 Reference System (Virtex-II Pro)

Zone PFN ranges:               =20
  DMA             0 ->    65536                              =20
  Normal      65536 ->    65536                              =20
  HighMem     6553               =20
Movable zone start PFN for each node                                   =20
early_node_map[1] active PFN ranges                                  =20
    0:        0 ->    65536                          =20
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: =
65024

Kernel command line: console=3DttyS0,9600 root=3D/dev/xsa2 =
init=3D/bin/sh

Xilinx INTC #0 at 0x41200000 mapped to 0xEF5FE000

PID hash table entries: 1024 (order: 10, 4096 bytes)

Console: colour dummy device 80x25                                 =20
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)

Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)

Memory: 258048k available (1288k kernel code, 436k data, 76k init, 0k
highmem)

Mount-cache hash table entries: 512                                  =20
net_namespace: 64 bytes                      =20
NET: Registered protocol family 16                                 =20
sysctl table check failed: /kernel/l2cr .1.31 Missing strategy

Call Trace:          =20
[cfc1fe20] [c0008148] show_stack+0x58/0x188 (unreliable)

[cfc1fe68] [c0038908] set_fail+0x50/0x68

[cfc1fe80] [c0038f7c] sysctl_check_table+0x65c/0x6ac
[cfc1fee8] [c0038f8c] sysctl_check_table+0x66c/0x6ac
[cfc1ff50] [c0026c58] register_sysctl_table+0x64/0xb4
[cfc1ff68] [c019ed4c] register_ppc_htab_sysctl+0x18/0x2c
[cfc1ff70] [c019b228] kernel_init+0x104/0x290
[cfc1fff0] [c0004af8] kernel_thread+0x44/0x60
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Generic RTC Driver v1.07
Macintosh non-volatile memory driver v1.1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing =
disabled
serial8250.0: ttyS0 at MMIO 0x40401003 (irq =3D 2) is a 16550A
console [ttyS0] enabled
xsysace xsysace.0: Xilinx SystemACE revision 1.0.12
xsysace xsysace.0: capacity: 1981728 sectors
 xsa: xsa1 xsa2 xsa3
Xilinx SystemACE device driver, major=3D254
i8042.c: No controller found.
mice: PS/2 mouse device common for all mice
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 76k init


-----Original Message-----
From: mojtaba [mailto:kernelppc@gmail.com]=20
Sent: Thursday, January 03, 2008 4:58 PM
To: 'linuxppc-embedded@ozlabs.org'
Subject: RE: File system problem

Hi,
Thank you very much for your answers.

But I have both console and null in /dev.

-rw-rw-rw- 1 mojtaba mojtaba    0 2007-12-26 15:50 console
-rw-rw-rw- 1 mojtaba mojtaba    0 2007-12-26 15:50 null

They have been created by buildroot. Do I need to create them manually?
Actually the size of both of them is 0 and both are empty files. Is that =
a
problem?

Thank you in advance and best regards,
Mojtaba

-----Original Message-----
From: jsamch@gmail.com [mailto:jsamch@gmail.com] On Behalf Of =
Jean-Samuel
Chenard
Sent: Thursday, January 03, 2008 4:33 AM
To: linuxppc-embedded@ozlabs.org; kernelppc@gmail.com
Subject: RE: File system problem

> Date: Wed, 2 Jan 2008 19:50:13 +0100
> From: "mojtaba"
> I am trying to boot a root file system build by buildroot. But I got =
this
> error" init has generated signal 11 but has no handler for it".
>
> My kernel version is 2.6.24-rc3
> My target system is PPC 405 (XILINX VIRTEX II pro) I am using the
26-12-2007
> snapshot of buildroot.
[ ... ]
> Warning: unable to open an initial console.
> init has generated signal 11 but has no handler for it Kernel panic - =
not

Hi Mojtaba,

I got a similar error on my ML-310 when I tried a new root filesystem.
 As far as I recall, I needed to make sure that two entries existed in
/dev, namely:

crw-------    1 root     root       5,   1 Jan  1 05:18 console
crw-rw----    1 root     root       1,   3 Dec 10  2007 null

I think that you are missing /dev/console and then init cannot run
since it has nowhere to put its standard output.

You can make those by mounting your CF card on your development host
and (as root) make the nodes:

# mknod -m 660 /dev/console c 5 1
# mknod -m 660 /dev/null c 1 3

In my case, I use the UartLite (ttyUL0) serial port driver, but I'm
pretty sure this is going to fix the problem you are observing.

Regards,

Jean-Samuel
--=20
Ph.D. candidate
Integrated Microsystems Laboratory
McGill University, Montr=E9al, QC, CANADA
Web Page: http://chaos.ece.mcgill.ca
