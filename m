Return-Path: <DaveLiu@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 4935B67B73
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 13:42:12 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k8L51m9v001065
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 23:01:48 -0600 (MDT)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k8L3g232013950
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 22:42:04 -0500 (CDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6DD2F.E60CA62F"
Subject: RE: Linux on custom Xilinx board with PPC405 hangs on boot
Date: Thu, 21 Sep 2006 11:42:00 +0800
Message-ID: <995B09A8299C2C44B59866F6391D263516BFCF@zch01exm21.fsl.freescale.net>
In-Reply-To: <36468a5c0609200216n753d69b0hdf8ff2cb53714f90@mail.gmail.com>
From: "Liu Dave-r63238" <DaveLiu@freescale.com>
To: "Peter N. Andreasen" <peterarbejde@gmail.com>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6DD2F.E60CA62F
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


=20

	I have a custom Xilinx FPGA board which is similar to ML300 but
uses Uartllite and does not have disk or display.
	When I start the Linux kernel I end up with an exception during
the probe for Flash - I think.=20
	I have added a bunch of printk lines in order to see what is
happening but I am a little stuck at the moment.=20
	The Flash chip is an AM29LV320D 4Mbyte in 16-bit access mode,
and it sits on address 0xFF80'0000
	This is what I get on my terminal. I would be happy to hear your
advice.
	Peter
=09
=09
=09
	loaded at:     00400000 004CF1E0=20
	board data at: 004CC138 004CC150
	relocated to:  004052F4 0040530C
	zimage at:     00405801 00472CFB
	initrd at:     00473000 004CB2FF
	avail ram:     004D0000 02000000
=09
	Linux/PPC load: root=3D/dev/ram rw console=3Dttl0=20
	Uncompressing Linux...done.
	Now booting the kernel
=09
	id mach(): done
	MMU:enter
	MMU:hw init
	MMU:mapin
	MMU:mapin_ram done
	MMU:setio
	MMU:exit
=09
	Linux version 2.4.26 (pna@glazedevel) (gcc version 3.4.1) #50
Wed Sep 20 11:06:12 CEST 2006
	setup_arch: enter
	setup_arch: bootmem
	Xilinx Virtex-II Pro port (C) 2002 MontaVista Software, Inc.
(source@mvista.com)
	arch: exit=20
	On node 0 totalpages: 8192
	zone(0): 8192 pages.
	zone(1): 0 pages.
	zone(2): 0 pages.
	Kernel command line: root=3D/dev/ram rw console=3Dttl0
	(start) init/main.c: parse_options
	(end) parse_options
	(start) arch/ppc/mm/pgtable.c: __ioremap=20
	(end) arch/ppc/mm/pgtable.c: __ioremap
	Xilinx INTC #0 at 0x81200000 mapped to 0xFDFFF000
	(start) arch/ppc/mm/pgtable.c: __ioremap
	(end) arch/ppc/mm/pgtable.c: __ioremap
	Calibrating delay loop... 287.53 BogoMIPS=20
	Memory: 30924k available (776k kernel code, 276k data, 44k init,
0k highmem)
	Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
	Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
	Mount cache hash table entries: 512 (order: 0, 4096 bytes)=20
	Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
	Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
	POSIX conformance testing by UNIFIX
	(start) init/main.c: init
	(start) init/main.c: do_basic_setup=20
	            =20
	Linux NET4.0 for Linux 2.4
	Based upon Swansea University Computer Society NET3.039
	Initializing RT netlink socket
	(start) init/main.c: do_initcalls
	Starting kswapd
	devfs: v1.12c (20020818) Richard Gooch ( rgooch@atnf.csiro.au)
	devfs: boot_options: 0x1
	JFFS version 1.0, (C) 1999, 2000  Axis Communications AB
	JFFS2 version 2.1. (C) 2001 Red Hat, Inc., designed by Axis
Communications AB.=20
	Generic RTC Driver v1.07
	RAMDISK driver initialized: 16 RAM disks of 4096K size 1024
blocksize
	loop: loaded (max 8 devices)
	(start) drivers/mtd/maps/physmap.c: init_physmap
	physmap flash device: 4000000 at ff800000=20
	(start) arch/ppc/mm/pgtable.c: __ioremap
	(end) arch/ppc/mm/pgtable.c: __ioremap
	(start) drivers/mtd/chips/chipreg.c: do_map_probe
	(start) drivers/mtd/chips/chipreg.c: get_mtd_chip_driver
	(end) drivers/mtd/chips/chipreg.c: get_mtd_chip_driver=20
	(after get_mtd_chip_driver) drivers/mtd/chips/chipreg.c:
do_map_probe
	(start) drivers/mtd/chips/gen_probe.c: mtd_do_chip_probe
	(start) drivers/mtd/chips/gen_probe.c: genprobe_ident_chips
	Instruction machine check in kernel mode. =20
	^^^^^^^^^
	You should make sure if it is instruction or data machinecheck.
	The kernel you using is very old.
	=20
	Oops: machine check, sig: 7
	NIP: C00A2960 XER: 40000000 LR: C009CBD8 SP: C04D9D90 REGS:
c04d9ce0 TRAP: 0200    Not tainted=20
=09
^^^^^^^^^^^
	It has really machinecheck.
	=20
	MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
	TASK =3D c04d8000[1] 'swapper' Last syscall: 120=20
	last math 00000000 last altivec 00000000
	GPR00: C00A2958 C04D9D90 C04D8000 C00DC1C8 000000F0 00400000
C04D9DD0 C00DB387=20
	GPR08: 00000002 C307D000 C0176360 00000001 C00F0000 000057E0
80001040 80000820=20
	GPR16: 00001020 00000840 10021000 08040800 C00D0000 C00EAC18
C00D0000 00000000=20
	GPR24: C00C0000 00000001 C04D9DD0 C04D9E10 C04D9E10 00400000
C04D9DD0 C00DC1C8=20
	Call backtrace:=20
	C009CE80 C00A26D0 C009D3A0 C009C750 C00E9BB0 C00024F4 C0005ED4 =20
	=20
	You need dump more register to find the cause. eg. ESR. MCSR...
	=20
	Kernel panic: Attempted to kill init!
	 <0>Rebooting in 180 seconds..=20
=09
=09


------_=_NextPart_001_01C6DD2F.E60CA62F
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1555" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><BR>&nbsp;</DIV>
<BLOCKQUOTE=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
  <DIV></DIV>
  <DIV>I have a custom Xilinx FPGA board which is similar to ML300 but =
uses=20
  Uartllite and does not have disk or display.<BR>When I start the Linux =
kernel=20
  I end up with an exception during the probe for Flash - I think. <BR>I =
have=20
  added a bunch of printk lines in order to see what is happening but I =
am a=20
  little stuck at the moment. <BR>The Flash chip is an AM29LV320D 4Mbyte =
in=20
  16-bit access mode, and it sits on address 0xFF80'0000<BR>This is what =
I get=20
  on my terminal. I would be happy to hear your=20
  advice.<BR>Peter<BR><BR><BR><BR>loaded at:&nbsp;&nbsp;&nbsp;&nbsp; =
00400000=20
  004CF1E0 <BR>board data at: 004CC138 004CC150<BR>relocated to:&nbsp; =
004052F4=20
  0040530C<BR>zimage at:&nbsp;&nbsp;&nbsp;&nbsp; 00405801 =
00472CFB<BR>initrd=20
  at:&nbsp;&nbsp;&nbsp;&nbsp; 00473000 004CB2FF<BR>avail=20
  ram:&nbsp;&nbsp;&nbsp;&nbsp; 004D0000 02000000<BR><BR>Linux/PPC load:=20
  root=3D/dev/ram rw console=3Dttl0 <BR>Uncompressing =
Linux...done.<BR>Now booting=20
  the kernel<BR><BR>id mach(): done<BR>MMU:enter<BR>MMU:hw=20
  init<BR>MMU:mapin<BR>MMU:mapin_ram =
done<BR>MMU:setio<BR>MMU:exit<BR><BR>Linux=20
  version 2.4.26 (pna@glazedevel) (gcc version 3.4.1) #50 Wed Sep 20 =
11:06:12=20
  CEST 2006<BR>setup_arch: enter<BR>setup_arch: bootmem<BR>Xilinx =
Virtex-II Pro=20
  port (C) 2002 MontaVista Software, Inc. (<A=20
  href=3D"mailto:source@mvista.com">source@mvista.com</A>)<BR>arch: exit =
<BR>On=20
  node 0 totalpages: 8192<BR>zone(0): 8192 pages.<BR>zone(1): 0=20
  pages.<BR>zone(2): 0 pages.<BR>Kernel command line: root=3D/dev/ram rw =

  console=3Dttl0<BR>(start) init/main.c: parse_options<BR>(end)=20
  parse_options<BR>(start) arch/ppc/mm/pgtable.c: __ioremap <BR>(end)=20
  arch/ppc/mm/pgtable.c: __ioremap<BR>Xilinx INTC #0 at 0x81200000 =
mapped to=20
  0xFDFFF000<BR>(start) arch/ppc/mm/pgtable.c: __ioremap<BR>(end)=20
  arch/ppc/mm/pgtable.c: __ioremap<BR>Calibrating delay loop... 287.53 =
BogoMIPS=20
  <BR>Memory: 30924k available (776k kernel code, 276k data, 44k init, =
0k=20
  highmem)<BR>Dentry cache hash table entries: 4096 (order: 3, 32768=20
  bytes)<BR>Inode cache hash table entries: 2048 (order: 2, 16384=20
  bytes)<BR>Mount cache hash table entries: 512 (order: 0, 4096 bytes)=20
  <BR>Buffer cache hash table entries: 1024 (order: 0, 4096 =
bytes)<BR>Page-cache=20
  hash table entries: 8192 (order: 3, 32768 bytes)<BR>POSIX conformance =
testing=20
  by UNIFIX<BR>(start) init/main.c: init<BR>(start) init/main.c: =
do_basic_setup=20
  =
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;=20
  <BR>Linux NET4.0 for Linux 2.4<BR>Based upon Swansea University =
Computer=20
  Society NET3.039<BR>Initializing RT netlink socket<BR>(start) =
init/main.c:=20
  do_initcalls<BR>Starting kswapd<BR>devfs: v1.12c (20020818) Richard =
Gooch ( <A=20
  =
href=3D"mailto:rgooch@atnf.csiro.au">rgooch@atnf.csiro.au</A>)<BR>devfs: =

  boot_options: 0x1<BR>JFFS version 1.0, (C) 1999, 2000&nbsp; Axis=20
  Communications AB<BR>JFFS2 version 2.1. (C) 2001 Red Hat, Inc., =
designed by=20
  Axis Communications AB. <BR>Generic RTC Driver v1.07<BR>RAMDISK driver =

  initialized: 16 RAM disks of 4096K size 1024 blocksize<BR>loop: loaded =
(max 8=20
  devices)<BR>(start) drivers/mtd/maps/physmap.c: =
init_physmap<BR>physmap flash=20
  device: 4000000 at ff800000 <BR>(start) arch/ppc/mm/pgtable.c:=20
  __ioremap<BR>(end) arch/ppc/mm/pgtable.c: __ioremap<BR>(start)=20
  drivers/mtd/chips/chipreg.c: do_map_probe<BR>(start)=20
  drivers/mtd/chips/chipreg.c: get_mtd_chip_driver<BR>(end)=20
  drivers/mtd/chips/chipreg.c: get_mtd_chip_driver <BR>(after=20
  get_mtd_chip_driver) drivers/mtd/chips/chipreg.c: =
do_map_probe<BR>(start)=20
  drivers/mtd/chips/gen_probe.c: mtd_do_chip_probe<BR>(start)=20
  drivers/mtd/chips/gen_probe.c: genprobe_ident_chips<BR>Instruction =
machine=20
  check in kernel mode.&nbsp;<SPAN class=3D416583103-21092006><FONT =
face=3D&#23435;&#20307;=20
  color=3D#0000ff size=3D2>&nbsp;</FONT></SPAN></DIV>
  <DIV><SPAN class=3D416583103-21092006><FONT face=3D&#23435;&#20307; =
color=3D#0000ff=20
  size=3D2>^^^^^^^^^</FONT></SPAN></DIV>
  <DIV><SPAN class=3D416583103-21092006><FONT face=3D&#23435;&#20307; =
color=3D#0000ff size=3D2>You=20
  should make sure if it is instruction or=20
  data&nbsp;machinecheck.</FONT></SPAN></DIV>
  <DIV><SPAN class=3D416583103-21092006><FONT face=3D&#23435;&#20307; =
color=3D#0000ff size=3D2>The=20
  kernel you using is very old.</FONT></SPAN></DIV>
  <DIV><SPAN class=3D416583103-21092006>&nbsp;</SPAN><BR>Oops: machine =
check, sig:=20
  7<BR>NIP: C00A2960 XER: 40000000 LR: C009CBD8 SP: C04D9D90 REGS: =
c04d9ce0=20
  TRAP: 0200&nbsp;&nbsp;&nbsp; Not tainted<SPAN =
class=3D416583103-21092006><FONT=20
  face=3D&#23435;&#20307; color=3D#0000ff =
size=3D2>&nbsp;</FONT></SPAN></DIV>
  <DIV><SPAN class=3D416583103-21092006><FONT face=3D&#23435;&#20307; =
color=3D#0000ff=20
  =
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;^^^^^^^^^^^</FONT></SPAN></DIV>
  <DIV><SPAN class=3D416583103-21092006><FONT face=3D&#23435;&#20307; =
color=3D#0000ff size=3D2>It has=20
  really machinecheck.</FONT></SPAN></DIV>
  <DIV><SPAN class=3D416583103-21092006>&nbsp;</SPAN><BR>MSR: 00009030 =
EE: 1 PR: 0=20
  FP: 0 ME: 1 IR/DR: 11<BR>TASK =3D c04d8000[1] 'swapper' Last syscall: =
120=20
  <BR>last math 00000000 last altivec 00000000<BR>GPR00: C00A2958 =
C04D9D90=20
  C04D8000 C00DC1C8 000000F0 00400000 C04D9DD0 C00DB387 <BR>GPR08: =
00000002=20
  C307D000 C0176360 00000001 C00F0000 000057E0 80001040 80000820 =
<BR>GPR16:=20
  00001020 00000840 10021000 08040800 C00D0000 C00EAC18 C00D0000 =
00000000=20
  <BR>GPR24: C00C0000 00000001 C04D9DD0 C04D9E10 C04D9E10 00400000 =
C04D9DD0=20
  C00DC1C8 <BR>Call backtrace: <BR>C009CE80 C00A26D0 C009D3A0 C009C750 =
C00E9BB0=20
  C00024F4 C0005ED4&nbsp;<SPAN class=3D416583103-21092006><FONT =
face=3D&#23435;&#20307;=20
  color=3D#0000ff size=3D2>&nbsp;</FONT></SPAN></DIV>
  <DIV><SPAN class=3D416583103-21092006><FONT face=3D&#23435;&#20307; =
color=3D#0000ff=20
  size=3D2></FONT></SPAN>&nbsp;</DIV>
  <DIV><SPAN class=3D416583103-21092006><FONT face=3D&#23435;&#20307; =
color=3D#0000ff size=3D2>You=20
  need dump more register to find the cause. eg. ESR.=20
MCSR...</FONT></SPAN></DIV>
  <DIV><SPAN class=3D416583103-21092006>&nbsp;</SPAN><BR>Kernel panic: =
Attempted=20
  to kill init!<BR>&nbsp;&lt;0&gt;Rebooting in 180 seconds..=20
<BR><BR></DIV></BLOCKQUOTE></BODY></HTML>

------_=_NextPart_001_01C6DD2F.E60CA62F--
