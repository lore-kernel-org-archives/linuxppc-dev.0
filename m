Return-Path: <sbershtein@Quantum3D.com>
Received: from MAIL-SJC.quantum3d.com (owa-sjc.quantum3d.com [63.150.7.15])
	by ozlabs.org (Postfix) with ESMTP id 57711DDDD8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Aug 2008 09:40:12 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8FCD3.12E11A75"
Subject: ml507 initrd problem
Date: Tue, 12 Aug 2008 16:28:06 -0700
Message-ID: <8BB04FAC749BD24BBA250E9D09F2F18B220ABB@MAIL-SJC.quantum3d.com>
From: "Stu Bershtein" <sbershtein@Quantum3D.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8FCD3.12E11A75
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I have been trying to boot linux on an ml507 board for a few days now.
I am using xilinx's linux-2.6-xlnx.git kernel.  The rootfs is home
rolled.  I have had experience with NFS mounted root filesystems (not an
option here), cramfs, and romfs but have never tried running root out of
a ramdisk.  Because of that I am quite sure I have dorked this up.  Any
help will be appreciated!  I have added printk's in the kernel at
do_sys_open to get an idea what is going on.  Here is a snip of the boot
output:

=20

.

Kernel command line: console=3DttyS0,9600 ip=3Don init=3D/linuxrc
root=3D/dev/ram rw ram disk_size=3D9000

.

Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing
disabled 83e00000.serial: ttyS0 at MMIO 0x83e00003 (irq =3D 16) is a
16550A

.

eth0: XLlTemac: Send Threshold =3D 0, Receive Threshold =3D 0

eth0: XLlTemac: Send Wait bound =3D 0, Receive Wait bound =3D 0

IP-Config: Incomplete network configuration information.

open /dev/ram

fd 0

open /initrd.image

fd 1

RAMDISK: Compressed image found at block 0

VFS: Mounted root (ext2 filesystem).

Freeing unused kernel memory: 144k init

open /dev/console

fd 0

code 10000000 - 1019854c, data 10195000 - 1019854c, stack bf85df00

open /dev/null

fd 3

open /etc/inittab

fd 3

=20

And it gets very quiet at that point.  The kernel is still running in
ppc44x_idle.  Does this suggest anything to anyone?  I'll be more than
happy to send or describe any config files to any one who might take
pity.

=20

Thanks,

Stu

=20


------_=_NextPart_001_01C8FCD3.12E11A75
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:blue;
	font-weight:bold;
	font-style:normal;
	text-decoration:none none;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
I have
been trying to boot linux on an ml507 board for a few days now.&nbsp; I =
am
using xilinx&#8217;s linux-2.6-xlnx.git kernel.&nbsp; The rootfs is home
rolled.&nbsp; I have had experience with NFS mounted root filesystems =
(not an
option here), cramfs, and romfs but have never tried running root out of =
a ramdisk.&nbsp;
Because of that I am quite sure I have dorked this up.&nbsp; Any help =
will be
appreciated!&nbsp; I have added printk&#8217;s in the kernel at =
do_sys_open to
get an idea what is going on.&nbsp; Here is a snip of the boot =
output:<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
<o:p>&nbsp;</o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
.<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
Kernel
command line: console=3DttyS0,9600 ip=3Don init=3D/linuxrc =
root=3D/dev/ram rw ram disk_size=3D9000<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
.<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
Serial:
8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled =
83e00000.serial:
ttyS0 at MMIO 0x83e00003 (irq =3D 16) is a =
16550A<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
.<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
eth0:
XLlTemac: Send Threshold =3D 0, Receive Threshold =3D =
0<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
eth0:
XLlTemac: Send Wait bound =3D 0, Receive Wait bound =3D =
0<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
IP-Config:
Incomplete network configuration =
information.<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/dev/ram<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
fd 0<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/initrd.image<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
fd 1<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
RAMDISK:
Compressed image found at block 0<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
VFS:
Mounted root (ext2 filesystem).<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
Freeing
unused kernel memory: 144k init<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/dev/console<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
fd 0<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
code
10000000 - 1019854c, data 10195000 - 1019854c, stack =
bf85df00<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/dev/null<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
fd 3<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/etc/inittab<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
fd 3<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
<o:p>&nbsp;</o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
And it
gets very quiet at that point.&nbsp; The kernel is still running in =
ppc44x_idle.&nbsp;
Does this suggest anything to anyone?&nbsp; I&#8217;ll be more than =
happy to
send or describe any config files to any one who might take =
pity.<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
<o:p>&nbsp;</o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
Thanks,<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
Stu<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
<o:p>&nbsp;</o:p></span></font></b></p>

</div>

</body>

</html>

------_=_NextPart_001_01C8FCD3.12E11A75--
