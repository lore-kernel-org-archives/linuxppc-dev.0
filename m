Return-Path: <John.Linn@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C88F80.A742D536"
Subject: RE: Cannot open root device "xsysace/disco0/part3" or 00:00
Date: Wed, 26 Mar 2008 14:33:29 -0600
In-Reply-To: <001101c88f79$17da5ae0$7738f496@JoseLuisAM>
References: <001101c88f79$17da5ae0$7738f496@JoseLuisAM>
From: "John Linn" <John.Linn@xilinx.com>
To: =?iso-8859-1?Q?Jos=E9_Luis_A=F1amuro_Machicao?=
	<jose.annamuro@ESTUDIANTE.UAM.ES>, <Linuxppc-embedded@ozlabs.org>
Message-Id: <20080326203332.4013DC6011A@mail222-sin.bigfish.com>
Cc: jose_luis@fun-humanismo-ciencia.es
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

------_=_NextPart_001_01C88F80.A742D536
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Jose,

=20

I didn't see that you configured the kernel to put the Xilinx system ace =
driver in?

=20

It's under device drivers, block devices.

=20

Thanks,

John

=20

________________________________

From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org =
[mailto:linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org] On =
Behalf Of Jos=E9 Luis A=F1amuro Machicao
Sent: Wednesday, March 26, 2008 1:39 PM
To: Linuxppc-embedded@ozlabs.org
Cc: jose_luis@fun-humanismo-ciencia.es
Subject: Cannot open root device "xsysace/disco0/part3" or 00:00

=20

Hi

I am installing the linux kernel 2.4.26 in the FPGA Virtex II Pro =
following the instruction of=20

http://www.cs.washington.edu/research/lis/empart/xup_ppc_linux.shtml

=20

I compiled the linux kernel successfully, after that I build the root =
file system using the BusyBox 1.1.0 infrastructure. I configured the =
busybox and the kernel with the cross compiler, finally I execute the =
mkrootfs.sh script and obtain the all files of fyle system, these files =
I copied to ext3 partition of CompacFlash when I probe operati=F3n by =
the hyperTerminal (38400 bps) appears a error that say:

=20

Serial driver version 5.05c (2001-07-08) with no serial options enabled
ttyS00 at 0xfdfff003 (irq =3D 30) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
VFS: Cannot open root device "xsysace/disco0/part3" or 00:00
Please append a correct "root=3D" boot option
Kernel panic: VFS: Unable to mount root fs on 00:00
 <0>Rebooting in 180 seconds.

=20

=20

I configured the linux kernel with:

=20

Code maturity level options --->=20

            [*] Prompt for development and/or incomplete code/drivers=20

File systems --->=20

    [*] /dev file system support (EXPERIMENTAL)=20

     [*] Automatically mount at boot=20

    [*] Virtual memory file system support (former shm fs)=20

    [*] /proc file system support=20

General Setup --->=20

    [*] Networking support=20

    [*] Sysctl support=20

    [*] System V IPC=20

=20

and edit the /etc/fstab=20

tmpfs /dev/shm tmpfs nodev,nosuid,noexec 0 0=20

proc /proc proc defaults 0 0

/dev/root / auto defaults,errors=3Dremount-ro 0 0=20

=20

