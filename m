Return-Path: <yonil@slydetech.com>
Received: from slydetech.com (saigdsl.bb.netvision.net.il [212.143.159.55])
	by ozlabs.org (Postfix) with ESMTP id B3479DDE1C
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 13 Aug 2007 21:57:49 +1000 (EST)
Subject: Power Managment (mpc83xx)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7DD9F.5B9170DC"
Date: Mon, 13 Aug 2007 14:44:50 +0300
Message-ID: <6954FEB9E3130645ABAFEE8D5E2C7C141FE8B6@slydesvr.Slyde.local>
From: "Yoni Levin" <yonil@slydetech.com>
To: <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C7DD9F.5B9170DC
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I have mpc83xx, and I work with Linux 2.6

I am trying to use power management states.=20

I succeed to get into D1 state (echo standby > /sys/power/state),

And to waked up by GPIO.

But when I try tried echo mem > /sys/power/state it waked up by reset
(that stuck in the middle)

Or echo disk > /sys/power/state didn't went to sleep at all.

There is a way to get into economic power state (less power then D1
(standby)) and to wake up fast?

=20


------_=_NextPart_001_01C7DD9F.5B9170DC
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
	{mso-style-type:personal;
	font-family:Arial;
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
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
embed'><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial;color:navy'>I</span></font><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'> have mpc83xx,<font =
color=3Dnavy><span
style=3D'color:navy'> and I work with Linux =
2.6<o:p></o:p></span></font></span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial;color:navy'>I am trying to use power management =
states. <o:p></o:p></span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial;color:navy'>I succeed to get into D1 state (echo =
standby &gt;
/sys/power/state),<o:p></o:p></span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial;color:navy'>And to waked up by =
GPIO.<o:p></o:p></span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial;color:navy'>But when I try tried echo mem &gt;
/sys/power/state it waked up by reset (that </span></font><font size=3D1
color=3D"#000099" face=3DArial><span =
style=3D'font-size:9.0pt;font-family:Arial;
color:#000099'>stuck </span></span></font><font size=3D2 color=3Dnavy =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>in the =
middle)<o:p></o:p></span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial;color:navy'>Or echo disk &gt; /sys/power/state =
didn&#8217;t went
to sleep at all.<o:p></o:p></span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial;color:navy'>There is a way to get into economic power =
state
(less power then D1 (standby)) and to wake up =
fast?<o:p></o:p></span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C7DD9F.5B9170DC--
