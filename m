Return-Path: <scott.coulter@cyclone.com>
Received: from CYBORG3.cyclone.com (unknown [69.37.28.78])
	by ozlabs.org (Postfix) with ESMTP id DD16DDDFEA
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Apr 2007 06:48:02 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7890B.39BA0E6E"
Subject: RE: 
Date: Fri, 27 Apr 2007 16:30:08 -0400
Message-ID: <43EB80E07C42E1408726E4905FB96B04822F64@CYBORG3.cyclone.com>
In-Reply-To: <D1AFFAE2CC4BD54CA4C1543CFF4A4FCC2F37BB@exchangemb3.bnl.gov>
From: "Scott Coulter" <scott.coulter@cyclone.com>
To: "Mead, Joseph" <mead@bnl.gov>
Cc: linuxppc-embedded@ozlabs.org
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

------_=_NextPart_001_01C7890B.39BA0E6E
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Check your UART  interrupt setup

=20






___________________________________________________________________=20

  Scott N. Coulter=20
  Senior Software Engineer=20
 =20
  Cyclone Microsystems         =20
  370 James Street              Phone:  203.786.5536 ext. 118=20
  New Haven, CT 06513-3051      Email:  scott.coulter@cyclone.com=20
  U.S.A.                        Web:    http://www.cyclone.com=20
___________________________________________________________________=20

________________________________

From: linuxppc-embedded-bounces+scott.coulter=3Dcyclone.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+scott.coulter=3Dcyclone.com@ozlabs.org]=

On Behalf Of Mead, Joseph
Sent: Friday, April 27, 2007 3:16 PM
To: linuxppc-embedded@ozlabs.org
Subject:=20

=20

Hi,=20

I'm trying to use initramfs on an ML403 system but don't understand why
I can't see any console output after the line:=20

[    1.034361] Freeing unused kernel memory: 1172k init =20

=20

my filesystem is built from the following:=20

dir /dev 755 0 0=20
nod /dev/console 644 0 0 c 5 1=20
dir /proc 755 0 0=20
dir /sys 755 0 0=20
file /init usr/busybox 755 0 0=20

=20

Busybox was built statically, with init functionality so I think I can
just rename it to init and it should run the init process.   It seems to
find /dev/console because if I delete that node I get an error message
that it can't find /dev/console.   Also I think it is finding the
busybox init because I don't get a kernel panic like I do when I don't
include it.

Any help would be great.=20

Thanks,
Joe=20

=20

Kernel boot-up messages.=20

loaded at:     00400000 005E613C                               =20
board data at: 005E4124 005E413C                               =20
relocated to:  004050D0 004050E8                               =20
zimage at:     004057E9 005E3869                               =20
avail ram:     005E7000 04000000                               =20

Linux/PPC load: console=3DttyS0,9600                                 =20
Uncompressing Linux...done.                          =20
Now booting the kernel                     =20
[    0.000000] Linux version 2.6.17.1 (root@ansto1) (gcc version 3.4.5)
#29 Thu Apr 27 11:13:26 EDT 2007                       =20

[    0.000000] Xilinx ML403 Reference System (Virtex-4 FX)

[    0.000000] Built 1 zonelists                               =20
[    0.000000] Kernel command line: console=3DttyS0,9600

[    0.000000] Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFE000


[    0.000000] PID hash table entries: 512 (order: 9, 2048 bytes)


[    0.000105] Console: colour dummy device 80x25

[    0.000394] Dentry cache hash table entries: 8192 (order: 3, 32768
bytes)


[    0.000887] Inode-cache hash table entries: 4096 (order: 2, 16384
bytes)


[    0.009214] Memory: 61964k available (1292k kernel code, 468k data,
1172k init, 0k highmem)             =20
[    0.096238] Mount-cache hash table entries: 512

[    0.435539] NET: Registered protocol family 16

[    0.440315] NET: Registered protocol family 2

[    0.480121] IP route cache hash table entries: 512 (order: -1, 2048
bytes)


[    0.480636] TCP established hash table entries: 2048 (order: 1, 8192
bytes)


[    0.480755] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)


[    0.480821] TCP: Hash tables configure

[    0.480843] TCP reno registered                                 =20
[    0.484696] io scheduler noop registered

[    0.484754] io scheduler anticipatory registered (default)


[    0.484799] io scheduler deadline registered

[    0.484890] io scheduler cfq registered

[    0.510230] Serial: 8250/16550 driver $Revision: 1.90 $ 1 ports, IRQ
sharing disabled       =20
[    0.511764] serial8250.0: ttyS0 at MMIO 0x40401003 (irq =3D 9) is a
16550A


[    0.924578] RAMDISK driver initialized: 16 RAM disks of 65536K size
1024 blocksize    =20
[    0.948301] tun: Universal TUN                               =20
[    0.963483] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>


[    0.982713] mice: PS/2 mouse device common for all mice

[    0.998445] TCP bic registered                                =20
[    1.007702] NET: Registered protocol family 1

[    1.020827] NET: Registered protocol family 17

