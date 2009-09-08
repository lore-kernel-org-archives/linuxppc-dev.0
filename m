Return-Path: <upatro@implantaire.com>
Received: from smtp102.biz.mail.in2.yahoo.com (smtp102.biz.mail.in2.yahoo.com
	[203.104.17.250])
	by bilbo.ozlabs.org (Postfix) with SMTP id 61C4BB7099
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Sep 2009 20:52:49 +1000 (EST)
From: "Uma Kanta Patro" <upatro@implantaire.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: Queries regarding I2C and GPIO driver for Freescale MPC5121e in Linux
	2.6.24 of BSP: MPC512xADS_20090603-ltib.iso
Date: Tue, 8 Sep 2009 16:25:30 +0530
Message-ID: <!&!AAAAAAAAAAAYAAAAAAAAACk7Zq0ADiBFlLw+tPrMt1bCgAAAEAAAAMhVxXG9wghAjqGQWiEYvY8BAAAAAA==@implantaire.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0001_01CA30A0.FBDF81B0"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.

------=_NextPart_000_0001_01CA30A0.FBDF81B0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi all,

                I am a newbie to the powerpc linux kernel, but I have worked
on some drivers in arm architecture. I am finding powerpc architecture to be
fully different than that.

I am working on Freescale MPC5121e with the BSP MPC512xADS_20090603-ltib.iso
running in it on the ADS512101 Rev4.1 development kit.

Can anyone help me in finding some documentation for understanding and
working on the powerpc kernel. Any links to the powerpc forums will also be
appreciable.

 

 

-> Currently I am going to develop an I2C client driver for one slave
microcontroller of our project.

I have some knowledge in the I2C client driver making(legacy style and new
style).

 

I made a basic I2C client driver to probe for the chip address and for
testing I gave it the chip address 0x68(I2C chip address of the M4T162 RTC,
present on the board).

But while inserting my driver I am getting failure message for the detection
of my chip.

 

So I would like to know what other formalities am I lagging in my I2C chip
driver.

 

-> Also I am in a need for the GPIO driver for my controller ot get
interrupt on ht estate change. When I searched in the kernel code I could
not find any procedure to do that, also I could not find out the procedure
to access either any GPIO pin macros or any register to remap with
ioremap(). So please guide me in finding the proper way to do the GPIO
accessing and interrupt registration.

Will the ioremap() work on powerpc arch? If yes where can I find the memory
mapping(register definitions) to use for my GPIO driver making.

 

Thanks for patience in reading my queries.

Any help is appreciable.

 

Thanks & Regards,

Uma

 


------=_NextPart_000_0001_01CA30A0.FBDF81B0
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
	{font-family:Batang;
	panose-1:2 3 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:Batang;
	panose-1:2 3 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@Batang";
	panose-1:2 3 6 0 0 1 1 1 1 1;}
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

<p class=3DMsoNormal>Hi all,<o:p></o:p></p>

<p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I
am a newbie to the powerpc linux kernel, but I have worked on some =
drivers in
arm architecture. I am finding powerpc architecture to be fully =
different than
that.<o:p></o:p></p>

<p class=3DMsoNormal>I am working on Freescale MPC5121e with the BSP =
MPC512xADS_20090603-ltib.iso
running in it on the ADS512101 Rev4.1 development kit.<o:p></o:p></p>

<p class=3DMsoNormal>Can anyone help me in finding some documentation =
for
understanding and working on the powerpc kernel. Any links to the =
powerpc
forums will also be appreciable.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>-&gt; Currently I am going to develop an I2C client =
driver
for one slave microcontroller of our project.<o:p></o:p></p>

<p class=3DMsoNormal>I have some knowledge in the I2C client driver =
making(legacy
style and new style).<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I made a basic I2C client driver to probe for the =
chip
address and for testing I gave it the chip address 0x68(I2C chip address =
of the
M4T162 RTC, present on the board).<o:p></o:p></p>

<p class=3DMsoNormal>But while inserting my driver I am getting failure =
message
for the detection of my chip.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>So I would like to know what other formalities am I =
lagging
in my I2C chip driver.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>-&gt; Also I am in a need for the GPIO driver for =
my
controller ot get interrupt on ht estate change. When I searched in the =
kernel
code I could not find any procedure to do that, also I could not find =
out the procedure
to access either any GPIO pin macros or any register to remap with =
ioremap().
So please guide me in finding the proper way to do the GPIO accessing =
and interrupt
registration.<o:p></o:p></p>

<p class=3DMsoNormal>Will the ioremap() work on powerpc arch? If yes =
where can I find
the memory mapping(register definitions) to use for my GPIO driver =
making.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Thanks for patience in reading my =
queries.<o:p></o:p></p>

<p class=3DMsoNormal>Any help is appreciable.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><span style=3D'font-size:12.0pt'>Thanks &amp; =
Regards,<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:12.0pt'>Uma</span><span
style=3D'font-size:12.0pt'><o:p></o:p></span></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

------=_NextPart_000_0001_01CA30A0.FBDF81B0--
