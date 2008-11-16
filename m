Return-Path: <Joaquin.Luna@jdsu.com>
Received: from exprod7og110.obsmtp.com (exprod7og110.obsmtp.com [64.18.2.173])
	by ozlabs.org (Postfix) with SMTP id 88AB1DDDF5
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Nov 2008 10:43:44 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C94845.27D9785D"
Subject: command line partition information
Date: Sun, 16 Nov 2008 15:43:40 -0800
Message-ID: <DF6C7BC3780EE44B83430A9F756D43B608581D77@SJEXCH03.ds.jdsu.net>
From: "Joaquin Luna" <Joaquin.Luna@jdsu.com>
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

------_=_NextPart_001_01C94845.27D9785D
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello Linux powerpc community,

=20

I am trying to move from 2.6.20 kernel to the new 2.6.27.4 kernel.  I am
not finding my root file system partition with the new kernel.  I am not
sure if I need to change my dts file, or if the problem is some where in
my kernel config.  In either case, it is evident from the boot log that
my partition table is not being used.  Where it says "[    0.917162]
List of all partitions:" it just lists the entire size of my flash, and
none of the partitions listed in the command line.

I do not list any partitions in my dts file, though I tried and not seen
any change in the behavior.  I have enabled the option in the kernel to
parse the partition information from the kernel command line, is there
something else I need to do to set up the mtdblockX devices?

=20

Boot Command:

=20

mtdparts=3Dmtdparts=3Dnand0:2m(u-boot),3M(kernel),128K(dtb),30M(jffs2),32=
M(m
ycust),90M(myfs),90M(myfs2)

mtd_args=3Dsetenv bootargs root=3D/dev/mtdblock3 rw rootfstype=3Djffs2
$mtdparts console=3DttyS1,115200

=20

Boot Log:=20

=20

[    0.825229] brd: module loaded

[    0.837681] loop: module loaded

[    0.841404] Driver 'sd' needs updating - please use bus_type methods

[    0.850005] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xda (Micron
NAND 256MiB 3,3V 8-bit)

[    0.859783] Bad block table found at page 131008, version 0x01

[    0.867779] Bad block table found at page 130944, version 0x01

[    0.875443] RedBoot partition parsing not available

[    0.884431] eLBC NAND device at 0xff800000, bank 0

[    0.890643] i2c /dev entries driver

[    0.899633] Driver for 1-wire Dallas network protocol.

[    0.910115] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)

[    0.917162] List of all partitions:

[    0.920856] 1f00     262144 mtdblock0 (driver?)

[    0.925466] No filesystem could mount root, tried:  jffs2

[    0.930952] Kernel panic - not syncing: VFS: Unable to mount root fs
on unknown-block(0,0)

[    0.939294] Rebooting in 180 seconds..

=20

=20

=20

Thanks to all who can help,

Joaquin Luna


------_=_NextPart_001_01C94845.27D9785D
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"City"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
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
	color:windowtext;}
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

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hello Linux powerpc =
community,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am trying to move from 2.6.20 kernel to the new =
2.6.27.4
kernel.&nbsp; I am not finding my root file system partition with the =
new
kernel.&nbsp; I am not sure if I need to change my dts file, or if the =
problem
is some where in my kernel config.&nbsp; In either case, it is evident =
from the
boot log that my partition table is not being used.&nbsp; Where it says =
&#8220;[&nbsp;&nbsp;&nbsp;
0.917162] List of all partitions:&quot; it just lists the entire size of =
my
flash, and none of the partitions listed in the command =
line.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I do not list any partitions in my dts file, though I =
tried
and not seen any change in the behavior.&nbsp; I have enabled the option =
in the
kernel to parse the partition information from the kernel command line, =
is
there something else I need to do to set up the mtdblockX =
devices?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Boot Command:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>mtdparts=3Dmtdparts=3Dnand0:2m(u-boot),3M(kernel),128K=
(dtb),30M(jffs2),32M(mycust),90M(myfs),90M(myfs2)<o:p></o:p></span></font=
></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>mtd_args=3Dsetenv bootargs root=3D/dev/mtdblock3 rw
rootfstype=3Djffs2 $mtdparts =
console=3DttyS1,115200<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Boot Log: <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp;&nbsp;&nbsp; 0.825229] brd: module =
loaded<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp;&nbsp;&nbsp; 0.837681] loop: module =
loaded<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp;&nbsp;&nbsp; 0.841404] Driver 'sd' needs =
updating -
please use bus_type methods<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp;&nbsp;&nbsp; 0.850005] NAND device: =
Manufacturer ID:
0x2c, Chip ID: 0xda (Micron NAND 256MiB 3,3V =
8-bit)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp;&nbsp;&nbsp; 0.859783] Bad block table found =
at page
131008, version 0x01<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp;&nbsp;&nbsp; 0.867779] Bad block table found =
at page
130944, version 0x01<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp;&nbsp;&nbsp; 0.875443] RedBoot partition =
parsing not
available<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp;&nbsp;&nbsp; 0.884431] eLBC NAND device at
0xff800000, bank 0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp;&nbsp;&nbsp; 0.890643] i2c /dev entries =
driver<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp;&nbsp;&nbsp; 0.899633] Driver for 1-wire =
<st1:City
w:st=3D"on"><st1:place w:st=3D"on">Dallas</st1:place></st1:City> network =
protocol.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp;&nbsp;&nbsp; 0.910115] drivers/rtc/hctosys.c: =
unable
to open rtc device (rtc0)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp;&nbsp;&nbsp; 0.917162] List of all =
partitions:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp;&nbsp;&nbsp; 0.920856] =
1f00&nbsp;&nbsp;&nbsp;&nbsp;
262144 mtdblock0 (driver?)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp;&nbsp;&nbsp; 0.925466] No filesystem could =
mount
root, tried:&nbsp; jffs2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp;&nbsp;&nbsp; 0.930952] Kernel panic - not =
syncing:
VFS: Unable to mount root fs on =
unknown-block(0,0)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp;&nbsp;&nbsp; 0.939294] Rebooting in 180 =
seconds..<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks to all who can =
help,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Joaquin Luna<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C94845.27D9785D--
