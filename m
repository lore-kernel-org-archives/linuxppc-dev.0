Return-Path: <sbershtein@Quantum3D.com>
Received: from MAIL-SJC.quantum3d.com (owa-sjc.quantum3d.com [63.150.7.15])
	by ozlabs.org (Postfix) with ESMTP id 75AABDE2EC
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Aug 2008 01:33:34 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8FD59.F1B049E9"
Subject: RE: ml507 initrd problem
Date: Wed, 13 Aug 2008 08:33:32 -0700
Message-ID: <8BB04FAC749BD24BBA250E9D09F2F18B220AD6@MAIL-SJC.quantum3d.com>
In-Reply-To: <20080813141107.92D4B948071@mail62-wa4.bigfish.com>
References: <8BB04FAC749BD24BBA250E9D09F2F18B220ABB@MAIL-SJC.quantum3d.com>
	<20080813141107.92D4B948071@mail62-wa4.bigfish.com>
From: "Stu Bershtein" <sbershtein@Quantum3D.com>
To: "John Linn" <John.Linn@xilinx.com>,
	<linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C8FD59.F1B049E9
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Morning John,

=20

Thanks for the tip.  Running said ramdisk things certainly look lively,
I'll add a list of opens that I see at boot up at the bottom of this
email.  Looks like it's opening a shell and everything and yet I see no
serial communication from the shell, just quiet.  Am I correct to expect
the console to be the serial port (9pin DB) on the ml507 board at 9600
baud?  Also, if you could spare a desperate person a moment, could you
send me the boot command line that you use for testing with the ramdisk?
Finally, another member of this form suggested that there is a fully
build BSP (rootfs and all) available as 'linux_support.tar.gz' on the
Xilinx site.  Are you familiar with this?  I tried locating it a few
days ago to no avail.

=20

Thanks very much for your help!

Stu

=20

Freeing unused kernel memory: 144k init

open /dev/console

code 10000000 - 1009c134, data 1009a128 - 1009c134, stack bfdb9f00

open /lib/libcrypt.so.0

open /lib/libm.so.0

open /lib/libc.so.0

open /dev/console

open /dev/console

open /etc/TZ

open /etc/inittab

open /dev/console

open /etc/TZ

code 10000000 - 1009c134, data 1009a128 - 1009c134, stack bfd65eb0

open /lib/libcrypt.so.0

open /lib/libm.so.0

open /lib/libc.so.0

open /etc/rc.sh

code 10000000 - 1009c134, data 1009a128 - 1009c134, stack bfef2ea0

open /lib/libcrypt.so.0

open /lib/libm.so.0

open /lib/libc.so.0

open /etc/mtab

code 10000000 - 1009c134, data 1009a128 - 1009c134, stack bf9a8e90

open /lib/libcrypt.so.0

open /lib/libm.so.0

open /lib/libc.so.0

code 10000000 - 10039640, data 10039000 - 10039640, stack bfa47e70

open /lib/libm.so.0

open /lib/libcrypt.so.0

open /lib/libc.so.0

open /dev/null

open /tmp/xinetd.pid

open /etc/xinetd.conf

open /etc/xinetd.d

open /dev/console

open /etc/TZ

open /etc/xinetd.d/ftpd

open /dev/console

code 10000000 - 1009c134, data 1009a128 - 1009c134, stack bfda3ea0

open /etc/TZ

open /etc/TZ

code 10000000 - 1009c134, data 1009a128 - 1009c134, stack bf9c5ec0

open /etc/passwd

open /etc/xinetd.d/telnet

open /lib/libcrypt.so.0

open /etc/TZ

open /lib/libm.so.0

open /lib/libcrypt.so.0

open /etc/passwd

open /lib/libc.so.0

open /lib/libm.so.0

open /etc/protocols

open /bin/application

open /lib/libc.so.0

open /etc/services

code 10000000 - 1009c134, data 1009a128 - 1009c134, stack bffa9ea0

open .profile

open /etc/services

open /etc/profile

open /etc/protocols

open /etc/passwd

open /etc/services

open /lib/libcrypt.so.0

open /etc/services

open /lib/libm.so.0

open /etc/TZ

open /lib/libc.so.0

open /etc/TZ

code 10000000 - 1009c134, data 1009a128 - 1009c134, stack bfaa5eb0

open /lib/libcrypt.so.0

open /lib/libm.so.0

open /lib/libc.so.0

=20

=20

=20

________________________________

