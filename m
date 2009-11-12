Return-Path: <Logan.Ratner@emerson.com>
Received: from exprod7og118.obsmtp.com (exprod7og118.obsmtp.com [64.18.2.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1B4B2B7B63
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 13 Nov 2009 03:49:11 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA63B7.560A2928"
Subject: problem with POSIX timers
Date: Thu, 12 Nov 2009 10:44:01 -0600
Message-ID: <E67273157D229E429BC0C0C74FE8DCDA0B54B8B7@ushou-exm01.na.emersonprocess.com>
From: <Logan.Ratner@emerson.com>
To: <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA63B7.560A2928
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I'm on a project where I recently switched from BSD style timers
(setitimer/getitimer) to POSIX style timers
(timer_settime/timer_gettime) so I can use the timer_getoverrun
function.  This works fine, except that now on my embedded PPC platform
changing the system time with either settimeofday or clock_settime has
an effect on relative timers, which according to POSIX shouldn't happen.
The same code works fine on the x86 platforms I've tested on; I only see
the problem on my PPC machine.

=20

I've also tried using CLOCK_MONOTONIC instead of CLOCK_REALTIME, but
that does not seem to be supported on my platform either.

=20

I'm using:

=20

An MPC8270 processor

A 2.6.17.6 kernel

librt ver. 2.3.5

libc ver. 2.3.5

g++ 4.0 targeting powerpc-linux

=20

Is this a known problem?  Is there a patch or a later kernel that would
correct this problem?

Also, is this the right place to be asking this question, and if not
could anyone suggest a better forum?

=20

Any help or advice would be greatly appreciated.

Thanks in advance,

=20

Logan Ratner | Software Engineer | Rosemount Analytical

Emerson Process Management | 5650 Brittmoore Rd | Houston | TX | 77041 |
USA

T +1 713 839 9656 | F +1 713 827 3807

Logan.Ratner@Emerson.com

=20


------_=_NextPart_001_01CA63B7.560A2928
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"country-region"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"Street"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"address"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"City"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
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
font-family:Arial'>I&#8217;m on a project where I recently switched from =
BSD
style timers (setitimer/getitimer) to POSIX style timers =
(timer_settime/timer_gettime)
so I can use the timer_getoverrun function.&nbsp; This works fine, =
except that
now on my embedded PPC platform changing the system time with either
settimeofday or clock_settime has an effect on relative timers, which =
according
to POSIX shouldn&#8217;t happen.&nbsp; The same code works fine on the =
x86
platforms I&#8217;ve tested on; I only see the problem on my PPC =
machine.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I&#8217;ve also tried using CLOCK_MONOTONIC instead =
of
CLOCK_REALTIME, but that does not seem to be supported on my platform =
either.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I&#8217;m using:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>An MPC8270 processor<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>A 2.6.17.6 kernel<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>librt ver. 2.3.5<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>libc ver. 2.3.5<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>g++ 4.0 targeting =
powerpc-linux<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Is this a known problem?&nbsp; Is there a patch or a =
later kernel
that would correct this problem?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Also, is this the right place to be asking this =
question,
and if not could anyone suggest a better =
forum?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Any help or advice would be greatly =
appreciated.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks in advance,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><st1:City w:st=3D"on"><st1:place =
w:st=3D"on"><b><font size=3D1
  color=3Dgray face=3DArial><span =
style=3D'font-size:8.0pt;font-family:Arial;
  =
color:gray;font-weight:bold'>Logan</span></font></b></st1:place></st1:Cit=
y><b><font
size=3D1 color=3Dgray face=3DArial><span =
style=3D'font-size:8.0pt;font-family:Arial;
color:gray;font-weight:bold'> Ratner </span></font></b><font size=3D1 =
color=3Dgray
face=3DArial><span =
style=3D'font-size:8.0pt;font-family:Arial;color:gray'>|
Software Engineer | Rosemount Analytical</span></font><o:p></o:p></p>

<p class=3DMsoNormal><b><font size=3D1 color=3Dgray face=3DArial><span
style=3D'font-size:8.0pt;font-family:Arial;color:gray;font-weight:bold'>E=
merson
Process Management </span></font></b><font size=3D1 color=3Dgray =
face=3DArial><span
style=3D'font-size:8.0pt;font-family:Arial;color:gray'>| <st1:Street =
w:st=3D"on"><st1:address
 w:st=3D"on">5650 Brittmoore Rd</st1:address></st1:Street> | <st1:City =
w:st=3D"on">Houston</st1:City>
| TX | 77041 | <st1:country-region w:st=3D"on"><st1:place =
w:st=3D"on">USA</st1:place></st1:country-region><o:p></o:p></span></font>=
</p>

<p class=3DMsoNormal><font size=3D1 color=3Dgray face=3DArial><span =
style=3D'font-size:
8.0pt;font-family:Arial;color:gray'>T +1 713 839 9656 | F +1 713 827 =
3807<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dgray face=3DArial><span =
style=3D'font-size:
8.0pt;font-family:Arial;color:gray'>Logan.Ratner@Emerson.com</span></font=
><font
color=3Dgray><span style=3D'color:gray'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01CA63B7.560A2928--
