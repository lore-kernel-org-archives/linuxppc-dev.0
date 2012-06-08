Return-Path: <mohanaraov@vrindatech.com>
Received: from server.indiadomain.com (server.indiadomain.com [69.50.220.205])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 01887B6FFF
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2012 20:51:37 +1000 (EST)
Received: from [122.169.140.53] (port=13347 helo=mohan67ab2b799)
 by server.indiadomain.com with esmtpa (Exim 4.77)
 (envelope-from <mohanaraov@vrindatech.com>) id 1ScwaY-0006Gc-1c
 for linuxppc-dev@lists.ozlabs.org; Fri, 08 Jun 2012 16:08:43 +0530
From: "Mohan" <mohanaraov@vrindatech.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: need support for PCI driver
Date: Fri, 8 Jun 2012 16:08:38 +0530
Message-ID: <000501cd4562$df6915d0$9e3b4170$@com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_NextPart_000_0006_01CD4590.F92151D0"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.

------=_NextPart_000_0006_01CD4590.F92151D0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Sir,

 

Using PMC -PCI Adapter card ,i have interfaced my PowerPC MPC8280 (which is
configured as PCI bridge) as agent to personal computer. when this setup
having MPC8280 card with  powered ON and connected to PC .PC is getting
hanged while system is booting up. I am finding problem when this card is
powered ON state before system is boot up. But if this MPC8280(PCI Bridge)
card with powered ON  is connected to PMC carrier adapter after PC  has
booted up, it is getting identified by system and able to watch my device
details (configuration space) using "PCI Explorer  Software". But using this
software, it is showing this single PCI device  as 31 different devices. Why
this is showing as 31 PCI devices? Also why PC is not getting Booted, after
this PCI Bridge in power ON state is connected to PMC -PCI Adapter card that
already in PCI slot of my PC? I am unable to solve this problem.

I am finding the same issue even I am using this set up on Linux based host
.

I approached Freescale support for this issue by sending my PCI card
schematics. They analyzed and came up with small changes, but still we could
not able to solve this problem. So we wanted to start tracing the problem
from software side. That's why I wanted  to install  my PCI card into Linux
based   host. To do this whether I need to write /include any driver code
into my Linux host .If I need to  write driver code how to start & where
exactly needs changes/inclusions of code stuff in linux code.

Already I am studying kernel documentation and drivers code under source
code. Referring  Linux device Driver 3rd edition O'reilly s book.

I am new to linux.

 Please  help me in getting through this  problem.

 

Thanks & regards

V mohan rao


------=_NextPart_000_0006_01CD4590.F92151D0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
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

<p class=3DMsoNormal>Sir,<o:p></o:p></p>

<p class=3DMsoNormal style=3D'text-indent:.5in'><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal style=3D'text-indent:.5in'>Using PMC -PCI Adapter =
card ,i have
interfaced my <b>PowerPC MPC8280</b> (which is configured as <b>PCI =
bridge</b>)
as agent to personal computer. when this setup having MPC8280 card =
with&nbsp; <b>powered
ON</b> and connected to <b>PC</b> .<b>PC</b> is getting hanged while =
system is booting
up. I am finding problem when this card is powered ON state before =
system is
boot up. But if this MPC8280(PCI Bridge) card with powered ON&nbsp; is
connected to PMC carrier adapter after PC&nbsp; has booted up, it is =
getting
identified by system and able to watch my device details (configuration =
space)
using &quot;<b>PCI Explorer&nbsp; Software&quot;</b>. But using this =
software,
it is showing this single PCI device&nbsp; as <b>31</b> different =
devices. <b>Why
this is showing as 31 PCI devices? Also why PC is not getting Booted, =
after
this PCI Bridge in power ON state is connected to PMC &#8211;PCI Adapter =
card
that already in PCI slot of my PC?</b> I am unable to solve this =
problem.<o:p></o:p></p>

<p class=3DMsoNormal style=3D'text-indent:.5in'>I am finding the same =
issue even I
am using this set up on Linux based host .<o:p></o:p></p>

<p class=3DMsoNormal style=3D'text-indent:.5in'>I approached Freescale =
support for
this issue by sending my <b>PCI card schematics</b>. They analyzed and =
came up
with small changes, but still we could not able to solve this problem. =
So we
wanted to start tracing the problem from software side. That&#8217;s why =
I
wanted &nbsp;to install&nbsp; my PCI card into Linux based =
&nbsp;&nbsp;host. To
do this whether I need to write /include any driver code into my Linux =
host .If
I need to&nbsp; write driver code how to start &amp; where exactly needs
changes/inclusions of code stuff in linux code.<o:p></o:p></p>

<p class=3DMsoNormal style=3D'text-indent:.5in'>Already I am studying =
kernel
documentation and drivers code under source code. Referring &nbsp;Linux =
device
Driver 3<sup>rd</sup> edition O&#8217;reilly s book.<o:p></o:p></p>

<p class=3DMsoNormal style=3D'text-indent:.5in'>I am new to =
linux.<o:p></o:p></p>

<p class=3DMsoNormal style=3D'text-indent:.5in'>&nbsp;Please&nbsp; help =
me in getting
through this &nbsp;problem.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Thanks &amp; regards<o:p></o:p></p>

<p class=3DMsoNormal>V mohan rao<o:p></o:p></p>

</div>

</body>

</html>

------=_NextPart_000_0006_01CD4590.F92151D0--