From: John Linn [mailto:John.Linn@xilinx.com]=20
Sent: Wednesday, August 13, 2008 7:11 AM
To: Stu Bershtein; linuxppc-embedded@ozlabs.org
Subject: RE: ml507 initrd problem

=20

Hi Stu,

=20

I realize you are trying to get your own ram disk to work, but if you
want to get a baseline you can use one we have on our wiki site, at
http://xilinx.wikidot.com/open-source-linux, under Files To Download.
This is the same ram disk that is included in the ELDK.

=20

This is the ram disk that I use to test the ML507 design in our Git
tree.  I also use NFS a lot for testing.

=20

Looks like you're close with yours, but I'm certainly no expert in that
area as I typically have something that works and don't change it.

=20

Good luck,

John

=20

________________________________

From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org] On
Behalf Of Stu Bershtein
Sent: Tuesday, August 12, 2008 5:28 PM
To: linuxppc-embedded@ozlabs.org
Subject: ml507 initrd problem

=20

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


This email and any attachments are intended for the sole use of the
named recipient(s) and contain(s) confidential information that may be
proprietary, privileged or copyrighted under applicable law. If you are
not the intended recipient, do not read, copy, or forward this email
message or any attachments. Delete this email message and any
attachments immediately.=20


------_=_NextPart_001_01C8FD59.F1B049E9
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
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
	{mso-style-type:personal;
	font-family:Arial;
	color:blue;
	font-weight:bold;
	font-style:normal;
	text-decoration:none none;}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:Arial;
	color:navy;}
