Return-Path: <mike_timmons@trimble.com>
Received: from snvl-smtp1.trimble.com (snvl-smtp1.trimble.com [155.63.64.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "snvl-smtp1.trimble.com", Issuer "Trimble CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id B69D0DE53B
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 Apr 2008 02:22:17 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8A6EF.937D08A3"
Subject: mpc5200 arch=powerpc kernel=2.6.24: how do I request external IRQ0-3?
Date: Fri, 25 Apr 2008 09:14:51 -0700
Message-ID: <161B3BAD77161449A144FF054231C3D60206D6DC@uss-am-xch-01.am.trimblecorp.net>
From: "Mike Timmons" <mike_timmons@trimble.com>
To: <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C8A6EF.937D08A3
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I am confused on a very simple subject: requesting an external IRQ from
a custom driver I'm writing  for a lite5200b-based board running kernel
2.6.24, arch=3Dpowerpc.=20

=20

With the old arch=3Dppc I saw reference to MPC52xx_IRQ3 and such. I =
don't
see reference to specific IRQs under the powerpc arch. I am starting to
better understand the dts scheme for peripheral interrupts, but I am
hung-up on the seemingly simple task of requesting an external IRQ and
registering a callback from my driver:

=20

request_irq(  virtual_irq_number_for_IRQ3_that_I_don't_know_right_now,
&my_callback, flags, name, dev)

=20

For this to work do I need to create a child node in the dts that
specifies interrupts =3D <1 3 2> for IRQ3?  Must the IRQ I'm requesting =
be
associated with the dev argument to request_irq via the dts?

=20

I just think I'm missing something very obvious as regards using
IRQ[0-3] on the mpc52xx. The DTS makes sens to me for peripheral
interrupts getting associated with their respective peripherals, but
when I want any old driver to use IRQ0-3 How do I request it?

=20

Thanks.


------_=_NextPart_001_01C8A6EF.937D08A3
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
font-family:Arial'>I am confused on a very simple subject: requesting an
external IRQ from a custom driver I&#8217;m writing&nbsp; for a =
lite5200b-based
board running kernel 2.6.24, arch=3Dpowerpc. =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>With the old arch=3Dppc I saw reference to =
MPC52xx_IRQ3 and
such. I don&#8217;t see reference to specific IRQs under the powerpc =
arch. I am
starting to better understand the dts scheme for peripheral interrupts, =
but I
am hung-up on the seemingly simple task of requesting an external IRQ =
and
registering a callback from my driver:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>request_irq(&nbsp; =
virtual_irq_number_for_IRQ3_that_I_don&#8217;t_know_right_now,
&amp;my_callback, flags, name, dev)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>For this to work do I need to create a child node in =
the dts
that specifies interrupts =3D &lt;1 3 2&gt; for IRQ3? &nbsp;Must the IRQ =
I&#8217;m
requesting be associated with the dev argument to request_irq via the =
dts?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I just think I&#8217;m missing something very obvious =
as
regards using IRQ[0-3] on the mpc52xx. The DTS makes sens to me for =
peripheral
interrupts getting associated with their respective peripherals, but =
when I
want any old driver to use IRQ0-3 How do I request =
it?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks.<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C8A6EF.937D08A3--
