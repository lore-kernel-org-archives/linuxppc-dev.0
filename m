Return-Path: <Mike.Shelley@viasat.com>
Received: from VCAEXCH02.hq.corp.viasat.com (kestrel.viasat.com
	[199.106.52.139]) by ozlabs.org (Postfix) with ESMTP id 2C282DDDF3
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 May 2007 11:32:37 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C79E6B.3E988065"
Subject: initramfs on ppc 405: crc error
Date: Thu, 24 May 2007 18:23:31 -0700
Message-ID: <821B2170E9E7F04FA38DF7EC21DE487109470913@VCAEXCH01.hq.corp.viasat.com>
From: "Shelley, Mike" <Mike.Shelley@viasat.com>
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

------_=_NextPart_001_01C79E6B.3E988065
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I'm having a similar problem to a question posted earlier with
initramfs. =20

=20

I'm using the 2.6.20 kernel, on a Xilinx Virtex 4, ppc405, no boot
loader.  I use a BDI2000 to load the kernel image directly into RAM
(32MB). =20

=20

When I use a larger (4mb compressed, 13mb uncompressed) cpio archive for
initramfs, I get a crc error when it tries to decompress it.  When I use
a small simple archive (30k), it works correctly and does not have the
crc problem.  I've tried a cpio.gz archive of about 2mb and still get
the crc error.  Are there any size limitations for the kernel and/or for
initramfs?  What else could the problem be? =20

=20

The kernel image is being loaded to an address of 0x800000 instead of
0x400000 since it has problems decompressing the kernel at the lower
address, I'm told due to the size of the kernel image (5mb compressed).
Could this positioning be interfering with the initramfs decompression?
Where is the initramfs decompressed to?

=20

Any help would be appreciated.

Thanks,

Mike


------_=_NextPart_001_01C79E6B.3E988065
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
font-family:Arial'>I&#8217;m having a similar problem to a question =
posted
earlier with initramfs.&nbsp; <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I&#8217;m using the 2.6.20 kernel, on a Xilinx Virtex =
4,
ppc405, no boot loader.&nbsp; I use a BDI2000 to load the kernel image =
directly
into RAM (32MB).&nbsp; <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>When I use a larger (4mb compressed, 13mb =
uncompressed) cpio
archive for initramfs, I get a crc error when it tries to decompress =
it.&nbsp; When
I use a small simple archive (30k), it works correctly and does not have =
the
crc problem.&nbsp; I&#8217;ve tried a cpio.gz archive of about 2mb and =
still
get the crc error.&nbsp; Are there any size limitations for the kernel =
and/or
for initramfs?&nbsp; What else could the problem be?&nbsp; =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>The kernel image is being loaded to an address of =
0x800000
instead of 0x400000 since it has problems decompressing the kernel at =
the lower
address, I&#8217;m told due to the size of the kernel image (5mb
compressed).&nbsp; Could this positioning be interfering with the =
initramfs decompression?&nbsp;
Where is the initramfs decompressed to?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Any help would be =
appreciated.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Mike<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C79E6B.3E988065--
