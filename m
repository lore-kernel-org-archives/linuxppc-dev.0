Return-Path: <sprasad@bivio.net>
Received: from corpexc01.corp.networkrobots.com (nofear-snat.bivio.net
	[216.142.75.231]) by ozlabs.org (Postfix) with ESMTP id B9BE9DDDF4
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 17:05:47 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C766C6.271BCB40"
Subject: RFI instruction not working as expected...
Date: Wed, 14 Mar 2007 22:52:44 -0700
Message-ID: <D83235F0F3C86D4D889D8B9A0DA8C6D746E3A5@corpexc01.corp.networkrobots.com>
From: "Siva Prasad" <sprasad@bivio.net>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C766C6.271BCB40
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

=20

I am trying to boot my 8641D based PowerPC board. I am having trouble
booting it.

=20

Following code snippet is from head_32.S.....

=20

        lis     r4,2f@h

        ori     r4,r4,2f@l

        tophys(r4,r4)

        li      r3,MSR_KERNEL & ~(MSR_IR|MSR_DR)

        FIX_SRR1(r3,r5)

        mtspr   SPRN_SRR0,r4

        mtspr   SPRN_SRR1,r3

        SYNC

        RFI

/* Load up the kernel context */

2:    bl      load_up_mmu

=20

=20

My code successfully reaches up to the RFI instruction, but never to "2:
bl load_up_mmu". I am not using any debugger (used an LED write to
address to figure it out) in this situation.

=20

Any suggestions on why my execution sequence never reaches the "2: "?

=20

I exhausted all types of debug information and appreciate any help.

=20

Thanks

Siva

=20


------_=_NextPart_001_01C766C6.271BCB40
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
font-family:Arial'>Hi,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am trying to boot my 8641D based PowerPC board. I =
am
having trouble booting it.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Following code snippet is from <i><span =
style=3D'font-style:
italic'>head_32.S</span></i>&#8230;..<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><b><i><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial;font-weight:bold;font-style:italic'>&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
lis&nbsp;&nbsp;&nbsp;&nbsp; r4,2f@h<o:p></o:p></span></font></i></b></p>

<p class=3DMsoNormal><b><i><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial;font-weight:bold;font-style:italic'>&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
ori&nbsp;&nbsp;&nbsp;&nbsp; =
r4,r4,2f@l<o:p></o:p></span></font></i></b></p>

<p class=3DMsoNormal><b><i><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial;font-weight:bold;font-style:italic'>&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
tophys(r4,r4)<o:p></o:p></span></font></i></b></p>

<p class=3DMsoNormal><b><i><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial;font-weight:bold;font-style:italic'>&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
li&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r3,MSR_KERNEL &amp; =
~(MSR_IR|MSR_DR)<o:p></o:p></span></font></i></b></p>

<p class=3DMsoNormal><b><i><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial;font-weight:bold;font-style:italic'>&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
FIX_SRR1(r3,r5)<o:p></o:p></span></font></i></b></p>

<p class=3DMsoNormal><b><i><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial;font-weight:bold;font-style:italic'>&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
mtspr&nbsp;&nbsp; SPRN_SRR0,r4<o:p></o:p></span></font></i></b></p>

<p class=3DMsoNormal><b><i><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial;font-weight:bold;font-style:italic'>&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
mtspr&nbsp;&nbsp; SPRN_SRR1,r3<o:p></o:p></span></font></i></b></p>

<p class=3DMsoNormal><b><i><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial;font-weight:bold;font-style:italic'>&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
SYNC<o:p></o:p></span></font></i></b></p>

<p class=3DMsoNormal><b><i><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial;font-weight:bold;font-style:italic'>&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
RFI<o:p></o:p></span></font></i></b></p>

<p class=3DMsoNormal><b><i><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial;font-weight:bold;font-style:italic'>/* Load up the =
kernel
context */<o:p></o:p></span></font></i></b></p>

<p class=3DMsoNormal><b><i><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial;font-weight:bold;font-style:italic'>2:&nbsp;&nbsp;&nbsp=
;
bl&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
load_up_mmu<o:p></o:p></span></font></i></b></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>My code successfully reaches up to the RFI =
instruction, but
never to &#8220;<b><i><span =
style=3D'font-weight:bold;font-style:italic'>2: bl
load_up_mmu</span></i></b>&#8221;. I am not using any debugger (used an =
LED
write to address to figure it out) in this =
situation.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Any suggestions on why my execution sequence never =
reaches
the &#8220;<b><i><span =
style=3D'font-weight:bold;font-style:italic'>2:</span></i></b>
&#8220;?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I exhausted all types of debug information and =
appreciate
any help.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Siva<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C766C6.271BCB40--
