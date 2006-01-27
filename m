Return-Path: <cwardman@sbir.com>
Received: from PANDORA.Askani.sbir.com (mail.sbir.com [64.136.136.27])
	by ozlabs.org (Postfix) with ESMTP id 17E4068A9A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Jan 2006 13:23:00 +1100 (EST)
Subject: kernel access of bad area
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C622E6.C2DD66F0"
Date: Thu, 26 Jan 2006 18:09:52 -0800
Message-ID: <72B3A11AD6E92B4FB11A00617D49FFEA8C12D8@PANDORA.Askani.sbir.com>
From: "Chris Wardman" <cwardman@sbir.com>
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

------_=_NextPart_001_01C622E6.C2DD66F0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I'm working on getting a MPC885 to interface with an onboard CPLD.  I've
successfully talked to the CPLD from our diagnostic application and I
know that it works at the locations that I specified in the IMMR. I know
that when linux loads that the IMMR still has the settings. However,
when I try to do a read from the address I get the following error:

=20

Oops: kernel access of bad area, sig: 11

NIP: C00BDED8 XER: 8000FF40 LR: C00BDCE0 SP: C1C81E30 REGS: c1c81d80
TRAP: 0300

MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11

DAR: F4000002, DSISR: 00000129

TASK =3D c1c80000[19] 'acc2test' Last syscall: 54

last math 00000000 last altivec 00000000

GPR00: 00000001 C1C81E30 C1C80000 FFFFFFFA C1C81E38 20004C0A 7FFFFE6C
3000B8A8

GPR08: 10000560 F4000002 00000001 00000000 538D6C93 10018688 00000000
40000000

GPR16: 00000000 00000000 00000001 00000000 00009032 01C81E80 00000000
C0002838

GPR24: C0002560 10000560 30024E9C 00000003 C015C198 C015C1C4 7FFFFE6C
20004C0A

Call backtrace:

C003D81C C0042AA4 C00025BC 100106E8 10000494 0FECED14 00000000

SIGSEGV

=20

It appears it is dying in the memory manager because of a bad page
fault.=20

Does anyone have any suggestion as how to fix this?

=20

Thanx,=20

-Chris

=20


------_=_NextPart_001_01C622E6.C2DD66F0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">


<meta name=3DGenerator content=3D"Microsoft Word 10 (filtered)">

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

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I&#8217;m working on getting a MPC885 to interface =
with an
onboard CPLD. &nbsp;I&#8217;ve successfully talked to the CPLD from our
diagnostic application and I know that it works at the locations that I
specified in the IMMR. I know that when linux loads that the IMMR still =
has the
settings. However, when I try to do a read from the address I get the =
following
error:</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Oops: kernel access of bad area, sig: =
11</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>NIP: C00BDED8 XER: 8000FF40 LR: C00BDCE0 SP: C1C81E30 =
REGS:
c1c81d80 TRAP: 0300</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: =
11</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>DAR: F4000002, DSISR: 00000129</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>TASK =3D c1c80000[19] 'acc2test' Last syscall: =
54</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>last math 00000000 last altivec =
00000000</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>GPR00: 00000001 C1C81E30 C1C80000 FFFFFFFA C1C81E38 =
20004C0A
7FFFFE6C 3000B8A8</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>GPR08: 10000560 F4000002 00000001 00000000 538D6C93 =
10018688
00000000 40000000</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>GPR16: 00000000 00000000 00000001 00000000 00009032 =
01C81E80
00000000 C0002838</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>GPR24: C0002560 10000560 30024E9C 00000003 C015C198 =
C015C1C4
7FFFFE6C 20004C0A</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Call backtrace:</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>C003D81C C0042AA4 C00025BC 100106E8 10000494 0FECED14
00000000</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>SIGSEGV</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>It appears it is dying in the memory manager because =
of a
bad page fault. </span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Does anyone have any suggestion as how to fix =
this?</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanx, </span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>-Chris</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C622E6.C2DD66F0--