[    1.034361] Freeing unused kernel memory: 1172k init =20


------_=_NextPart_001_01C7890B.39BA0E6E
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><o:SmartTagType
 namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags" =
name=3D"country-region"/>
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
p
	{mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"Times New Roman";}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
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

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Check your UART&nbsp; interrupt =
setup<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<div>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><font size=3D3 =
color=3Dnavy
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;color:navy'><br>
<br>
<br>
<o:p></o:p></span></font></p>

<p><font size=3D2 color=3Dnavy face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New";color:navy'>________________________________________________________=
___________</span></font><font
color=3Dnavy><span style=3D'color:navy'> <o:p></o:p></span></font></p>

<p><font size=3D2 color=3Dnavy face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:navy'>&nbsp; Scott N. =
Coulter</span></font><font
color=3Dnavy><span style=3D'color:navy'> <br>
</span></font><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:navy'>&nbsp; =
Senior
Software Engineer</span></font><font color=3Dnavy><span =
style=3D'color:navy'> <br>
</span></font><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:navy'>&nbsp; =
</span></font><font
color=3Dnavy><span style=3D'color:navy'><br>
</span></font><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:navy'>&nbsp; =
Cyclone
Microsystems&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font><font
color=3Dnavy><span style=3D'color:navy'><br>
</span></font><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:navy'>&nbsp; =
370 James
Street&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;
Phone:&nbsp; 203.786.5536 ext. 118</span></font><font color=3Dnavy><span
style=3D'color:navy'> <br>
</span></font><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:navy'>&nbsp; =
<st1:City
w:st=3D"on">New Haven</st1:City>, CT =
06513-3051&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Email:&nbsp; scott.coulter@cyclone.com</span></font><font =
color=3Dnavy><span
style=3D'color:navy'> <br>
</span></font><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:navy'>&nbsp; =
<st1:country-region
w:st=3D"on"><st1:place =
w:st=3D"on">U.S.A.</st1:place></st1:country-region>&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Web:&nbsp;&nbsp;&nbsp; <a =
href=3D"http://www.cyclone.com">http://www.cyclone.com</a></span></font><=
font
color=3Dnavy><span style=3D'color:navy'> <br>
</span></font><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:navy'>________________________________________________________=
___________</span></font><font
color=3Dnavy><span style=3D'color:navy'> </span></font><o:p></o:p></p>

</div>

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
linuxppc-embedded-bounces+scott.coulter=3Dcyclone.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+scott.coulter=3Dcyclone.com@ozlabs.org]=
 <b><span
style=3D'font-weight:bold'>On Behalf Of </span></b>Mead, Joseph<br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Friday, April 27, =
2007 3:16
PM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> =
linuxppc-embedded@ozlabs.org<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> =
</span></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Hi,</span></font>
<o:p></o:p></p>

<p><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>I'm
trying to use initramfs on an ML403 system but don't understand why I =
can't see
any console output after the line:</span></font> <o:p></o:p></p>

<p><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>[&nbsp;&nbsp;&nbsp;
1.034361] Freeing unused kernel memory: 1172k init&nbsp; =
</span></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>my
filesystem is built from the following:</span></font> <o:p></o:p></p>

<p><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>dir
/dev 755 0 0</span></font> <br>
<font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>nod
/dev/console 644 0 0 c 5 1</span></font> <br>
<font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>dir
/proc 755 0 0</span></font> <br>
<font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>dir
/sys 755 0 0</span></font> <br>
<font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>file
/init usr/busybox 755 0 0</span></font> <o:p></o:p></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Busybox
was built statically, with init functionality so I think I can just =
rename it
to init and it should run the init process.&nbsp;&nbsp; It seems to find
/dev/console because if I delete that node I get an error message that =
it can't
find /dev/console.&nbsp;&nbsp; Also I think it is finding the busybox =
init
because I don't get a kernel panic like I do when I don't include =
it.</span></font><o:p></o:p></p>

<p><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Any
help would be great. </span></font><o:p></o:p></p>

<p><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Thanks,<br>
Joe</span></font> <o:p></o:p></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Kernel
boot-up messages.</span></font> <o:p></o:p></p>

<p><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>loaded
at:&nbsp;&nbsp;&nbsp;&nbsp; 00400000
005E613C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font><br>
<font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>board
data at: 005E4124
005E413C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font><br>
<font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>relocated
to:&nbsp; 004050D0
004050E8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font><br>
<font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>zimage
at:&nbsp;&nbsp;&nbsp;&nbsp; 004057E9
005E3869&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font><br>
<font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>avail
ram:&nbsp;&nbsp;&nbsp;&nbsp; 005E7000
04000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font><o:p></o:p></p>

<p><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Linux/PPC
load:
console=3DttyS0,9600&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font><br>
<font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Uncompressing
Linux...done.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
</span></font><br>
<font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Now
booting the
kernel&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font><br>
<font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>[&nbsp;&nbsp;&nbsp;
0.000000] Linux version 2.6.17.1 (root@ansto1) (gcc version 3.4.5) #29 =
Thu Apr
27 11:13:26 EDT
2007&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font><o:p></o:p></p>

