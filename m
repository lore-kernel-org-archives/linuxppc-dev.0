Return-Path: <yoni.l@slyde-tech.com>
Received: from smtpin.livedns.co.il (smtpin.livedns.co.il [62.219.78.209])
	by ozlabs.org (Postfix) with ESMTP id 0711CDDDD8
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Aug 2007 21:45:18 +1000 (EST)
From: "Yoni Levin" <yoni.l@slyde-tech.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: GPIO interrupts on mpc8313e
Date: Wed, 1 Aug 2007 14:45:05 +0300
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0000_01C7D44A.8CA2B3D0"
Message-ID: <2C4FDB8D627248AE9B24BC21747E0F5D.MAI@mail.livedns.co.il>
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

------=_NextPart_000_0000_01C7D44A.8CA2B3D0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

 

I want to receive interrupt from 1 GPIO port (for example 14)

I changed the GPIMR to 0xffffffff (so I need to get interrupts from all GPIO
ports)

And then request the irq by :

irq_create_mapping(NULL,74);

request_irq(74,handler,IRQF_DISABLED,"GPIO",NULL);

the return value is 0 (OK)

but I cant receive any interrupt.

do I need to do something else?

 

 


------=_NextPart_000_0000_01C7D44A.8CA2B3D0
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
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:right;
	direction:rtl;
	unicode-bidi:embed;
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
	{size:595.3pt 841.9pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1 dir=3DRTL>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>I
want to receive interrupt from 1 GPIO port (for example =
14)<o:p></o:p></span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>I
changed the GPIMR to 0xffffffff (so I need to get interrupts from all =
GPIO
ports)<o:p></o:p></span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>And
then request the irq by :<o:p></o:p></span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>irq_create_mapping(NULL,74);=
<o:p></o:p></span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>request_irq(74,handler,IRQF_=
DISABLED,&quot;GPIO&quot;,NULL);<o:p></o:p></span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>the
return value is 0 (OK)<o:p></o:p></span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>but
I cant receive any interrupt&#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>do
I need to do something else?<o:p></o:p></span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

</div>

</body>

</html>

------=_NextPart_000_0000_01C7D44A.8CA2B3D0--
