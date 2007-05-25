Return-Path: <claus.gindhart@kontron.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: console problem while initializing form ramdisk
Date: Fri, 25 May 2007 09:09:03 +0200
Message-ID: <C488F5B273CCC74F891363809F6EB4CD296278@kom-mailsrv2.kontron-modular.com>
From: "Claus Gindhart" <claus.gindhart@kontron.com>
To: <angelalinyao@163.com>,
	<Linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
did you create a /dev/console device node ?

crw------- 1 root tty 5, 1 May 25 07:36 /dev/console

Even, if you are working with udev, you have to create this mode =
manually, because its needed at an early stage of the init process.

--=20
Mit freundlichen Gruessen / Best regards

Claus Gindhart
Kontron Modular Computers GmbH
Sudetenstrasse 7, 87600 Kaufbeuren, Germany
Phone: +49 (8341) 803 374
Fax: +49 (8341) 803 40 374
www.kontron.com


-----Original Message-----
From: linuxppc-embedded-bounces+claus.gindhart=3Dkontron.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+claus.gindhart=3Dkontron.com@ozlabs.org=
]
On Behalf Of angelalinyao@163.com
Sent: Freitag, 25. Mai 2007 09:05
To: Linuxppc-embedded@ozlabs.org
Subject: console problem while initializing form ramdisk


Hi,all
    I am trying to run linux2.6 on Xilinx ML403.I have builded and =
loaded zImage.initrd.elf successfully into the board and when the kernel =
was booting to the point initializing form ramdisk,I got the problem as =
follow.

loaded at:     00400000 0063213C                               =20
board data at: 00630124 0063013C                               =20
relocated to:  004050E8 00405100                               =20
zimage at:     004058B9 004C645D                               =20
initrd at:     004C7000 0062FE44                               =20
avail ram:     00633000 04000000                               =20

Linux/PPC load: console=3DttyS0,9600 root=3D/dev/ram rw                  =
                                =20
Uncompressing Linux...done.                          =20
Now booting the kernel                     =20
Linux version 2.6.17-rc4-smp (linyao@linux-177) (gcc version 3.3.1 =
(MontaVista 3                                                            =
                   =20
.3.1-3.0.10.0300532 2003-12-24)) #4 Fri May 25 11:29:41 CST 2007         =
                                                      =20
Xilinx ML403 Reference System (Virtex-4 FX)                              =
            =20
Built 1 zonelists                =20
Kernel command line: console=3DttyS0,9600 root=3D/dev/ram rw             =
                                          =20
Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFE000                        =
                        =20
PID hash table entries: 512 (order: 9, 2048 bytes)                       =
                          =20
Console: colour dummy device 80x25                                 =20
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)            =
                                                =20
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)             =
                                              =20
Memory: 61420k available (1240k kernel code, 716k data, 84k init, 0k =
highmem)                                                                 =
           =20
Security Framework v1.0.0 initialized                                    =
=20
Mount-cache hash table entries: 512                                  =20
checking if image is initramfs...it isn't (no cpio magic); looks like an =
initrd                                                                   =
           =20
Freeing initrd memory: 1443k freed                                 =20
VFS: Disk quotas dquot_6.5.1                           =20
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Macintosh non-volatile memory driver v1.1
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 1 ports, IRQ sharing =
disabled
serial8250.0: ttyS0 at MMIO 0x40401003 (irq =3D 1) is a 16450
RAMDISK driver initialized: 1 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
i8042.c: No controller found.
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
md: bitmap version 4.39
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 84k init
Warning: unable to open an initial console.

      I configured bootloader like this:
[*]Default bootloader kernel arguments
(console=3DttyS0,9600 root=3Ddev/ram rw)Initial kernel command string

      I don't know where the problem comes from and how to solve it.
      Any help from you is appreciated.Thank you!
                                                                         =
                                                linyao

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

Kontron Modular Computers GmbH
Geschftsfhrer: Ulrich Gehrmann, Thomas Sabisch=20
Sitz der Gesellschaft: Kaufbeuren / Rechtsform: GmbH=20
Amtsgericht Kempten / HRB Nr. 6195
=20
Kontron Modular Computers GmbH
Managing Directors: Ulrich Gehrmann, Thomas Sabisch=20
Registered Office: Kaufbeuren, Germany / Legal Form: GmbH
Local District Court: Kempten / Trade Register No. 6195=20
