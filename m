Return-Path: <srinivas.surabhi@wipro.com>
Received: from wip-ectls-mx1.wipro.com (wip-ectls-mx1.wipro.com
	[203.101.113.37])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wip-ectls-mx1.wipro.com",
	Issuer "VeriSign Trust Network" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6A34667A71
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Feb 2005 00:35:03 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C51363.21155EB0"
Date: Tue, 15 Feb 2005 19:04:52 +0530
Message-ID: <EF9B29C78F41FA488927FCBC7750AF0E011DA5CB@hyd-mdp-msg.wipro.com>
From: <srinivas.surabhi@wipro.com>
To: <wd@denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Mounta Vista Linux prompt on serial console 
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

------_=_NextPart_001_01C51363.21155EB0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


My replies in blue tagged with surabhi

=0D

-----Original Message-----
From: wd@denx.de [mailto:wd@denx.de]=0D
Sent: Tuesday, February 15, 2005 5:24 PM
To: Srinivas Surabhi (WT01 - EMBEDDED & PRODUCT ENGINEERING SOLUTIONS)
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Mounta Vista Linux prompt on serial console=0D

=0D

In message
<EF9B29C78F41FA488927FCBC7750AF0E011DA5C5@hyd-mdp-msg.wipro.com> you
wrote:

>=0D

> Today somehow after removing many options I build the kernel and able
to

> succeed till the VFS: "Mounted root (cramfs filesystem) readonly." But

> then I am seeming "kernel panic". Actually what option has to be given

> for init. We have given init=3D/bin/sh but no luck.

=0D

You have to provide a working root filesystem in the first place.

=0D

[surabhi --- start] could you please guide me how to provide a working
file system on SDRAM before decompressing the Linux Image on SDRAM. Is
it really related to init process failed.=0D

=0D

Is the below doesn't mean that the mounted one is working one ?

"VFS: Mounted root (cramfs filesystem) readonly.

 Mounted devfs on /dev "

[surabhi --- end]

=0D

> One more observation is that the U-boot bootargs are overwriting the

> Kernel boot arguments given at the time of build. Even though using

=0D

This is normal. If you use U-boot  there  is  no  need  to  have  any

pre-compiled  boot arguments; more: there is no need to use the whole

bootstrap loader which supplied these precompiled bootargs.

=0D

> setenv I removed the bootargs but still the kernel arguments given at

> the time of build using devrocket are not still active.

=0D

Just define the required bootargs in U-Boot.

=0D

> VFS: Mounted root (cramfs filesystem) readonly.

> Mounted devfs on /dev

> Freeing unused kernel memory: 60k init

> Warning: unable to open an initial console.

> Error -3 while decompressing!

=0D

Do not ignore this error. How big is your cramfs iage? How  much  RAM

do you have?

=0D

> 0015fd20(1928974736)->00141000(4096)

=0D

Is there any chance that you built your cramfs image on a x08 (or any

other little-endian) system and forgot  to  give  the  "-r"  (reverse

endian-ness of filesystem) option to mkcramfs??

=0D

Best regards,

=0D

Wolfgang Denk

=0D

--=0D

See us @ Embedded World, Nuremberg, Feb 22 - 24,  Hall 10.0 Booth 310

Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

In the strict scientific sense we all feed on death -- even

vegetarians.

      -- Spock, "Wolf in the Fold", stardate 3615.4





Confidentiality Notice=0D

The information contained in this electronic message and any attachments to=
 this message are intended
for the exclusive use of the addressee(s) and may contain confidential or=
 privileged information. If
you are not the intended recipient, please notify the sender at Wipro or=
 Mailadmin@wipro.com immediately
and destroy all copies of this message and any attachments.
------_=_NextPart_001_01C51363.21155EB0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=
=3D"urn:schemas-microsoft-com:office:word" xmlns:st1=
=3D"urn:schemas-microsoft-com:office:smarttags" xmlns=
=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=
=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"City"/>
<o:SmartTagType namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
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
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 77.95pt 1.0in 77.95pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'>My replies in blue tagged with surabhi<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'>-----Original Message-----<br>
From: wd@denx.de [mailto:wd@denx.de] <br>
Sent: Tuesday, February 15, 2005 5:24 PM<br>
To: Srinivas Surabhi (WT01 - EMBEDDED &amp; PRODUCT ENGINEERING=
 SOLUTIONS)<br>
