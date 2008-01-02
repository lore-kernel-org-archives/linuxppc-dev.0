Return-Path: <sekhar.pedamallu@patni.com>
Received: from pcsbom.patni.com (pcsbom.patni.com [203.189.177.133])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E29ABDDE00
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Jan 2008 19:04:04 +1100 (EST)
Received: from pcsakruti.patni.com (pcsakruti.patni.com [192.168.8.190])
	by pcsbom.patni.com (8.13.1/8.13.1) with ESMTP id m027XMGD030915
	for <linuxppc-embedded@ozlabs.org>; Wed, 2 Jan 2008 13:03:45 +0530
Received: from aktrakshak.patni.com (aktrakshak.patni.com [192.168.8.183])
	by pcsakruti.patni.com (8.13.1/8.13.4) with SMTP id m027WhWi011662
	for <linuxppc-embedded@ozlabs.org>; Wed, 2 Jan 2008 13:02:47 +0530
Received: from lords.patni.com ([192.168.8.1])
	by aktrakshak.patni.com (SMSSMTP 4.1.11.41) with SMTP id
	M2008010212574223511
	for <linuxppc-embedded@ozlabs.org>; Wed, 02 Jan 2008 12:57:42 +0530
Received: from pcp40256 ([192.168.190.96]) (authenticated bits=0)
	by lords.patni.com (8.13.4/8.13.4) with ESMTP id m027XIPI022549
	for <linuxppc-embedded@ozlabs.org>; Wed, 2 Jan 2008 13:03:21 +0530
Message-Id: <200801020733.m027XIPI022549@lords.patni.com>
From: "Sekhar Pedamallu" <sekhar.pedamallu@patni.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: MTD - partioning 
Date: Wed, 2 Jan 2008 13:03:20 +0530
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_029A_01C84D3F.D988F8D0"
Reply-To: sekhar.pedamallu@patni.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format...

------=_NextPart_000_029A_01C84D3F.D988F8D0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all

      i have 2 flash devices total of 16MB each of size 8MB and i need to
make partitions on first chip requirements as such:

 256 KB - u-boot

 2 MB - kernel 

 And remaining 13.5 MB for root file system and user space application
running on it. 

 

 The partition information is defined for each chip separately . I have seen
the some of the drivers in drivres/mtd/maps directory. Now how do I  make
use of 6MB of first chips and 8MB from second chip to been seen as a single
partition??

 

If someone who have faced this problem or worked on this plea let me know

 

Thanks & Regards ,

Sekhar Pedamallu

 


http://www.patni.com
World-Wide Partnerships. World-Class Solutions.
_____________________________________________________________________

This e-mail message may contain proprietary, confidential or legally
privileged information for the sole use of the person or entity to
whom this message was originally addressed. Any review, e-transmission
dissemination or other use of or taking of any action in reliance upon
this information by persons or entities other than the intended
recipient is prohibited. If you have received this e-mail in error
kindly delete  this e-mail from your records. If it appears that this
mail has been forwarded to you without proper authority, please notify
us immediately at netadmin@patni.com and delete this mail. 
_____________________________________________________________________

------=_NextPart_000_029A_01C84D3F.D988F8D0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Gautami;
	panose-1:2 0 5 0 0 0 0 0 0 0;}
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

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Hi all<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i have 2 flash devices to=
tal of 16MB each of size 8MB
and i need to make partitions on first chip requirements as such:<o:p></o:p=
></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;256 KB &#8211; u-boot<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;2 MB &#8211; kernel <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;And remaining 13.5 MB for root file system and use=
r space application
running on it. <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;The partition information is defined for each chip
separately . I have seen the some of the drivers in drivres/mtd/maps direct=
ory.
Now how do I &nbsp;make use of 6MB of first chips and 8MB from second chip =
to been
seen as a single partition??<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>If someone who have faced this problem or worked on this
plea let me know<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><em><b><i><font size=3D3 color=3Dblue face=3DGautami><=
span
style=3D'font-size:12.0pt;font-family:Gautami;color:blue;font-weight:bold'>=
Thanks
&amp; Regards ,</span></font></i></b></em><o:p></o:p></p>

<p class=3DMsoNormal><em><b><i><font size=3D5 color=3Dmaroon face=3D"Times =
New Roman"><span
style=3D'font-size:18.0pt;color:maroon;font-weight:bold'>Sekhar Pedamallu</=
span></font></i></b></em><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

<br><a href=3Dhttp://www.patni.com>http://www.patni.com</a><br>
World-Wide Partnerships. World-Class Solutions.
<br>
_____________________________________________________________________
<br> <br>
This e-mail message may contain proprietary, confidential or legally
privileged information for the sole use of the person or entity to
whom this message was originally addressed. Any review, e-transmission
dissemination or other use of or taking of any action in reliance upon
this information by persons or entities other than the intended
recipient is prohibited. If you have received this e-mail in error
kindly delete  this e-mail from your records. If it appears that this
mail has been forwarded to you without proper authority, please notify
us immediately at netadmin@patni.com and delete this mail. <br>
_____________________________________________________________________
</body>

</html>

------=_NextPart_000_029A_01C84D3F.D988F8D0--
