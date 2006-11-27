Return-Path: <abdul.rahaman@semindia.in>
Received: from almach.lunarpages.com (almach.lunarpages.com [209.200.240.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 43BEC67C2B
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 27 Nov 2006 21:31:17 +1100 (EST)
Message-ID: <004501c7120b$ebca9190$ab80a8c0@xaltedindia.net>
From: "Abdul Rahaman" <abdul.rahaman@semindia.in>
To: <linuxppc-embedded@ozlabs.org>
References: <f4d44c7f0611262040y244f4042lc6c45ceb606a6d99@mail.gmail.com>
Subject: fialing @ executing /sbin/int in main.c
Date: Mon, 27 Nov 2006 15:37:50 +0530
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0042_01C71239.FF11F030"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0042_01C71239.FF11F030
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi All,

        Iam trying to port linux on an mpc8xx processor. Iam using =
2.6.10 kernel and busybox 1.0.0.The system is booting up but its failing =
at the "init".For some reasons it says Kernel panic - not syncing: No =
init found.  Try passing init=3D option to kernel.

 <0>Rebooting in 180 second

Pls check below the entire text.

Linux version 2.6.10  (gcc version 3.4.1) #83 Wed=20

=20

Nov

22 16:02:46 IST 2006

On node 0 totalpages: 8192

  DMA zone: 8192 pages, LIFO batch:2

  Normal zone: 0 pages, LIFO batch:1

  HighMem zone: 0 pages, LIFO batch:1

Built 1 zonelists

Kernel command line: console=3DttyCPM,38400=3Dconsole=3DttyCPM debug =
root=3D/dev/ram0 rw

PID hash table entries: 256 (order: 8, 4096 bytes)

Decrementer Frequency =3D 495000000/60

m8xx_wdt: wdt disabled (SYPCR: 0xFFFFFF88)

Warning: real time clock seems stuck!

Console: colour dummy device 80x25

Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)

Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)

Memory: 29592k available (1572k kernel code, 360k data, 92k init, 0k =
highmem)

Calibrating delay loop... 261.12 BogoMIPS (lpj=3D130560)

before dcache_init

after dcache_init

Mount-cache hash table entries: 512 (order: 0, 4096 bytes)

Before SysFs_init

After SysFs_init

After init_rootfs

after init_mount_tree

inside proc_root_init

after proc_misc_init

checking if image is initramfs...it isn't (no cpio magic); looks like an =
initrd

Freeing initrd memory: 746k freed

after SK_Init

before register file system in sockets

after register file system in sockets

after kernel mount in sockets

NET: Registered protocol family 16

JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.

Software Watchdog Timer: 0.07 initialized. soft_noboot=3D0 =
soft_margin=3D60 sec (nowayout=3D 0)

Serial: CPM driver $Revision: 0.01 $

ttyCPM0 at MMIO 0xf000a80 (irq =3D 20) is a CPM UART

io scheduler noop registered

io scheduler anticipatory registered

io scheduler deadline registered

io scheduler cfq registered

RAMDISK driver initialized: 4 RAM disks of 8192K size 1024 blocksize

loop: loaded (max 8 devices)

elevator: using anticipatory as default io scheduler

mice: PS/2 mouse device common for all mice

eth0: FEC ENET Version 0.2, FEC irq 3, MII irq 4, addr 00:a0:1e:a8:7b:cb

u32 classifier

    OLD policer on

NET: Registered protocol family 2

IP: routing cache hash table of 512 buckets, 4Kbytes

TCP: Hash tables configured (established 2048 bind 4096)

NET: Registered protocol family 17

RAMDISK: Compressed image found at block 0

VFS: Mounted root (ext2 filesystem).

Freeing unused kernel memory: 92k init

Kernel panic - not syncing: No init found.  Try passing init=3D option =
to kernel.

 <0>Rebooting in 180 second

=20

I have tried googling,but haven't got any suitable  answer to my =
problem.Please help,as Iam not able to figure out why the "init" is =
failing.

=20

Sunil


