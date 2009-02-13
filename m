Return-Path: <aaronleefly@gmail.com>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.181])
	by ozlabs.org (Postfix) with ESMTP id ED32FDDD1C
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Feb 2009 04:10:22 +1100 (EST)
Received: by el-out-1112.google.com with SMTP id s27so880161ele.3
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 09:10:14 -0800 (PST)
From: "Li Jun (Aaron)" <aaronleefly@gmail.com>
To: <linuxppc-dev@ozlabs.org>
Subject: LINUX BOOT UP PROBLEM-PPC405 ML403
Date: Sat, 14 Feb 2009 01:10:08 +0800
Message-ID: <001101c98dfd$ed7993e0$c86cbba0$@com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0012_01C98E40.FB9CD3E0"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.

------=_NextPart_000_0012_01C98E40.FB9CD3E0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_0013_01C98E40.FB9CD3E0"


------=_NextPart_001_0013_01C98E40.FB9CD3E0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

When I try to boot the linux on the Xilinx virtex4 fx ml403 board.

 

The information below shows up:

----------------------------------------------------------------------------
-

Welcome to ML403 Linux 2.6

 

Starting system...

mounting /proc: done.

Mounting '/' read-write: done.

brining up loopback interface: done.

Mounting /tmp: done.

Starting syslogd: done.

Starting klogd: done.

Starting inetd: done.

System started.

starting pid 158, tty '': '/sbin/getty'

process '/sbin/getty -L ttyUL0 9600 vt100' (pid 158) exited. Scheduling it
for r

estart.

starting pid 163, tty '': '/sbin/getty'

process '/sbin/getty -L ttyUL0 9600 vt100' (pid 163) exited. Scheduling it
for r

estart.

starting pid 168, tty '': '/sbin/getty'

----------------------------------------------------------------------------
----------------------

I am using the uart lite 9600, and the inittab of my root file system is as
below:

::sysinit:/etc/init.d/rcS

#::askfirst:-/bin/sh

::ctrlaltdel:/sbin/reboot

::shutdown:/sbin/swapoff -a

::shutdown:/bin/umount -a -r

::restart:/sbin/init

::respawn:/sbin/getty -L ttyUL0 9600 vt100

 

Anybody can help?

 

Thanks!

 

Best regards,

Li Jun

 


------=_NextPart_001_0013_01C98E40.FB9CD3E0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:\5B8B\4F53;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:\5B8B\4F53;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@\5B8B\4F53";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
 /* Page Definitions */
 @page Section1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DZH-CN link=3Dblue vlink=3Dpurple =
style=3D'text-justify-trim:punctuation'>

<div class=3DSection1>

<p class=3DMsoNormal><span lang=3DEN-US>Hi,<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>When I try to boot the linux on =
the Xilinx virtex4
fx ml403 board.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>The information below shows =
up:<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
lang=3DEN-US>------------------------------------------------------------=
-----------------<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Welcome to ML403 Linux =
2.6<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Starting =
system...<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>mounting /proc: =
done.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Mounting '/' read-write: =
done.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>brining up loopback interface: =
done.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Mounting /tmp: =
done.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Starting syslogd: =
done.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Starting klogd: =
done.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Starting inetd: =
done.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>System =
started.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>starting pid 158, tty '': =
'/sbin/getty'<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'background:yellow;mso-highlight:
yellow'>process '/sbin/getty -L ttyUL0 9600 vt100' (pid 158) exited. =
Scheduling
it for r<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'background:yellow;mso-highlight:
yellow'>estart.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'background:yellow;mso-highlight:
yellow'>starting pid 163, tty '': '/sbin/getty'<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'background:yellow;mso-highlight:
yellow'>process '/sbin/getty -L ttyUL0 9600 vt100' (pid 163) exited. =
Scheduling
it for r<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'background:yellow;mso-highlight:
yellow'>estart.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'background:yellow;mso-highlight:
yellow'>starting pid 168, tty '': '/sbin/getty'</span><span =
lang=3DEN-US><o:p></o:p></span></p>

<p class=3DMsoNormal><span =
lang=3DEN-US>------------------------------------------------------------=
--------------------------------------<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>I am using the uart lite 9600, =
and the
inittab of my root file system is as below:<o:p></o:p></span></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-autospace:none'><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Courier =
New"'>::sysinit:/etc/init.d/rcS<o:p></o:p></span></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-autospace:none'><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Courier =
New"'>#::askfirst:-/bin/sh<o:p></o:p></span></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-autospace:none'><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Courier =
New"'>::ctrlaltdel:/sbin/reboot<o:p></o:p></span></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-autospace:none'><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Courier =
New"'>::shutdown:/sbin/swapoff
-a<o:p></o:p></span></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-autospace:none'><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Courier =
New"'>::shutdown:/bin/umount
-a -r<o:p></o:p></span></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;text-autospace:none'><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Courier =
New"'>::restart:/sbin/init<o:p></o:p></span></p>

<div =
style=3D'mso-element:para-border-div;border:none;border-bottom:solid =
windowtext 1.0pt;
padding:0cm 0cm 1.0pt 0cm'>

<p class=3DMsoNormal style=3D'border:none;padding:0cm'><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>::respawn:/sbin/getty -L ttyUL0
9600 vt100</span><span lang=3DEN-US><o:p></o:p></span></p>