span.EmailStyle19
	{mso-style-type:personal-reply;
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
Morning
John,<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
<o:p>&nbsp;</o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
Thanks
for the tip.&nbsp; Running said ramdisk things certainly look lively, =
I&#8217;ll
add a list of opens that I see at boot up at the bottom of this =
email.&nbsp;
Looks like it&#8217;s opening a shell and everything and yet I see no =
serial
communication from the shell, just quiet.&nbsp; Am I correct to expect =
the
console to be the serial port (9pin DB) on the ml507 board at 9600 =
baud?&nbsp;
Also, if you could spare a desperate person a moment, could you send me =
the
boot command line that you use for testing with the ramdisk? =
&nbsp;Finally,
another member of this form suggested that there is a fully build BSP =
(rootfs
and all) available as &#8216;linux_support.tar.gz&#8217; on the Xilinx =
site.&nbsp;
Are you familiar with this?&nbsp; I tried locating it a few days ago to =
no
avail.<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
<o:p>&nbsp;</o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
Thanks
very much for your help!<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
Stu<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
<o:p>&nbsp;</o:p></span></font></b></p>

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
code
10000000 - 1009c134, data 1009a128 - 1009c134, stack =
bfdb9f00<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/lib/libcrypt.so.0<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/lib/libm.so.0<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/lib/libc.so.0<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/dev/console<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/dev/console<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/etc/TZ<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/etc/inittab<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/dev/console<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/etc/TZ<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
code
10000000 - 1009c134, data 1009a128 - 1009c134, stack =
bfd65eb0<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/lib/libcrypt.so.0<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/lib/libm.so.0<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/lib/libc.so.0<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open /etc/rc.sh<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
code
10000000 - 1009c134, data 1009a128 - 1009c134, stack =
bfef2ea0<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/lib/libcrypt.so.0<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/lib/libm.so.0<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/lib/libc.so.0<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/etc/mtab<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
code
10000000 - 1009c134, data 1009a128 - 1009c134, stack =
bf9a8e90<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/lib/libcrypt.so.0<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/lib/libm.so.0<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/lib/libc.so.0<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
code
10000000 - 10039640, data 10039000 - 10039640, stack =
bfa47e70<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/lib/libm.so.0<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/lib/libcrypt.so.0<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/lib/libc.so.0<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/dev/null<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/tmp/xinetd.pid<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/etc/xinetd.conf<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/etc/xinetd.d<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/dev/console<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/etc/TZ<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/etc/xinetd.d/ftpd<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/dev/console<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
code
10000000 - 1009c134, data 1009a128 - 1009c134, stack =
bfda3ea0<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/etc/TZ<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/etc/TZ<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
code
10000000 - 1009c134, data 1009a128 - 1009c134, stack =
bf9c5ec0<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/etc/passwd<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/etc/xinetd.d/telnet<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/lib/libcrypt.so.0<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/etc/TZ<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/lib/libm.so.0<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/lib/libcrypt.so.0<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/etc/passwd<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/lib/libc.so.0<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/lib/libm.so.0<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/etc/protocols<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/bin/application<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/lib/libc.so.0<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/etc/services<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
code
10000000 - 1009c134, data 1009a128 - 1009c134, stack =
bffa9ea0<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
.profile<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/etc/services<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/etc/profile<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/etc/protocols<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/etc/passwd<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/etc/services<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/lib/libcrypt.so.0<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/etc/services<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/lib/libm.so.0<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/etc/TZ<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/lib/libc.so.0<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/etc/TZ<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
code
10000000 - 1009c134, data 1009a128 - 1009c134, stack =
bfaa5eb0<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/lib/libcrypt.so.0<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/lib/libm.so.0<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
open
/lib/libc.so.0<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
<o:p>&nbsp;</o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
<o:p>&nbsp;</o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
<o:p>&nbsp;</o:p></span></font></b></p>

<div>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font =
size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>

<hr size=3D2 width=3D"100%" align=3Dcenter tabindex=3D-1>

</span></font></div>

<p class=3DMsoNormal><b><font size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;
font-family:Tahoma;font-weight:bold'>From:</span></font></b><font =
size=3D2
face=3DTahoma><span style=3D'font-size:10.0pt;font-family:Tahoma'> John =
Linn
[mailto:John.Linn@xilinx.com] <br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Wednesday, August =
13, 2008
7:11 AM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> Stu Bershtein;
linuxppc-embedded@ozlabs.org<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> RE: ml507 initrd =
problem</span></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Hi =
Stu,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>I realize you are trying to get =
your own
ram disk to work, but if you want to get a baseline you can use one we =
have on
our wiki site, at <a =
href=3D"http://xilinx.wikidot.com/open-source-linux">http://xilinx.wikido=
t.com/open-source-linux</a>,
under Files To Download. &nbsp;This is the same ram disk that is =
included in
the ELDK.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>This is the ram disk that I use to =
test
the ML507 design in our Git tree.&nbsp; I also use NFS a lot for =
testing.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Looks like you&#8217;re close with =
yours,
but I&#8217;m certainly no expert in that area as I typically have =
something
that works and don&#8217;t change it.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Good =
luck,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>John<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<div style=3D'border:none;border-left:solid blue 1.5pt;padding:0in 0in =
0in 4.0pt'>

<div>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font =
size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>

<hr size=3D2 width=3D"100%" align=3Dcenter tabindex=3D-1>

</span></font></div>

<p class=3DMsoNormal><b><font size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;
font-family:Tahoma;font-weight:bold'>From:</span></font></b><font =
size=3D2
face=3DTahoma><span style=3D'font-size:10.0pt;font-family:Tahoma'>
linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org] =
<b><span
style=3D'font-weight:bold'>On Behalf Of </span></b>Stu Bershtein<br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Tuesday, August 12, =
2008
5:28 PM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> =
linuxppc-embedded@ozlabs.org<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> ml507 initrd =
problem</span></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
I have
been trying to boot linux on an ml507 board for a few days now.&nbsp; I =
am
using xilinx&#8217;s linux-2.6-xlnx.git kernel.&nbsp; The rootfs is home
rolled.&nbsp; I have had experience with NFS mounted root filesystems =
(not an
option here), cramfs, and romfs but have never tried running root out of =
a
ramdisk.&nbsp; Because of that I am quite sure I have dorked this =
up.&nbsp; Any
help will be appreciated!&nbsp; I have added printk&#8217;s in the =
kernel at
do_sys_open to get an idea what is going on.&nbsp; Here is a snip of the =
boot
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
root=3D/dev/ram rw ram
disk_size=3D9000<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
.<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblue face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:blue;font-weight:bold'>=
Serial:
8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
83e00000.serial: ttyS0 at MMIO 0x83e00003 (irq =3D 16) is a =
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
open /dev/null<o:p></o:p></span></font></b></p>

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
gets very quiet at that point.&nbsp; The kernel is still running in
ppc44x_idle.&nbsp; Does this suggest anything to anyone?&nbsp; =
I&#8217;ll be
more than happy to send or describe any config files to any one who =
might take
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

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><br clear=3Dall>
This email and any attachments are intended for the sole use of the =
named
recipient(s) and contain(s) confidential information that may be =
proprietary,
privileged or copyrighted under applicable law. If you are not the =
intended
recipient, do not read, copy, or forward this email message or any =
attachments.
Delete this email message and any attachments immediately. =
<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C8FD59.F1B049E9--
