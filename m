Return-Path: <kmilligan@austin.polycom.com>
Received: from ausexch00.austin.polycom.com (unknown [216.54.148.81])
	by ozlabs.org (Postfix) with ESMTP id A39E82BEA0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Nov 2004 08:29:11 +1100 (EST)
Message-ID: <F3CF3D25A7F8F44BB59BC7A2CA83E30B0232224F@ausexch00.austin.polycom.com>
From: "Milligan, Keath" <kmilligan@austin.polycom.com>
To: linuxppc-embedded@ozlabs.org
Date: Wed, 17 Nov 2004 15:13:27 -0600
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C4CCEA.47D9DBD0"
Subject: MPC8272ADS PCI device mapping
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C4CCEA.47D9DBD0
Content-Type: text/plain

Hello,

 

I am having trouble getting PCI devices mapped correctly under Linux 2.4.22
running on an MPC8272ADS evaluation board.

 

I have multiple PCI-attached devices with a total of 512MB of prefetchable
memory and about 200MB of non-prefetchable memory address spaces in various
block sizes. All of the devices are behind a PCI-to-PCI bridge that is
plugged into the ADS.

 

At this stage in my project, these devices are initializing themselves to
base addresses that need to be moved when Linux boots on the 8272. The
problem I am having is that Linux is trying to remap everything, but is
unable to allocate regions for everything, so I end up with most of the
devices mapped to the same (invalid) address.

 

I've tried hacking the kernel PCI initialization to manually set all the
base addresses, but it seems to be ignoring that for the most part.

 

Could someone point me in the right direction to getting everything
initialized and mapped correctly?

 

Thanks

 


------_=_NextPart_001_01C4CCEA.47D9DBD0
Content-Type: text/html

<html>

<head>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=US-ASCII">


<meta name=Generator content="Microsoft Word 10 (filtered)">

<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Batang;
	panose-1:2 3 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:"\@Batang";
	panose-1:2 3 6 0 0 1 1 1 1 1;}
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
	margin-left:0in;
	page-break-after:avoid;
	font-size:16.0pt;
	font-family:Arial;}
h2
	{margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	page-break-after:avoid;
	font-size:14.0pt;
	font-family:Arial;
	font-style:italic;}
h3
	{margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	page-break-after:avoid;
	font-size:13.0pt;
	font-family:Arial;}
h4
	{margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	page-break-after:avoid;
	font-size:13.0pt;
	font-family:Arial;
	font-style:italic;}
h5
	{margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	page-break-after:avoid;
	font-size:12.0pt;
	font-family:Arial;}
h6
	{margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	page-break-after:avoid;
	font-size:12.0pt;
	font-family:Arial;
	font-style:italic;}
p.MsoHeading7, li.MsoHeading7, div.MsoHeading7
	{margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	page-break-after:avoid;
	font-size:12.0pt;
	font-family:Arial;}
p.MsoHeading8, li.MsoHeading8, div.MsoHeading8
	{margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	page-break-after:avoid;
	font-size:12.0pt;
	font-family:Arial;
	font-style:italic;}
p.MsoHeading9, li.MsoHeading9, div.MsoHeading9
	{margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	page-break-after:avoid;
	font-size:11.0pt;
	font-family:Arial;}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=EN-US link=blue vlink=purple>

<div class=Section1>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>Hello,</span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>I am having trouble getting PCI devices mapped correctly
under Linux 2.4.22 running on an MPC8272ADS evaluation board.</span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>I have multiple PCI-attached devices with a total of 512MB
of prefetchable memory and about 200MB of non-prefetchable memory address
spaces in various block sizes. All of the devices are behind a PCI-to-PCI
bridge that is plugged into the ADS.</span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>At this stage in my project, these devices are initializing
themselves to base addresses that need to be moved when Linux boots on the 8272.
The problem I am having is that Linux is trying to remap everything, but is
unable to allocate regions for everything, so I end up with most of the devices
mapped to the same (invalid) address.</span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>I've tried hacking the kernel PCI initialization to
manually set all the base addresses, but it seems to be ignoring that for the
most part.</span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>Could someone point me in the right direction to getting
everything initialized and mapped correctly?</span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>Thanks</span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C4CCEA.47D9DBD0--