-------------------------------------------------------------------------=
------------
__    _        __  __      Jos=E9 Luis A=F1amuro - PhD Student
\/    V  /\  |\_\ /\_\      Dept. Ingenier=EDa Inform=E1tica
| |     |  /  \  | |  \/  |   |    Universidad Aut=F3noma de Madrid
| |     | / /\\ | |   |   |   |    Lab B-209   Tel. +34 615887260
| |     |/ __ \| | \  /    |    http://www.ii.uam.es/
`-_-/_/    \_\|_|\/|__|=20


------_=_NextPart_001_01C88F80.A742D536
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
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
h1
	{margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:.3in;
	text-indent:-.3in;
	page-break-after:avoid;
	mso-list:l0 level1 lfo3;
	font-size:16.0pt;
	font-family:Arial;
	font-weight:bold;}
h2
	{margin-top:0in;
	margin-right:0in;
	margin-bottom:12.0pt;
	margin-left:.4in;
	text-indent:-.4in;
	page-break-after:avoid;
	mso-list:l0 level2 lfo3;
	font-size:14.0pt;
	font-family:Arial;
	font-weight:bold;}
h3
	{margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:.5in;
	text-indent:-.5in;
	page-break-after:avoid;
	mso-list:l1 level3 lfo6;
	font-size:13.0pt;
	font-family:Arial;
	font-weight:bold;}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:blue;
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
	margin:.5in .5in .5in .5in;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:1143350910;
	mso-list-template-ids:1338282562;}
@list l0:level1
	{mso-level-style-link:"Heading 1";
	mso-level-text:%1;
	mso-level-tab-stop:.3in;
	mso-level-number-position:left;
	margin-left:.3in;
	text-indent:-.3in;}
@list l0:level2
	{mso-level-style-link:"Heading 2";
	mso-level-text:"%1\.%2";
	mso-level-tab-stop:.4in;
	mso-level-number-position:left;
	margin-left:.4in;
	text-indent:-.4in;}
@list l0:level3
	{mso-level-text:"%1\.%2\.%3";
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	margin-left:.5in;
	text-indent:-.5in;}
@list l0:level4
	{mso-level-text:"%1\.%2\.%3\.%4";
	mso-level-tab-stop:.6in;
	mso-level-number-position:left;
	margin-left:.6in;
	text-indent:-.6in;}
@list l0:level5
	{mso-level-text:"%1\.%2\.%3\.%4\.%5";
	mso-level-tab-stop:.7in;
	mso-level-number-position:left;
	margin-left:.7in;
	text-indent:-.7in;}
@list l0:level6
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6";
	mso-level-tab-stop:.8in;
	mso-level-number-position:left;
	margin-left:.8in;
	text-indent:-.8in;}
@list l0:level7
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7";
	mso-level-tab-stop:.9in;
	mso-level-number-position:left;
	margin-left:.9in;
	text-indent:-.9in;}
@list l0:level8
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8";
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	margin-left:1.0in;
	text-indent:-1.0in;}
@list l0:level9
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8\.%9";
	mso-level-tab-stop:1.1in;
	mso-level-number-position:left;
	margin-left:1.1in;
	text-indent:-1.1in;}
@list l1
	{mso-list-id:1860200171;
	mso-list-template-ids:1400561736;}
@list l1:level1
	{mso-level-text:%1;
	mso-level-tab-stop:.3in;
	mso-level-number-position:left;
	margin-left:.3in;
	text-indent:-.3in;}
@list l1:level2
	{mso-level-text:"%1\.%2";
	mso-level-tab-stop:.4in;
	mso-level-number-position:left;
	margin-left:.4in;
	text-indent:-.4in;}
@list l1:level3
	{mso-level-reset-level:level2;
	mso-level-style-link:"Heading 3";
	mso-level-text:"%1\.%2\.%3";
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	margin-left:.5in;
	text-indent:-.5in;}
@list l1:level4
	{mso-level-text:"%1\.%2\.%3\.%4";
	mso-level-tab-stop:.6in;
	mso-level-number-position:left;
	margin-left:.6in;
	text-indent:-.6in;}
@list l1:level5
	{mso-level-text:"%1\.%2\.%3\.%4\.%5";
	mso-level-tab-stop:.7in;
	mso-level-number-position:left;
	margin-left:.7in;
	text-indent:-.7in;}
@list l1:level6
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6";
	mso-level-tab-stop:.8in;
	mso-level-number-position:left;
	margin-left:.8in;
	text-indent:-.8in;}
@list l1:level7
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7";
	mso-level-tab-stop:.9in;
	mso-level-number-position:left;
	margin-left:.9in;
	text-indent:-.9in;}
@list l1:level8
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8";
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	margin-left:1.0in;
	text-indent:-1.0in;}
@list l1:level9
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8\.%9";
	mso-level-tab-stop:1.1in;
	mso-level-number-position:left;
	margin-left:1.1in;
	text-indent:-1.1in;}
@list l2
	{mso-list-id:2077240681;
	mso-list-template-ids:-762429638;}
@list l2:level1
	{mso-level-text:%1;
	mso-level-tab-stop:.3in;
	mso-level-number-position:left;
	margin-left:.3in;
	text-indent:-.3in;}
@list l2:level2
	{mso-level-text:"%1\.%2";
	mso-level-tab-stop:.4in;
	mso-level-number-position:left;
	margin-left:.4in;
	text-indent:-.4in;}
@list l2:level3
	{mso-level-text:"%1\.%2\.%3";
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	margin-left:.5in;
	text-indent:-.5in;}
@list l2:level4
	{mso-level-text:"%1\.%2\.%3\.%4";
	mso-level-tab-stop:.6in;
	mso-level-number-position:left;
	margin-left:.6in;
	text-indent:-.6in;}
@list l2:level5
	{mso-level-text:"%1\.%2\.%3\.%4\.%5";
	mso-level-tab-stop:.7in;
	mso-level-number-position:left;
	margin-left:.7in;
	text-indent:-.7in;}
@list l2:level6
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6";
	mso-level-tab-stop:.8in;
	mso-level-number-position:left;
	margin-left:.8in;
	text-indent:-.8in;}
@list l2:level7
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7";
	mso-level-tab-stop:.9in;
	mso-level-number-position:left;
	margin-left:.9in;
	text-indent:-.9in;}
@list l2:level8
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8";
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	margin-left:1.0in;
	text-indent:-1.0in;}
@list l2:level9
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8\.%9";
	mso-level-tab-stop:1.1in;
	mso-level-number-position:left;
	margin-left:1.1in;
	text-indent:-1.1in;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body bgcolor=3Dwhite lang=3DEN-US link=3Dblue vlink=3Dblue>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Hi =
Jose,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>I didn&#8217;t see that you =
configured the
kernel to put the Xilinx system ace driver =
in?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>It&#8217;s under device drivers, =
block
devices.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Thanks,<o:p></o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>John<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

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
style=3D'font-weight:bold'>On Behalf Of </span></b>Jos=E9 Luis A=F1amuro =
Machicao<br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Wednesday, March =
26, 2008
1:39 PM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> =
Linuxppc-embedded@ozlabs.org<br>
<b><span style=3D'font-weight:bold'>Cc:</span></b>
jose_luis@fun-humanismo-ciencia.es<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> Cannot open root =
device
&quot;xsysace/disco0/part3&quot; or 00:00</span></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<div>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hi</span></font><o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am installing the linux kernel 2.4.26 in the FPGA =
Virtex
II Pro following the instruction of </span></font><o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><a
href=3D"http://www.cs.washington.edu/research/lis/empart/xup_ppc_linux.sh=
tml">http://www.cs.washington.edu/research/lis/empart/xup_ppc_linux.shtml=
</a></span></font><o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I compiled the linux kernel successfully, after that =
I build
the root file system using the BusyBox 1.1.0 infrastructure. I =
configured the
busybox and the kernel with the cross compiler, finally&nbsp;I execute =
the
mkrootfs.sh script and&nbsp;obtain the all files of fyle&nbsp;system, =
these
files I copied to ext3 partition of CompacFlash when I =
probe&nbsp;operati=F3n
by&nbsp;the hyperTerminal (38400 bps) appears a error that =
say:</span></font><o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Serial driver version 5.05c (2001-07-08) with no =
serial
options enabled<br>
ttyS00 at 0xfdfff003 (irq =3D 30) is a 16550A<br>
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 =
blocksize<br>
VFS: Cannot open root device &quot;xsysace/disco0/part3&quot; or =
00:00<br>
Please append a correct &quot;root=3D&quot; boot option<br>
Kernel panic: VFS: Unable to mount root fs on 00:00<br>
&nbsp;&lt;0&gt;Rebooting in 180 seconds.</span></font><o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I configured the linux kernel =
with:</span></font><o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p><font size=3D2 face=3D"Times New Roman"><span =
style=3D'font-size:10.0pt'>Code
maturity level options ---&gt; <o:p></o:p></span></font></p>

<p><font size=3D2 face=3D"Times New Roman"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; [*] Prompt for development and/or
incomplete code/drivers <o:p></o:p></span></font></p>

<p><font size=3D2 face=3D"Times New Roman"><span =
style=3D'font-size:10.0pt'>File
systems ---&gt; <o:p></o:p></span></font></p>

<p><font size=3D2 face=3D"Times New Roman"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;
[*] /dev file system support (EXPERIMENTAL) =
<o:p></o:p></span></font></p>

<p><font size=3D2 face=3D"Times New Roman"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[*]
Automatically mount at boot <o:p></o:p></span></font></p>

<p><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt'>&nbsp;&nbsp;&nbsp;
[*] Virtual memory file system support (former shm fs) =
<o:p></o:p></span></font></p>

<p><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt'>&nbsp;&nbsp;&nbsp;
[*] /proc file system support <o:p></o:p></span></font></p>

<p><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt'>General
Setup ---&gt; <o:p></o:p></span></font></p>

<p><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt'>&nbsp;&nbsp;&nbsp;
[*] Networking support <o:p></o:p></span></font></p>

<p><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt'>&nbsp;&nbsp;&nbsp;
[*] Sysctl support <o:p></o:p></span></font></p>

<p><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt'>&nbsp;&nbsp;&nbsp;
[*] System V IPC <o:p></o:p></span></font></p>

<p><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt'>&nbsp;<o:p></o:p></span></font></p>

<p><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>and
edit the /etc/fstab </span></font><font size=3D2><span =
style=3D'font-size:10.0pt'><o:p></o:p></span></font></p>

<p><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;font-family:Arial'>tmpfs
/dev/shm tmpfs nodev,nosuid,noexec 0 0 <o:p></o:p></span></font></p>

<p><font size=3D3 face=3D"Courier New"><span =
style=3D'font-size:12.0pt;font-family:
"Courier New"'>proc /proc proc defaults 0 0<o:p></o:p></span></font></p>

<p><font size=3D3 face=3D"Courier New"><span =
style=3D'font-size:12.0pt;font-family:
"Courier New"'>/dev/root / auto defaults,errors=3Dremount-ro 0 0 =
<o:p></o:p></span></font></p>

<p><font size=3D2 face=3D"Times New Roman"><span =
style=3D'font-size:10.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>------------------------------------------------------=
-------------------------------<br>
__&nbsp;&nbsp;&nbsp; _&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
__&nbsp;
__&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Jos=E9 Luis A=F1amuro - PhD Student<br>
\/&nbsp;&nbsp;&nbsp; V&nbsp; /\&nbsp; |\_\ =
/\_\&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Dept. Ingenier=EDa Inform=E1tica<br>
| |&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; /&nbsp; \&nbsp; | |&nbsp; \/&nbsp;
|&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; Universidad Aut=F3noma de Madrid<br>
| |&nbsp;&nbsp;&nbsp;&nbsp; | / /\\ | |&nbsp;&nbsp; |&nbsp;&nbsp; =
|&nbsp;&nbsp;
|&nbsp;&nbsp;&nbsp; Lab B-209&nbsp;&nbsp; Tel. +34 615887260<br>
| |&nbsp;&nbsp;&nbsp;&nbsp; |/ __ \| | \&nbsp; /&nbsp;&nbsp;&nbsp;
|&nbsp;&nbsp;&nbsp; <a =
href=3D"http://www.ii.uam.es/">http://www.ii.uam.es/</a><br>
`-_-/_/&nbsp;&nbsp;&nbsp; \_\|_|\/|__| </span></font><o:p></o:p></p>

</div>

</div>

</body>

</html>

------_=_NextPart_001_01C88F80.A742D536--