</div>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Anybody can =
help?<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Thanks!<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Best =
regards,<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Li Jun<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

</div>

</body>

</html>

------=_NextPart_001_0013_01C98E40.FB9CD3E0--

------=_NextPart_000_0012_01C98E40.FB9CD3E0
Content-Type: text/plain;
	name="mylinuxboot_2.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="mylinuxboot_2.txt"

Welcome to the Xilinx Virtex-4 ML403 Evaluation Platform Bootloader =
Menu!

Please choose a demo by typing in the number of the demo you want to use

Or select a demo using the directional buttons and LCD or VGA display
  (Then press the center button to start the selected demo)

1. Virtex-4 Slide Show
2. Web Server Demo
3. Linux Demo
4. QNX Demo
5. USB Demo
6. My own ACE file
7. Load/Restore Flash Images

loaded at:     00400000 004F819C
board data at: 004F6120 004F619C
relocated to:  00404060 004040DC
zimage at:     00404E49 004F5B98
avail ram:     004F9000 04000000

Linux/PPC load: console=3DttyUL0,9600 ip=3Don root=3D/dev/xsa2 rw
Uncompressing Linux...done.
Now booting the kernel
[    0.000000] Linux version 2.6.23-rc2 (liju0010@rplinx1) (gcc version =
4.1.0) #
19 Thu Feb 12 17:02:45 SGT 2009
[    0.000000] Xilinx ML403 Reference System (Virtex-4 FX)
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->    16384
[    0.000000]   Normal      16384 ->    16384
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->    16384
[    0.000000] Built 1 zonelists in Zone order.  Total pages: 16256
[    0.000000] Kernel command line: console=3DttyUL0,9600 ip=3Don =
root=3D/dev/xsa2 rw
[    0.000000] Xilinx INTC #0 at 0x81800000 mapped to 0xFDFFF000
[    0.000000] PID hash table entries: 256 (order: 8, 1024 bytes)
[    0.000341] Console: colour dummy device 80x25
[    0.001046] Dentry cache hash table entries: 8192 (order: 3, 32768 =
bytes)
[    0.002459] Inode-cache hash table entries: 4096 (order: 2, 16384 =
bytes)
[    0.027896] Memory: 62780k available (1524k kernel code, 500k data, =
96k init,
 0k highmem)
[    0.113286] Mount-cache hash table entries: 512
[    0.121929] NET: Registered protocol family 16
[    0.163221] NET: Registered protocol family 2
[    0.196707] IP route cache hash table entries: 1024 (order: 0, 4096 =
bytes)
[    0.197982] TCP established hash table entries: 2048 (order: 2, 16384 =
bytes)
[    0.198606] TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
[    0.198995] TCP: Hash tables configured (established 2048 bind 2048)
[    0.199071] TCP reno registered
[    0.220331] io scheduler noop registered
[    0.220426] io scheduler anticipatory registered (default)
[    0.220499] io scheduler deadline registered
[    0.220823] io scheduler cfq registered
[    0.309153] uartlite.0: ttyUL0 at MMIO 0x84000000 (irq =3D 1) is a =
uartlite
[    0.310642] console [ttyUL0] enabled
[    2.270738] RAMDISK driver initialized: 16 RAM disks of 65536K size =
1024 bloc
ksize
[    2.363600] xsysace xsysace.0: Xilinx SystemACE revision 1.0.12
[    2.435897] xsysace xsysace.0: capacity: 1019088 sectors
[    2.500435]  xsa: xsa1 xsa2
[    2.544344] tun: Universal TUN/TAP device driver, 1.6
[    2.605239] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    2.682049] mice: PS/2 mouse device common for all mice
[    2.745383] TCP cubic registered
[    2.784516] NET: Registered protocol family 1
[    2.837079] NET: Registered protocol family 17
[    3.393776] IP-Config: No network devices available.
[    3.922144] kjournald starting.  Commit interval 5 seconds
[    3.988474] EXT3-fs warning: mounting unchecked fs, running e2fsck is =
recomme
nded
[    4.117526] EXT3 FS on xsa2, internal journal
[    4.170014] EXT3-fs: recovery complete.
[    4.254147] EXT3-fs: mounted filesystem with ordered data mode.
[    4.325712] VFS: Mounted root (ext3 filesystem).
[    4.382081] Freeing unused kernel memory: 96k init
init started: BusyBox v1.7.2 (2007-12-21 20:42:03 SGT)
starting pid 142, tty '': '/etc/init.d/rcS'

Welcome to ML403 Linux 2.6

Starting system...
mounting /proc: done.
Mounting '/' read-write: done.
brining up loopback interface: done.
Mounting /tmp: done.
Starting syslogd: done.
Starting klogd: done.
Starting inetd: done.
System started.
starting pid 158, tty '': '/sbin/getty'
process '/sbin/getty -L ttyUL0 9600 vt100' (pid 158) exited. Scheduling =
it for r
estart.
starting pid 163, tty '': '/sbin/getty'
process '/sbin/getty -L ttyUL0 9600 vt100' (pid 163) exited. Scheduling =
it for r
estart.
starting pid 168, tty '': '/sbin/getty'
------=_NextPart_000_0012_01C98E40.FB9CD3E0--