Cc: linuxppc-embedded@ozlabs.org<br>
Subject: Re: Mounta Vista Linux prompt on serial console </span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'>In message
&lt;EF9B29C78F41FA488927FCBC7750AF0E011DA5C5@hyd-mdp-msg.wipro.com&gt; you
wrote:<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'>&gt; <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'>&gt; Today somehow after removing many options I build the kernel=
 and
able to<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'>&gt; succeed till the VFS: &quot;Mounted root (cramfs filesystem)
readonly.&quot; But<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'>&gt; then I am seeming &quot;kernel panic&quot;. Actually what=
 option
has to be given<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'>&gt; for init. We have given init=3D/bin/sh but no=
 luck.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'>You have to provide a working root filesystem in the first=
 place.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack face=3D"Courier=
 New"><span
style=3D'font-size:10.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier=
 New"><span
style=3D'font-size:10.0pt;color:blue'>[surabhi --- start] could you please=
 guide me
how to provide a working file system on SDRAM before decompressing the=
 Linux Image
on SDRAM. Is it really related to init process failed.=
 <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier=
 New"><span
style=3D'font-size:10.0pt;color:blue'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier=
 New"><span
style=3D'font-size:10.0pt;color:blue'>Is the below doesn&#8217;t mean that=
 the
mounted one is working one ?<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dred face=3D"Courier=
 New"><span
style=3D'font-size:10.0pt;color:red'>&#8220;VFS: Mounted root (cramfs=
 filesystem)
readonly.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dred face=3D"Courier=
 New"><span
style=3D'font-size:10.0pt;color:red'>&nbsp;Mounted devfs on /dev=
 &#8220;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier=
 New"><span
style=3D'font-size:10.0pt;color:blue'>[surabhi --- end]</span></font><font
color=3Dred><span style=3D'color:red'><o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'>&gt; One more observation is that the U-boot bootargs are=
 overwriting
the<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'>&gt; Kernel boot arguments given at the time of build. Even though
using<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'>This is normal. If you use U-boot&nbsp; there&nbsp; is&nbsp;=
 no&nbsp; need&nbsp; to&nbsp; have&nbsp; any<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'>pre-compiled&nbsp; boot arguments; more: there is no need to use=
 the whole<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'>bootstrap loader which supplied these precompiled=
 bootargs.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'>&gt; setenv I removed the bootargs but still the kernel arguments=
 given
at<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'>&gt; the time of build using devrocket are not still=
 active.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'>Just define the required bootargs in=
 U-Boot.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'>&gt; VFS: Mounted root (cramfs filesystem)=
 readonly.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'>&gt; Mounted devfs on /dev<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'>&gt; Freeing unused kernel memory: 60k=
 init<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'>&gt; Warning: unable to open an initial=
 console.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'>&gt; Error -3 while decompressing!<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'>Do not ignore this error. How big is your cramfs iage? How&nbsp;=
 much&nbsp; RAM<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'>do you have?<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'>&gt;=
 0015fd20(1928974736)-&gt;00141000(4096)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'>Is there any chance that you built your cramfs image on a x08 (or=
 any<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'>other little-endian) system and forgot&nbsp; to&nbsp; give=
 &nbsp;the&nbsp; &quot;-r&quot;&nbsp;
(reverse<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'>endian-ness of filesystem) option to=
 mkcramfs??<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack face=3D"Courier=
 New"><span
style=3D'font-size:10.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'>Best regards,<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'>Wolfgang Denk<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'>-- <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'>See us @ Embedded World, <st1:City w:st=3D"on"><st1:place w:st=
=3D"on">Nuremberg</st1:place></st1:City>,
Feb 22 - 24,&nbsp; Hall 10.0 Booth 310<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'>Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email:=
 wd@denx.de<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'>In the strict scientific sense we all feed on death --=
 even<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'>vegetarians.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -- Spock, &quot;Wolf in the=
 Fold&quot;, stardate 3615.4<o:p></o:p></span></font></p>

</div>

</body>

</html>

<table><tr><td bgcolor=3D#ffffff><font color=3D#000000><br>
<br>
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
------_=_NextPart_001_01C51363.21155EB0--
