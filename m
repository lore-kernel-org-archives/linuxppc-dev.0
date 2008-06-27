Return-Path: <ednh@cypress.com>
Received: from ns1.cypress.com (ns1.cypress.com [157.95.67.4])
	by ozlabs.org (Postfix) with ESMTP id D7EADDDE1B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Jun 2008 12:54:11 +1000 (EST)
Received: from corpmail.cypress.com (corpmail [157.95.1.2])
	by ns1.cypress.com (8.12.10/8.12.10) with ESMTP id m5R2jhkj011930
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jun 2008 19:45:43 -0700 (PDT)
Received: from mailhost.isd.cypress.com (mailhost.isd.cypress.com
	[172.19.2.11])
	by corpmail.cypress.com (8.12.10/8.12.10) with ESMTP id m5R2jXUQ020987
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jun 2008 19:45:33 -0700 (PDT)
Received: from ednh (ednh.isd.cypress.com [172.19.2.96])
	by mailhost.isd.cypress.com (8.12.2/8.12.2) with ESMTP id
	m5R2jOu2020922 for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jun 2008 20:45:24 -0600 (MDT)
From: "Ed Henderson" <ednh@cypress.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: National Semi DP83865 Phy on custom hardware with PPC 8540 CPU
Date: Thu, 26 Jun 2008 20:45:24 -0600
Message-ID: <018a01c8d7ff$d93f3650$8bbda2f0$@com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_018B_01C8D7CD.8EA4C650"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.

------=_NextPart_000_018B_01C8D7CD.8EA4C650
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Greetings.

 

I am a hardware engineer and I designed a board based on a Power PC MPC8540
CPU. The hardware was patterned after another board with a Marvel driver. I
had some difficulty locating the Marvel Chips, so I used a National
Semiconductor DP83865 Phy instead, available at Digikey. We looked at this
and felt it would not be too difficult to adapt the current Kernel code to
this phy. In practice, now that we have hardware built, it is proving to be
a bit more difficult to bring up. It is very interesting that u-boot
contains code for this Phy, and we are able to get to the u-boot command
line, setup and Ethernet address, ping and even do a tftpboot kernel
transfer. Unfortunately, in the Kernel, we do not have the same success.
This seems to indicate that the hardware is working, at least to some
degree.

 

We did some modifications on the Marvel driver in order to 'attempt' to
adapt it to the National Phy. To be honest, we are not that familiar with
this aspect of Kernel development, so we could really use some
pointers/tips/assistance.  There are some file geared toward the DP83865,
but they are "PCI" drivers. Our Phy is directly connected to the PPC. I do
not  know if it make sense to start with the natsemi.c file (which is geared
toward PCI), or to make our changes to the Marvel phy.

 

 I would appreciate any help in resolving this issue.

 

Regards,

 

Ed Henderson

 


------=_NextPart_000_018B_01C8D7CD.8EA4C650
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
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
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

<p class=3DMsoNormal>Greetings.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I am a hardware engineer and I designed a board =
based on a
Power PC MPC8540 CPU. The hardware was patterned after another board =
with a
Marvel driver. I had some difficulty locating the Marvel Chips, so I =
used a
National Semiconductor DP83865 Phy instead, available at Digikey. We =
looked at
this and felt it would not be too difficult to adapt the current Kernel =
code to
this phy. In practice, now that we have hardware built, it is proving to =
be a
bit more difficult to bring up. It is very interesting that u-boot =
contains
code for this Phy, and we are able to get to the u-boot command line, =
setup and
Ethernet address, ping and even do a tftpboot kernel transfer. =
Unfortunately,
in the Kernel, we do not have the same success. This seems to indicate =
that the
hardware is working, at least to some degree.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>We did some modifications on the Marvel driver in =
order to &#8216;attempt&#8217;
to adapt it to the National Phy. To be honest, we are not that familiar =
with this
aspect of Kernel development, so we could really use some
pointers/tips/assistance.&nbsp; There are some file geared toward the =
DP83865,
but they are &#8220;PCI&#8221; drivers. Our Phy is directly connected to =
the
PPC. I do not&nbsp; know if it make sense to start with the natsemi.c =
file
(which is geared toward PCI), or to make our changes to the Marvel =
phy.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>&nbsp;I would appreciate any help in resolving this =
issue.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Regards,<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Ed Henderson<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

------=_NextPart_000_018B_01C8D7CD.8EA4C650--
