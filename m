Return-Path: <dcogley@uslinc.com>
Received: from que03.charter.net (que03.charter.net [209.225.8.191])
	by ozlabs.org (Postfix) with ESMTP id 1A65ADDEF7
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Apr 2008 04:37:24 +1100 (EST)
Received: from aarprv04.charter.net ([10.20.200.74]) by mta11.charter.net
	(InterMail vM.7.08.03.00 201-2186-126-20070710) with ESMTP
	id <20080402171502.YJCG5653.mta11.charter.net@aarprv04.charter.net>
	for <linuxppc-embedded@ozlabs.org>; Wed, 2 Apr 2008 13:15:02 -0400
Received: from DCOGLEYNEW ([71.93.35.174]) by aarprv04.charter.net with ESMTP
	id <20080402171501.XDPJ17353.aarprv04.charter.net@DCOGLEYNEW>
	for <linuxppc-embedded@ozlabs.org>; Wed, 2 Apr 2008 13:15:01 -0400
From: "Dave Cogley" <dcogley@uslinc.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: u-boot ppc440epx bootstrap configuration without eval board
Date: Wed, 2 Apr 2008 10:14:58 -0700
Message-ID: <000001c894e5$14a9c0b0$2001a8c0@DCOGLEYNEW>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0001_01C894AA.684AE8B0"
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

------=_NextPart_000_0001_01C894AA.684AE8B0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

 

We are using the new AMCC ppc440epx 667MHz chip and I am trying to get
u-boot to recognize the clock rate of the new chip (we were using the
533MHz).  I notice in the cmd_sequoia.c module that there is an option to
setup some sort of strapping in the configuration FPGA that was present on
the evaluation card.  We do not have this configuration FPGA present in our
production board.  Is there some sort of build flag I can specify to
"hardwire" this bootstrap information?  Or at least some I can tell u-boot
to startup with the 667MHz clock rate?  I believe we are using option 7 in
the configuration array for the "bootstrap" command.

 

Thanks,

Dave Cogley

Software Engineer

Ultra Stereo Labs, Inc.

(805) 549-0161

mailto:dcogley@uslinc.com

 


------=_NextPart_000_0001_01C894AA.684AE8B0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
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
font-family:Arial'>Hello,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>We are using the new AMCC ppc440epx 667MHz chip and I =
am
trying to get u-boot to recognize the clock rate of the new chip (we =
were using
the 533MHz).&nbsp; I notice in the cmd_sequoia.c module that there is an =
option to
setup some sort of strapping in the configuration FPGA that was present =
on the
evaluation card.&nbsp; We do not have this configuration FPGA present in =
our
production board.&nbsp; Is there some sort of build flag I can specify =
to &#8220;hardwire&#8221;
this bootstrap information?&nbsp; Or at least some I can tell u-boot to =
startup with
the 667MHz clock rate?&nbsp; I believe we are using option 7 in the =
configuration
array for the &#8220;bootstrap&#8221; =
command.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Dave Cogley<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Software Engineer<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Ultra Stereo Labs, Inc.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>(805) 549-0161<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><a =
href=3D"mailto:dcogley@uslinc.com">mailto:dcogley@uslinc.com</a></span></=
font><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0001_01C894AA.684AE8B0--
