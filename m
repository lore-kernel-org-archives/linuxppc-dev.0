Return-Path: <SHorton@kodiaknetworks.com>
Received: from cowboy.inovate.inovate.com (planomail.kodiaknetworks.com
	[76.203.108.6]) by ozlabs.org (Postfix) with ESMTP id 8E274DDE1D
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 Jul 2008 12:05:02 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8E556.0565B3F4"
Subject: MC146818 support and migration from todc to rtc, guidance please
Date: Sun, 13 Jul 2008 21:04:59 -0500
Message-ID: <295C5089A56CE143B316E5F67CA99CB001C9E65F@cowboy.inovate.inovate.com>
From: "Stephen Horton" <SHorton@kodiaknetworks.com>
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

------_=_NextPart_001_01C8E556.0565B3F4
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello folks,

=20

In a current work project, I have inherited a compactPCI board that has
an mpc7447/7448 powerpc processor as well as a Marvell system
controller, model mv64462 (stripped down mv64460). The board has a
somewhat working Gentoo Linux port running on it from long ago and a
company far far away (kernel version 2.6.9 built using arch/ppc). To
prepare for an upcoming deployment, I would like to bring the OS
up-to-date on this board with a newer kernel (targeting 2.6.24).

=20

The 2.6.9 kernel that was previously developed for the board uses the
todc.h library to enable real time clock functionality on the board's
mc146818 device. The todc library appears to have been removed during
the arch/ppc to arch/powerpc migration and replaced with a more generic
RTC mechanism.(??) I can also see that there is an
include/asm-powerpc/mc146818rtc.h file for this device included with the
2.6.24 kernel.

=20

Can anyone give me some tips on what was intended with the removal of
the todc library? What direction should I take to port my platform file
code from todc to the new mechanism?  Is this work already done for me
in the kernel source? What work am I expected to do to add support for
this device in my kernel code? I'm specifically interested in what needs
to be included in my .dts file to enable this device.

=20

Thanks for any guidance and advice, regards,

Stephen


------_=_NextPart_001_01C8E556.0565B3F4
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

<p class=3DMsoNormal><font size=3D2 face=3D"Times New Roman"><span =
style=3D'font-size:
10.0pt'>Hello folks,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Times New Roman"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2
face=3D"Times New Roman"><span style=3D'font-size:10.0pt'>In a current =
work
project, I have inherited a compactPCI board that has an mpc7447/7448 =
powerpc
processor as well as a Marvell system controller, model mv64462 =
(stripped down
mv64460). The board has a somewhat working Gentoo Linux port running on =
it from
long ago and a company far far away (kernel version 2.6.9 built using
arch/ppc). To prepare for an upcoming deployment, I would like to bring =
the OS up-to-date
on this board with a newer kernel (targeting =
2.6.24).<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2
face=3D"Times New Roman"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2
face=3D"Times New Roman"><span style=3D'font-size:10.0pt'>The 2.6.9 =
kernel that was
previously developed for the board uses the todc.h library to enable =
real time
clock functionality on the board&#8217;s mc146818 device. The todc =
library
appears to have been removed during the arch/ppc to arch/powerpc =
migration and
replaced with a more generic RTC mechanism.(??) I can also see that =
there is an
include/asm-powerpc/mc146818rtc.h file for this device included with the =
2.6.24
kernel.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2
face=3D"Times New Roman"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2
face=3D"Times New Roman"><span style=3D'font-size:10.0pt'>Can anyone =
give me some
tips on what was intended with the removal of the todc library? What =
direction
should I take to port my platform file code from todc to the new
mechanism?&nbsp; Is this work already done for me in the kernel source? =
What
work am I expected to do to add support for this device in my kernel =
code? I&#8217;m
specifically interested in what needs to be included in my .dts file to =
enable
this device.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2
face=3D"Times New Roman"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Times New Roman"><span =
style=3D'font-size:
10.0pt'>Thanks for any guidance and advice, =
regards,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Times New Roman"><span =
style=3D'font-size:
10.0pt'>Stephen<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C8E556.0565B3F4--
