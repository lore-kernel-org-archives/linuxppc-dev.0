Return-Path: <Chetan.S.Anantharaman@motorola.com>
Received: from motgate4.mot.com (motgate4.mot.com [144.189.100.102])
	by ozlabs.org (Postfix) with ESMTP id A9A8767B87
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Jul 2006 01:00:58 +1000 (EST)
Received: from az33exr03.mot.com (az33exr03.mot.com [10.64.251.233])
	by motgate4.mot.com (8.12.11/Motgate4) with ESMTP id k63F0l7d006431
	for <linuxppc-embedded@ozlabs.org>; Mon, 3 Jul 2006 08:00:47 -0700 (MST)
Received: from de01exm68.ds.mot.com (de01exm68.am.mot.com [10.176.8.24])
	by az33exr03.mot.com (8.13.1/8.13.0) with ESMTP id k63F0kMW003282
	for <linuxppc-embedded@ozlabs.org>; Mon, 3 Jul 2006 10:00:47 -0500 (CDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C69EB1.76B04EBD"
Subject: RE: JFFS2 FS is read-only (not what I want)
Date: Mon, 3 Jul 2006 11:00:46 -0400
Message-ID: <EDF27F298D4B03498AE0C249A941DFF803D749@de01exm68.ds.mot.com>
In-Reply-To: <1151937365.12449.17.camel@saruman.qstreams.net>
From: "Anantharaman Chetan-W16155" <Chetan.S.Anantharaman@motorola.com>
To: <bwarren@qstreams.com>
Cc: linuxppc-embedded@ozlabs.org
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

------_=_NextPart_001_01C69EB1.76B04EBD
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Also as a side note, I think even if you unlock your banks/sectors in
U-Boot, when the Linux kernel is launched I am not sure if the
sectors/banks remain unlocked. You can also use the MTD Utils to unlock
the device, erase the device, etc. in the shell.

=20

Chetan

=20

________________________________

From: Ben Warren [mailto:bwarren@qstreams.com]=20
Sent: Monday, July 03, 2006 9:36 AM
To: Anantharaman Chetan-W16155
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: JFFS2 FS is read-only (not what I want)

=20

Chetan,

On Mon, 2006-07-03 at 10:18 -0400, Anantharaman Chetan-W16155 wrote:=20

=20
Did you check to see if your flash banks are unlocked?
=20

According to U-Boot, only the first four sectors are locked.  My JFFS2
partition is in sectors 37-52 (1-based).  I'll definitely look more
deeply into this, though.

thanks,
Ben=20


------_=_NextPart_001_01C69EB1.76B04EBD
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><o:SmartTagType
 namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags" =
name=3D"PersonName"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
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
pre
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
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

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Also as a side note, I think even =
if you
unlock your banks/sectors in U-Boot, when the Linux kernel is launched I =
am not
sure if the sectors/banks remain unlocked. You can also use the MTD =
Utils to
unlock the device, erase the device, etc. in the =
shell.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Chetan<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<div>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font =
size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>

<hr size=3D2 width=3D"100%" align=3Dcenter tabindex=3D-1>

</span></font></div>

<p class=3DMsoNormal><b><font size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;
font-family:Tahoma;font-weight:bold'>From:</span></font></b><font =
size=3D2
face=3DTahoma><span style=3D'font-size:10.0pt;font-family:Tahoma'> Ben =
Warren
[mailto:bwarren@qstreams.com] <br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Monday, July 03, =
2006 9:36
AM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> Anantharaman =
Chetan-W16155<br>
<b><span style=3D'font-weight:bold'>Cc:</span></b> <st1:PersonName =
w:st=3D"on">linuxppc-embedded@ozlabs.org</st1:PersonName><br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> RE: JFFS2 FS is =
read-only
(not what I want)</span></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Chetan,<br>
<br>
On Mon, 2006-07-03 at 10:18 -0400, Anantharaman Chetan-W16155 wrote: =
<o:p></o:p></span></font></p>

<pre><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>Did you check to see if your =
flash banks are unlocked?</span></font><o:p></o:p></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>According to U-Boot, only the first four sectors are =
locked.&nbsp; My
JFFS2 partition is in sectors 37-52 (1-based).&nbsp; I'll definitely =
look more
deeply into this, though.<br>
<br>
thanks,<br>
Ben <o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C69EB1.76B04EBD--
