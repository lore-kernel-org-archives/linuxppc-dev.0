Return-Path: <Phil.Hochstetler@serveron.com>
Received: from mail.serveron.com (mail.serveron.com [198.107.14.70])
	by ozlabs.org (Postfix) with ESMTP id 2FB0FDE14A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Mar 2008 05:34:27 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C882DD.56BB5AB8"
Subject: Xilinx EDK 9.2i and current Linux src tree(s)
Date: Mon, 10 Mar 2008 11:34:09 -0700
Message-ID: <ADA5878BA63680469C75C14CEEE2FE28012F4DBA@mail.serveron.com>
From: "Phil Hochstetler" <Phil.Hochstetler@serveron.com>
To: <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C882DD.56BB5AB8
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks to responses from this group, I'm using Ubuntu and ELDK 4.1, I
have a working environment to build a linux kernel for a Xilinx ML403
board.  I pulled the kernel source at
git://git.xilinx.com/linux-2.6-xlnx.git
<http://git.xilinx.com/cgi-bin/gitweb.cgi?p=3Dlinux-2.6-xlnx.git;a=3Dsumm=
ary
>  and while it will compile using "make ARCH=3Dppc ml403_defconfig" and
"make ARCH=3Dppc CROSS_COMPILE=3Dppc_4xx- bzImage", when I use the EDK =
9.2i
to create a bitstream for the ML403 board, the BSP based header files
(xparam*) files are out of sync with the kernel source.  The files in
the linux-2.6-xlnx tree appear to have been build with EDK 7.1 and I am
using the current EDK release 9.2i.  The major diff seems to be that the
new EDK release moves all the periphials off the OPB bus and uses the
XPS bus instead.  Any ideas on how best to resolve this?  Is there a
linux tree out there that is synced with the current EDK release?   Is
it sufficient to had edit in the hardware address in the existing OPB
based file and ignore the differences between OPB and XPS?   Is the
difference in name only?  Should I just try to pick up the entire linux
tree from the EDK release and drop it on the linux kernel?  Has anyone
else been down this path already?  Thanks for any words of wisdom.

--phil


------_=_NextPart_001_01C882DD.56BB5AB8
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
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
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
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

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal>Thanks to responses from this group, I&#8217;m =
using Ubuntu
and ELDK 4.1, I have a working environment to build a linux kernel for a =
Xilinx
ML403 board.&nbsp; I pulled the kernel source at <a
href=3D"http://git.xilinx.com/cgi-bin/gitweb.cgi?p=3Dlinux-2.6-xlnx.git;a=
=3Dsummary"
title=3D"http://git.xilinx.com/cgi-bin/gitweb.cgi?p=3Dlinux-2.6-xlnx.git;=
a=3Dsummary">git://git.xilinx.com/linux-2.6-xlnx.git</a>
and while it will compile using &#8220;make ARCH=3Dppc =
ml403_defconfig&#8221; and
&#8220;make ARCH=3Dppc CROSS_COMPILE=3Dppc_4xx- bzImage&#8221;, when I =
use the EDK
9.2i to create a bitstream for the ML403 board, the BSP based header =
files
(xparam*) files are out of sync with the kernel source.&nbsp; The files =
in the linux-2.6-xlnx
tree appear to have been build with EDK 7.1 and I am using the current =
EDK
release 9.2i.&nbsp; The major diff seems to be that the new EDK release =
moves
all the periphials off the OPB bus and uses the XPS bus instead.&nbsp; =
Any ideas
on how best to resolve this?&nbsp; Is there a linux tree out there that =
is synced
with the current EDK release? &nbsp;&nbsp;Is it sufficient to had edit =
in the hardware
address in the existing OPB based file and ignore the differences =
between OPB
and XPS?&nbsp;&nbsp; Is the difference in name only?&nbsp; Should I just =
try to
pick up the entire linux tree from the EDK release and drop it on the =
linux
kernel?&nbsp; Has anyone else been down this path already?&nbsp; Thanks =
for any
words of wisdom.<o:p></o:p></p>

<p class=3DMsoNormal>--phil<o:p></o:p></p>

</div>

</body>

</html>

------_=_NextPart_001_01C882DD.56BB5AB8--
