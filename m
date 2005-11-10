Return-Path: <srideep.devireddy@wipro.com>
Received: from wip-cdctls-mx1.wipro.com (wip-cdctls-mx1.wipro.com
	[203.91.201.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wip-cdctls-mx1.wipro.com",
	Issuer "VeriSign Trust Network" (not verified))
	by ozlabs.org (Postfix) with ESMTP id EE632686EA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Nov 2005 23:37:26 +1100 (EST)
Received: from wip-cdctls-mx1.wipro.com (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with ESMTP id D57903C409A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Nov 2005 18:04:25 +0530 (IST)
Received: from chn-snr-bh2.wipro.com (chn-snr-bh2.wipro.com [10.145.50.92])
	by wip-cdctls-mx1.wipro.com (Postfix) with ESMTP id CA69F3C4056
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Nov 2005 18:04:25 +0530 (IST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5E5F3.7E1CA31D"
Date: Thu, 10 Nov 2005 18:07:31 +0530
Message-ID: <6AD9F6A5F6E096408F0B703773355A07605C40@CHN-SNR-MBX01.wipro.com>
From: <srideep.devireddy@wipro.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: floating point  + kernel (PPC)
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

------_=_NextPart_001_01C5E5F3.7E1CA31D
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Thanks for your help friends ...

=0D

     I am able to bring my kernel up ...... right now I have a problem
after some time at the console .... I get floating point used in kernel
(task=3DC0188480,pc=3D1100)

=0D

10.0.0.2 login: root

Last login: Tnhu Jan  1 00:00sole

Linux 10.0.0.2 2.4.22 #1 Tue Nov 8 12:03:26 UTC 2005 ppc unknown

=0D


MontaVista(R) Linux(R) Professional Edition 3.1

=0D


root@10.0.0.2:~# <mailto:root@10.0.0.2:~> =0D

=0D

root@10.0.0.2:/home# cd ..

root@10.0.0.2:/# ls

bin  boot  dev  etc  home  lib  mnt  opt  proc  root  sbin  tmp  usr
var

root@10.0.0.2:/# floating point used in kernel (task=3Dc0188480, pc=3D1100)

=0D

=0D

What does this mean ...? This makes the console hang .....Can any 1 help
me on in this?=0D

=0D

Best Regards

srideep

=0D




Confidentiality Notice=0D

The information contained in this electronic message and any attachments to=
 this message are intended
for the exclusive use of the addressee(s) and may contain confidential or=
 privileged information. If
you are not the intended recipient, please notify the sender at Wipro or=
 Mailadmin@wipro.com immediately
and destroy all copies of this message and any attachments.
------_=_NextPart_001_01C5E5F3.7E1CA31D
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=
=3D"urn:schemas-microsoft-com:office:office" xmlns:w=
=3D"urn:schemas-microsoft-com:office:word" xmlns=
=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=
=3Dus-ascii">
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
	color:black;}
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

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:black'>Thanks for your help friends=
 &#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:black'>&nbsp;&nbsp;&nbsp;&nbsp; I am able to
bring my kernel up &#8230;&#8230; right now I have a problem after some=
 time at
the console &#8230;. I <b><span style=3D'font-weight:bold'>get=
 </span></b></span></font><b><font
color=3Dblack><span style=3D'color:black;font-weight:bold'>floating point=
 used in
kernel (task=3DC0188480,pc=3D1100)</span></font></b><b><font size=3D2 color=
=3Dblack
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial;color:black;
font-weight:bold'><o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>10.0.0.2 login:=
 root<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>Last login: Tnhu Jan&nbsp; 1=
 00:00sole<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>Linux 10.0.0.2 2.4.22 #1 Tue Nov 8
12:03:26 UTC 2005 ppc unknown<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=
=3D'font-size:12.0pt;color:black'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;
&nbsp;&nbsp;&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>MontaVista(R) Linux(R) Professional
Edition 3.1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=
=3D'font-size:12.0pt;color:black'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'><a href=3D"mailto:root@10.0.0.2:~"
title=
=3D"mailto:root@10.0.0.2:~&#10;mailto:root@10.0.0.2:~#">root@10.0.0.2:~#</a=
>
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>root@10.0.0.2:/home# cd=
 ..<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>root@10.0.0.2:/#=
 ls<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>bin&nbsp; boot&nbsp; dev&nbsp;=
 etc&nbsp;
home&nbsp; lib&nbsp; mnt&nbsp; opt&nbsp; proc&nbsp; root&nbsp; sbin&nbsp;
tmp&nbsp; usr&nbsp; var<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>root@10.0.0.2:/# floating point=
 used in
kernel (task=3Dc0188480, pc=3D1100)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=
=3D'font-size:12.0pt;color:#993300'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>What does this mean &#8230;? This=
 makes
the console hang &#8230;..Can any 1 help me on in this?=
 <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>Best=
 Regards<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>srideep<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

<table><tr><td bgcolor=3D#ffffff><font color=3D#000000><br>
Confidentiality Notice <br>
<br>
The information contained in this electronic message and any attachments to=
 this message are intended<br>
for the exclusive use of the addressee(s) and may contain confidential or=
 privileged information. If<br>
you are not the intended recipient, please notify the sender at Wipro or=
 Mailadmin@wipro.com immediately<br>
and destroy all copies of this message and any attachments.<br>
</font></td></tr></table>
------_=_NextPart_001_01C5E5F3.7E1CA31D--
