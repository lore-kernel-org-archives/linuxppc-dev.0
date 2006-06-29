Return-Path: <srideep.devireddy@wipro.com>
Received: from wip-cdctls-mx1.wipro.com (wip-cdctls-mx1.wipro.com
	[203.91.201.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wip-cdctls-mx1.wipro.com",
	Issuer "VeriSign Trust Network" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 58F0A67B60
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Jun 2006 15:25:50 +1000 (EST)
Received: from wip-cdctls-mx1.wipro.com (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with ESMTP id A09033C4050
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Jun 2006 10:45:58 +0530 (IST)
Received: from chn-snr-bh2.wipro.com (chn-snr-bh2.wipro.com [10.145.50.92])
	by wip-cdctls-mx1.wipro.com (Postfix) with ESMTP id 931363C400C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Jun 2006 10:45:58 +0530 (IST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C69B3C.780638FD"
Subject: FW: unresolved symbol on target ... while insmod
Date: Thu, 29 Jun 2006 10:55:45 +0530
Message-ID: <6AD9F6A5F6E096408F0B703773355A07010F8F6B@CHN-SNR-MBX01.wipro.com>
From: <srideep.devireddy@wipro.com>
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

------_=_NextPart_001_01C69B3C.780638FD
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Thanks ... I am able to resolve the problem ...

=0D

________________________________

From: Srideep DeviReddy (WT01 - Broadband Networks)=0D
Sent: Thursday, June 29, 2006 10:30 AM
To: 'linuxppc-embedded@ozlabs.org'
Subject: unresolved symbol on target ... while insmod

=0D

Hello All ,

=0D

 I compiled a driver module  using cross compiler for MPC8247 , now when
I try to insert the module in to the target  I give me an error like=0D

=0D

root@10.0.0.2:/home# insmod linux-kernel-bde.o

Using linux-kernel-bde.o

insmod: unresolved symbol devfs_register

insmod: unresolved symbol vsprintf

insmod: unresolved symbol kmalloc

insmod: unresolved symbol create_proc_entry

insmod: unresolved symbol __get_free_pages

insmod: unresolved symbol __save_flags_ptr

insmod: unresolved symbol ioremap

insmod: unresolved symbol free_irq

insmod: unresolved symbol high_memory

insmod: unresolved symbol devfs_unregister

insmod: unresolved symbol iounmap

insmod: unresolved symbol free_pages

insmod: unresolved symbol kfree

insmod: unresolved symbol strlen

insmod: unresolved symbol remove_proc_entry

insmod: unresolved symbol request_irq

insmod: unresolved symbol mem_map

insmod: unresolved symbol simple_strtoul

insmod: unresolved symbol sprintf

insmod: unresolved symbol __restore_flags

insmod: unresolved symbol printk

insmod: unresolved symbol __cli

=0D

Can any one show me some pointers what is this error all about . And how
to over come this . Thanks in advance=0D

=0D

Best Regards

Srideep

=0D




The information contained in this electronic message and any attachments to=
 this message are intended for the exclusive use of the addressee(s) and=
 may contain proprietary, confidential or privileged information. If you=
 are not the intended recipient, you should not disseminate, distribute or=
 copy this e-mail. Please notify the sender immediately and destroy all=
 copies of this message and any attachments.=0D

WARNING: Computer viruses can be transmitted via email. The recipient=
 should check this email and any attachments for the presence of viruses.=
 The company accepts no liability for any damage caused by any virus=
 transmitted by this email.
=0D
www.wipro.com
------_=_NextPart_001_01C69B3C.780638FD
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=
=3D"urn:schemas-microsoft-com:office:office" xmlns:w=
=3D"urn:schemas-microsoft-com:office:word" xmlns=
=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
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
span.EmailStyle17
	{mso-style-type:personal;
	color:black;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:Arial;
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
10.0pt;font-family:Arial;color:black'>Thanks &#8230; I am able to resolve=
 the
problem &#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:black'><o:p>&nbsp;</o:p></span></font></p>

<div>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font=
 size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>

<hr size=3D2 width=3D"100%" align=3Dcenter tabindex=3D-1>

</span></font></div>

<p class=3DMsoNormal><b><font size=3D2 face=3DTahoma><span style=
=3D'font-size:10.0pt;
font-family:Tahoma;font-weight:bold'>From:</span></font></b><font size=3D2
face=3DTahoma><span style=3D'font-size:10.0pt;font-family:Tahoma'> Srideep
DeviReddy (WT01 - Broadband Networks) <br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Thursday, June 29,=
 2006
10:30 AM<br>
<b><span style=3D'font-weight:bold'>To:</span></b>=
 'linuxppc-embedded@ozlabs.org'<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> unresolved symbol=
 on
target ... while insmod</span></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=
=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>Hello All=
 ,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>&nbsp;I compiled a driver module
&nbsp;using cross compiler for MPC8247 , now when I try to insert the=
 module in
to the target&nbsp; I give me an error like <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>root@10.0.0.2:/home# insmod
linux-kernel-bde.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>Using=
 linux-kernel-bde.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>insmod: unresolved symbol=
 devfs_register<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>insmod: unresolved symbol=
 vsprintf<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>insmod: unresolved symbol=
 kmalloc<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>insmod: unresolved symbol
create_proc_entry<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>insmod: unresolved symbol=
 __get_free_pages<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>insmod: unresolved symbol=
 __save_flags_ptr<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>insmod: unresolved symbol=
 ioremap<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>insmod: unresolved symbol=
 free_irq<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>insmod: unresolved symbol=
 high_memory<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>insmod: unresolved symbol=
 devfs_unregister<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>insmod: unresolved symbol=
 iounmap<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>insmod: unresolved symbol=
 free_pages<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>insmod: unresolved symbol=
 kfree<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>insmod: unresolved symbol=
 strlen<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>insmod: unresolved symbol
remove_proc_entry<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>insmod: unresolved symbol=
 request_irq<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>insmod: unresolved symbol=
 mem_map<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>insmod: unresolved symbol=
 simple_strtoul<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>insmod: unresolved symbol=
 sprintf<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>insmod: unresolved symbol=
 __restore_flags<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>insmod: unresolved symbol=
 printk<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>insmod: unresolved symbol=
 __cli<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>Can any one show me some pointers=
 what is
this error all about . And how to over come this . Thanks in advance=
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
style=3D'font-size:12.0pt;color:black'>Srideep<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

<table><tr><td bgcolor=3D#ffffff><font color=3D#000000><br>
The information contained in this electronic message and any attachments to=
 this message are intended for the exclusive use of the addressee(s) and=
 may contain proprietary, confidential or privileged information. If you=
 are not the intended recipient, you should not disseminate, distribute or=
 copy this e-mail. Please notify the sender immediately and destroy all=
 copies of this message and any attachments. <br>
<br>
WARNING: Computer viruses can be transmitted via email. The recipient=
 should check this email and any attachments for the presence of viruses.=
 The company accepts no liability for any damage caused by any virus=
 transmitted by this email.<br>
 <br>
www.wipro.com<br>
</font></td></tr></table>
------_=_NextPart_001_01C69B3C.780638FD--
