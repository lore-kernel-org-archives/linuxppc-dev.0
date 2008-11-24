Return-Path: <Joaquin.Luna@jdsu.com>
Received: from exprod7og107.obsmtp.com (exprod7og107.obsmtp.com [64.18.2.167])
	by ozlabs.org (Postfix) with SMTP id 158EFDDDF8
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 24 Nov 2008 14:31:18 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C94DE4.24EFE3AD"
Subject: USB Host support on mpc 8313
Date: Sun, 23 Nov 2008 19:24:21 -0800
Message-ID: <DF6C7BC3780EE44B83430A9F756D43B6086F5441@SJEXCH03.ds.jdsu.net>
From: "Joaquin Luna" <Joaquin.Luna@jdsu.com>
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

------_=_NextPart_001_01C94DE4.24EFE3AD
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Is there anyone out there who has tried getting usb to work under the
2.6.27 kernel?  I am using the Freescale MPC831x RDB platform and when I
enable "Support for Freescale on-chip EHCI USB controller"
(USB_EHCI_FSL) I get stuck during boot up.  The last two lines of my
boot log are:

=20

fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host Controller

fsl-ehci fsl-ehci.0: new USB bus registered, assigned bus number 1

=20

=20

With the 2.6.20 kernel I had usb working and my boot log looked like:

=20

fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host Controller

fsl-ehci fsl-ehci.0: new USB bus registered, assigned bus number 1

fsl-ehci fsl-ehci.0: irq 38, io base 0xe0023000

fsl-ehci fsl-ehci.0: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004

=20

=20

I did notice that there were a few usb bug fixes that went into 2.6.27.7
so I updated to the latest version, but it did not help.  Any idea how
or where I can begin looking for a solution?

=20

Cheers,

Joaquin Luna


------_=_NextPart_001_01C94DE4.24EFE3AD
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
font-family:Arial'>Is there anyone out there who has tried getting usb =
to work
under the 2.6.27 kernel?&nbsp; I am using the Freescale MPC831x RDB =
platform
and when I enable &#8220;Support for Freescale on-chip EHCI USB =
controller&#8221;
(USB_EHCI_FSL) I get stuck during boot up.&nbsp; The last two lines of =
my boot
log are:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host =
Controller<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>fsl-ehci fsl-ehci.0: new USB bus registered, assigned =
bus
number 1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>With the 2.6.20 kernel I had usb working and my boot =
log
looked like:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host =
Controller<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>fsl-ehci fsl-ehci.0: new USB bus registered, assigned =
bus
number 1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>fsl-ehci fsl-ehci.0: irq 38, io base =
0xe0023000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>fsl-ehci fsl-ehci.0: USB 2.0 started, EHCI 1.00, =
driver 10
Dec 2004<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I did notice that there were a few usb bug fixes that =
went
into 2.6.27.7 so I updated to the latest version, but it did not =
help.&nbsp;
Any idea how or where I can begin looking for a =
solution?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Cheers,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Joaquin Luna<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C94DE4.24EFE3AD--