------=_NextPart_000_0042_01C71239.FF11F030
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1578" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi All,</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial =
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Iam=20
trying to port linux on an mpc8xx processor. Iam using 2.6.10 kernel and =
busybox=20
1.0.0.The system is booting up but its failing at the =93init=94.For =
some reasons it=20
says Kernel panic - not syncing: No init found.&nbsp; Try passing =
init=3D option=20
to kernel.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&lt;0&gt;Rebooting in 180 =
second</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Pls check below the entire =
text.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Linux version 2.6.10&nbsp; (gcc version =
3.4.1) #83=20
Wed </FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Nov</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>22 16:02:46 IST 2006</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>On node 0 totalpages: 8192</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp; DMA zone: 8192 pages, LIFO=20
batch:2</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp; Normal zone: 0 pages, LIFO=20
batch:1</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp; HighMem zone: 0 pages, LIFO=20
batch:1</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Built 1 zonelists</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Kernel command line:=20
console=3DttyCPM,38400=3Dconsole=3DttyCPM debug root=3D/dev/ram0 =
rw</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>PID hash table entries: 256 (order: 8, =
4096=20
bytes)</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Decrementer Frequency =3D =
495000000/60</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>m8xx_wdt: wdt disabled (SYPCR:=20
0xFFFFFF88)</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Warning: real time clock seems =
stuck!</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Console: colour dummy device =
80x25</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Dentry cache hash table entries: 8192 =
(order: 3,=20
32768 bytes)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Inode-cache hash table entries: 4096 =
(order: 2,=20
16384 bytes)</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Memory: 29592k available (1572k kernel =
code, 360k=20
data, 92k init, 0k highmem)</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Calibrating delay loop... 261.12 =
BogoMIPS=20
(lpj=3D130560)</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>before dcache_init</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>after dcache_init</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Mount-cache hash table entries: 512 =
(order: 0, 4096=20
bytes)</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Before SysFs_init</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>After SysFs_init</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>After init_rootfs</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>after init_mount_tree</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>inside proc_root_init</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>after proc_misc_init</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>checking if image is initramfs...it =
isn't (no cpio=20
magic); looks like an initrd</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Freeing initrd memory: 746k =
freed</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>after SK_Init</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>before register file system in =
sockets</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>after register file system in =
sockets</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>after kernel mount in =
sockets</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>NET: Registered protocol family =
16</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>JFFS2 version 2.2. (NAND) (C) 2001-2003 =
Red Hat,=20
Inc.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Software Watchdog Timer: 0.07 =
initialized.=20
soft_noboot=3D0 soft_margin=3D60 sec (nowayout=3D 0)</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Serial: CPM driver $Revision: 0.01 =
$</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>ttyCPM0 at MMIO 0xf000a80 (irq =3D 20) =
is a CPM=20
UART</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>io scheduler noop =
registered</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>io scheduler anticipatory =
registered</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>io scheduler deadline =
registered</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>io scheduler cfq =
registered</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>RAMDISK driver initialized: 4 RAM disks =
of 8192K=20
size 1024 blocksize</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>loop: loaded (max 8 =
devices)</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>elevator: using anticipatory as default =
io=20
scheduler</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>mice: PS/2 mouse device common for all=20
mice</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>eth0: FEC ENET Version 0.2, FEC irq 3, =
MII irq 4,=20
addr 00:a0:1e:a8:7b:cb</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>u32 classifier</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp; OLD policer =
on</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>NET: Registered protocol family =
2</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>IP: routing cache hash table of 512 =
buckets,=20
4Kbytes</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>TCP: Hash tables configured =
(established 2048 bind=20
4096)</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>NET: Registered protocol family =
17</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>RAMDISK: Compressed image found at =
block=20
0</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>VFS: Mounted root (ext2 =
filesystem).</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Freeing unused kernel memory: 92k =
init</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Kernel panic - not syncing: No init =
found.&nbsp;=20
Try passing init=3D option to kernel.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&lt;0&gt;Rebooting in 180 =
second</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I have tried googling,but haven=92t got =
any=20
suitable&nbsp; answer to my problem.Please help,as Iam not able to =
figure out=20
why the =93init=94 is failing.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Sunil</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0042_01C71239.FF11F030--
