Return-Path: <yoni.l@slyde-tech.com>
Received: from smtpin.livedns.co.il (smtpin.livedns.co.il [62.219.78.209])
	by ozlabs.org (Postfix) with ESMTP id AD469DDDE9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Jul 2007 17:59:27 +1000 (EST)
From: "Yoni Levin" <yoni.l@slyde-tech.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: interrupts in mpc8313
Date: Tue, 31 Jul 2007 10:53:17 +0300
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0015_01C7D361.01C75E80"
Message-ID: <1A95C6D899744E16A71AFFB2CF1C11B1.MAI@mail.livedns.co.il>
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

------=_NextPart_000_0015_01C7D361.01C75E80
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi, I am working on the MPC8313E board , 

 

I work with the DMA that works fine, but I want to get the interrupt when it
finish.

 

I am working under linux 2.6.20

 

I tried to use the function request_irq :

 

Ret=Request_irq(71,interrupt_handler,SA_INTERUPT,"dma_irq",NULL);

 

But I receive an error -ENOSYS

 

Do I need to do something before call the Request_irq?

 

You know what is wrong?

 

Thank you for your help, 

 

Yehonatan.

 


------=_NextPart_000_0015_01C7D361.01C75E80
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
style=3D'font-size:10.0pt;font-family:Arial'>Hi,
I am working on the MPC8313E board , <o:p></o:p></span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>I
work with the DMA that works fine, but I want to get the interrupt when =
it
finish.<o:p></o:p></span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>I
am working under linux 2.6.20<o:p></o:p></span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>I
tried to use the function request_irq :<o:p></o:p></span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><i><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:
Arial;font-style:italic'>Ret=3DRequest_irq(71,interrupt_handler,SA_INTERU=
PT,&quot;dma_irq&quot;,NULL);<o:p></o:p></span></font></i></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><i><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:
Arial;font-style:italic'><o:p>&nbsp;</o:p></span></font></i></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>But
I receive an error -ENOSYS<o:p></o:p></span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Do
I need to do something before call the <i><span =
style=3D'font-style:italic'>Request_irq</span></i>?<o:p></o:p></span></fo=
nt></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>You
know what is wrong?<o:p></o:p></span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Thank
you for your help, <o:p></o:p></span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Yehonatan.<o:p></o:p></span>=
</font></p>

<p class=3DMsoNormal dir=3DRTL><font size=3D2 face=3DArial><span =
dir=3DLTR
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

</div>

</body>

</html>

------=_NextPart_000_0015_01C7D361.01C75E80--
