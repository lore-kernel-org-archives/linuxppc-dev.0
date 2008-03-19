Return-Path: <Phil.Hochstetler@serveron.com>
Received: from mail.serveron.com (mail.serveron.com [198.107.14.70])
	by ozlabs.org (Postfix) with ESMTP id 4A36EDE07A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Mar 2008 04:27:14 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C889E6.7854B9B5"
Subject: Uart(lite)/ELDK 4.1 section mismatch -> ML403
Date: Wed, 19 Mar 2008 10:27:02 -0700
Message-ID: <ADA5878BA63680469C75C14CEEE2FE28012F54A0@mail.serveron.com>
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

------_=_NextPart_001_01C889E6.7854B9B5
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I just booted the "git.xilinx.com/Linux-2.6-xlnx" source code to a login
prompt last week.  I'm using Xilinx EDK 9.2 and ELDK 4.1 crosstools
(uclib version) and Ubuntu 7.10 workstation as my host OS (under
VMware).  The easiest path is to use the Uartlite driver (and disable
the 82550 stuff because the stand directory will not compile currently,
there is a patch somewhere on the last from last Jan about what defines
are missing but you can just use uartlite instead).  Be sure to use the
correct reference design (I started with the Virtex4_PPC_Example_9_2.zip
in EDK/EDKexamples directory).   Add the sysace driver into the design
and (w/ interrupts on) and make sure you have uartlite selected (with
interrupts on).  Build the design and use the xparameters_403.h file to
build your kernel.  In this case, be sure to turn on uartlite console
support and turn off 82550 console support or your kernel will not work.
Also be sure to add Ext3 filesystem to your kernel config.  Once you add
the sysace driver support, you can then create a ace file and replace
their kernel on the compact flash and boot it to their root filesystem
(works, I just did it).  This gets you a full booted kernel on a working
root filesystem with min work.

=20

For references see: =20

  http://wiki.secretlab.ca/index.php/Linux_on_Xilinx_Virtex

=20
http://simfami.marlab.ac.uk/piprg/wiki/index.php?title=3DInstalling_Linux=
_
Kernel_2.6.23_on_the_PPC405_core_of_a_Xilinx_ML403_board

=20

--phil

 =20


------_=_NextPart_001_01C889E6.7854B9B5
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

<p class=3DMsoNormal>I just booted the =
&#8220;git.xilinx.com/Linux-2.6-xlnx&#8221;
source code to a login prompt last week.&nbsp; I&#8217;m using Xilinx =
EDK 9.2
and ELDK 4.1 crosstools (uclib version) and Ubuntu 7.10 workstation as =
my host OS
(under VMware).&nbsp; The easiest path is to use the Uartlite driver =
(and
disable the 82550 stuff because the stand directory will not compile =
currently,
there is a patch somewhere on the last from last Jan about what defines =
are
missing but you can just use uartlite instead).&nbsp; Be sure to use the
correct reference design (I started with the Virtex4_PPC_Example_9_2.zip =
in EDK/EDKexamples
directory).&nbsp;&nbsp; Add the sysace driver into the design and (w/ =
interrupts
on) and make sure you have uartlite selected (with interrupts on).&nbsp; =
Build
the design and use the xparameters_403.h file to build your =
kernel.&nbsp; In
this case, be sure to turn on uartlite console support and turn off =
82550
console support or your kernel will not work.&nbsp; Also be sure to add =
Ext3
filesystem to your kernel config.&nbsp; Once you add the sysace driver =
support,
you can then create a ace file and replace their kernel on the compact =
flash
and boot it to their root filesystem (works, I just did it). &nbsp;This =
gets
you a full booted kernel on a working root filesystem with min =
work.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>For references see:&nbsp; <o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; <a
href=3D"http://wiki.secretlab.ca/index.php/Linux_on_Xilinx_Virtex">http:/=
/wiki.secretlab.ca/index.php/Linux_on_Xilinx_Virtex</a><o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; <a
href=3D"http://simfami.marlab.ac.uk/piprg/wiki/index.php?title=3DInstalli=
ng_Linux_Kernel_2.6.23_on_the_PPC405_core_of_a_Xilinx_ML403_board">http:/=
/simfami.marlab.ac.uk/piprg/wiki/index.php?title=3DInstalling_Linux_Kerne=
l_2.6.23_on_the_PPC405_core_of_a_Xilinx_ML403_board</a><o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>--phil<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; <o:p></o:p></p>

</div>

</body>

</html>

------_=_NextPart_001_01C889E6.7854B9B5--