<p><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>[&nbsp;&nbsp;&nbsp;
0.000000] Xilinx ML403 Reference System (Virtex-4
FX)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font><br>
<font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>[&nbsp;&nbsp;&nbsp;
0.000000] Built 1
zonelists&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font><br>
<font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>[&nbsp;&nbsp;&nbsp;
0.000000] Kernel command line:
console=3DttyS0,9600&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font><br>
<font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>[&nbsp;&nbsp;&nbsp;
0.000000] Xilinx INTC #0 at 0x41200000 mapped to =
0xFDFFE000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
</span></font><o:p></o:p></p>

<p><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>[&nbsp;&nbsp;&nbsp;
0.000000] PID hash table entries: 512 (order: 9, 2048
bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font><o:p></o:p></p>

<p><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>[&nbsp;&nbsp;&nbsp;
0.000105] Console: colour dummy device =
80x25&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;
</span></font><br>
<font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>[&nbsp;&nbsp;&nbsp;
0.000394] Dentry cache hash table entries: 8192 (order: 3, 32768
bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;
</span></font><o:p></o:p></p>

<p><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>[&nbsp;&nbsp;&nbsp;
0.000887] Inode-cache hash table entries: 4096 (order: 2, 16384
bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
</span></font><o:p></o:p></p>

<p><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>[&nbsp;&nbsp;&nbsp;
0.009214] Memory: 61964k available (1292k kernel code, 468k data, 1172k =
init,
0k
highmem)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;
</span></font><br>
<font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>[&nbsp;&nbsp;&nbsp;
0.096238] Mount-cache hash table entries: =
512&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
</span></font><br>
<font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>[&nbsp;&nbsp;&nbsp;
0.435539] NET: Registered protocol family
16&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font><br>
<font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>[&nbsp;&nbsp;&nbsp;
0.440315] NET: Registered protocol family
2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font><br>
<font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>[&nbsp;&nbsp;&nbsp;
0.480121] IP route cache hash table entries: 512 (order: -1, 2048
bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
</span></font><o:p></o:p></p>

<p><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>[&nbsp;&nbsp;&nbsp;
0.480636] TCP established hash table entries: 2048 (order: 1, 8192
bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font><o:p></o:p></p>

<p><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>[&nbsp;&nbsp;&nbsp;
0.480755] TCP bind hash table entries: 1024 (order: 0, 4096
bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font><o:p></o:p></p>

<p><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>[&nbsp;&nbsp;&nbsp;
0.480821] TCP: Hash tables
configure&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
</span></font><br>
<font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>[&nbsp;&nbsp;&nbsp;
0.480843] TCP <st1:City w:st=3D"on"><st1:place =
w:st=3D"on">reno</st1:place></st1:City>
registered&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font><br>
<font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>[&nbsp;&nbsp;&nbsp;
0.484696] io scheduler noop
registered&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font><br>
<font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>[&nbsp;&nbsp;&nbsp;
0.484754] io scheduler anticipatory registered
(default)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;
</span></font><o:p></o:p></p>

<p><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>[&nbsp;&nbsp;&nbsp;
0.484799] io scheduler deadline
registered&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font><br>
<font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>[&nbsp;&nbsp;&nbsp;
0.484890] io scheduler cfq
registered&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font><br>
<font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>[&nbsp;&nbsp;&nbsp;
0.510230] Serial: 8250/16550 driver $Revision: 1.90 $ 1 ports, IRQ =
sharing
disabled&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></font><br>
<font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>[&nbsp;&nbsp;&nbsp;
0.511764] serial8250.0: ttyS0 at MMIO 0x40401003 (irq =3D 9) is a
16550A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
</span></font><o:p></o:p></p>

<p><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>[&nbsp;&nbsp;&nbsp;
0.924578] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024
blocksize&nbsp;&nbsp;&nbsp;&nbsp; </span></font><br>
<font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>[&nbsp;&nbsp;&nbsp;
0.948301] tun: Universal
TUN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font><br>
<font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>[&nbsp;&nbsp;&nbsp;
0.963483] tun: (C) 1999-2004 Max Krasnyansky
&lt;maxk@qualcomm.com&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font><o:p></o:p></p>

<p><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>[&nbsp;&nbsp;&nbsp;
0.982713] mice: PS/2 mouse device common for all
mice&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font><br>
<font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>[&nbsp;&nbsp;&nbsp;
0.998445] TCP bic
registered&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font><br>
<font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>[&nbsp;&nbsp;&nbsp;
1.007702] NET: Registered protocol family
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font><br>
<font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>[&nbsp;&nbsp;&nbsp;
1.020827] NET: Registered protocol family
17&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font><br>
<font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>[&nbsp;&nbsp;&nbsp;
1.034361] Freeing unused kernel memory: 1172k init&nbsp; =
</span></font><o:p></o:p></p>

</div>

</body>

</html>

------_=_NextPart_001_01C7890B.39BA0E6E--
