Return-Path: <lipovsky@cs.bu.edu>
Received: from cs3.bu.edu (cs3.bu.edu [128.197.12.8])
	by ozlabs.org (Postfix) with ESMTP id CAD71DDF3E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Mar 2007 05:56:46 +1100 (EST)
Received: from BosLipovskyIPC (host5.gsadvisors.net [65.206.107.5] (may be
	forged)) (authenticated bits=0)
	by cs3.bu.edu (8.13.6/8.13.6) with ESMTP id l2KIlXf6015249
	for <linuxppc-embedded@ozlabs.org>; Tue, 20 Mar 2007 14:48:04 -0400
From: "Ilya Lipovsky" <lipovsky@cs.bu.edu>
To: <linuxppc-embedded@ozlabs.org>
Subject: Question about oprofile
Date: Tue, 20 Mar 2007 14:47:32 -0400
Message-ID: <001e01c76b20$4a97b410$3a0d10ac@Radstone.Local>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_001F_01C76AFE.C3888510"
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

------=_NextPart_000_001F_01C76AFE.C3888510
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

 

I am trying to understand how oprofile works, and so far I have a question:

When rfi'ing back into user context the PMM is cleared. However, if PMM is
cleared and then a context switch happens (say, to another CPU-local thread)
the counters keep getting incremented. Is that right?

 

If this is the case, then the PMC statistics account not just for the
current user thread, but also for other ones as well and thus are not
"pure."

 

Thanks in advance for your help.

-Ilya


------=_NextPart_000_001F_01C76AFE.C3888510
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
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
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hi,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am trying to understand how oprofile works, and so =
far I have
a question:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>When rfi&#8217;ing back into user context the PMM is
cleared. However, if PMM is cleared and then a context switch happens =
(say, to
another CPU-local thread) the counters keep getting incremented. Is that =
right?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>If this is the case, then the PMC statistics account =
not
just for the current user thread, but also for other ones as well and =
thus are
not &#8220;pure.&#8221;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks in advance for your =
help.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>-Ilya<o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_001F_01C76AFE.C3888510--
