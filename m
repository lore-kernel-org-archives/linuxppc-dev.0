Return-Path: <Joaquin.Luna@jdsu.com>
Received: from exprod7og114.obsmtp.com (exprod7ob114.obsmtp.com [64.18.2.214])
	by ozlabs.org (Postfix) with SMTP id F128ADDED5
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Dec 2008 02:58:27 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9594D.BF01D7D7"
Subject: On going usb trouble
Date: Mon, 8 Dec 2008 07:57:59 -0800
Message-ID: <DF6C7BC3780EE44B83430A9F756D43B608919C8D@SJEXCH03.ds.jdsu.net>
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

------_=_NextPart_001_01C9594D.BF01D7D7
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I am having some trouble with usb on my custom board based on the
MPC8313ERDB.  I am trying to get a flash drive to mount over usb with
the newest kernel (2.6.27), but I am stuck.  My usb hardware is close to
that of the development board, I am using the internal phy ("utmi_wide"
in the dts file).  I am using an external 24MHz clock.  Since the
development board uses a 48MHz clock, and I am using a 24MHz clock, I
tried to patch the file arch/powerpc/platforms/83xx/ubs.c in the linux
kernel, but the printk's I add do not get printed.  Does that mean my
kernel is not configured properly? What more than USB_EHCI_FSL must I
turn on besides what is needed for flash drives?  I tried turning on
USB_EHCI_HCD_PPC_OF, but I could not even load the device tree with this
option enabled and it did not look like it was aimed at this platform.
Do I need to modify any of the default usb options in the dts file?

=20

Thanks for taking the time to help,

Joaquin Luna


------_=_NextPart_001_01C9594D.BF01D7D7
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
font-family:Arial'>I am having some trouble with usb on my custom board =
based
on the MPC8313ERDB.&nbsp; I am trying to get a flash drive to mount over =
usb
with the newest kernel (2.6.27), but I am stuck.&nbsp; My usb hardware =
is close
to that of the development board, I am using the internal phy =
(&#8220;utmi_wide&#8221;
in the dts file).&nbsp; I am using an external 24MHz clock.&nbsp; Since =
the
development board uses a 48MHz clock, and I am using a 24MHz clock, I =
tried to patch
the file arch/powerpc/platforms/83xx/ubs.c in the linux kernel, but the =
printk&#8217;s
I add do not get printed.&nbsp; Does that mean my kernel is not =
configured
properly? What more than USB_EHCI_FSL must I turn on besides what is =
needed for
flash drives?&nbsp; I tried turning on USB_EHCI_HCD_PPC_OF, but I could =
not
even load the device tree with this option enabled and it did not look =
like it
was aimed at this platform.&nbsp; Do I need to modify any of the default =
usb
options in the dts file?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks for taking the time to =
help,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Joaquin Luna<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C9594D.BF01D7D7--
