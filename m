Return-Path: <srideep.devireddy@wipro.com>
Received: from wip-cdctls-mx1.wipro.com (wip-cdctls-mx1.wipro.com
	[203.91.201.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wip-cdctls-mx1.wipro.com",
	Issuer "VeriSign Trust Network" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9940367C01
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Oct 2006 00:57:22 +1000 (EST)
Received: from wip-cdctls-mx1.wipro.com (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with ESMTP id 5ED593C40E7
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Oct 2006 20:01:41 +0530 (IST)
Received: from chn-snr-bh1.wipro.com (chn-snr-bh1.wipro.com [10.145.50.91])
	by wip-cdctls-mx1.wipro.com (Postfix) with ESMTP id 542C33C407D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Oct 2006 20:01:41 +0530 (IST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6EE0B.433A7922"
Subject: Modules_install (depmod) prob 
Date: Thu, 12 Oct 2006 20:03:18 +0530
Message-ID: <6AD9F6A5F6E096408F0B703773355A07015375CA@CHN-SNR-MBX01.wipro.com>
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

------_=_NextPart_001_01C6EE0B.433A7922
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Hi ,

=0D

   I am trying to compile mvista linux  , I am able to run make dep ,
make zImage successfully after I do make modules and make
modules_install .

=0D

I am struck with below errors , I found that depmod which is x86 cant
execute it on the modules created for Arm . can any one give me any
suggestion to bypass this and make depmod as crosscompile  or over come
this problem . I got few out by googling that we have to change few
CFLAGS or depmod.pl , if any one has used it please let me know .Thanks
in advance ..

=0D

Log

=0D

find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{}
pcmcia

if [ -r System.map ]; then /sbin/depmod -ae -F System.map
2.4.19-rmk7-ds3-mw1; fi

depmod: ELF file
/lib/modules/2.4.19-rmk7-ds3-mw1/kernel/drivers/csr/csr.o not for this
architecture

depmod: ELF file
/lib/modules/2.4.19-rmk7-ds3-mw1/kernel/drivers/csr/csr_atmdAcc.o not
for this architecture

depmod: ELF file
/lib/modules/2.4.19-rmk7-ds3-mw1/kernel/drivers/csr/csr_atmm.o not for
this architecture

depmod: ELF file
/lib/modules/2.4.19-rmk7-ds3-mw1/kernel/drivers/csr/csr_atmsch.o not for
this architecture

depmod: ELF file
/lib/modules/2.4.19-rmk7-ds3-mw1/kernel/drivers/csr/csr_codelets_atmDemo
.o not for this architecture

depmod: ELF file
/lib/modules/2.4.19-rmk7-ds3-mw1/kernel/drivers/csr/csr_codelets_cryptoA
cc.o not for this architecture

depmod: ELF file
/lib/modules/2.4.19-rmk7-ds3-mw1/kernel/drivers/csr/csr_codelets_demoUti
ls.o not for this architecture

depmod: ELF file
/lib/modules/2.4.19-rmk7-ds3-mw1/kernel/drivers/csr/csr_codelets_dmaAcc.
o not for this architecture

depmod: ELF file
/lib/modules/2.4.19-rmk7-ds3-mw1/kernel/drivers/csr/csr_codelets_ethAal5
App.o not for this architecture

depmod: ELF file
/lib/modules/2.4.19-rmk7-ds3-mw1/kernel/drivers/csr/csr_codelets_ethAcc.
o not for this architecture

depmod: ELF file
/lib/modules/2.4.19-rmk7-ds3-mw1/kernel/drivers/csr/csr_codelets_fpathAc
c.o not for this architecture

depmod: ELF file
/lib/modules/2.4.19-rmk7-ds3-mw1/kernel/drivers/csr/csr_codelets_hssAcc.
o not for this architecture

depmod: ELF file
/lib/modules/2.4.19-rmk7-ds3-mw1/kernel/drivers/csr/csr_codelets_oam.o
not for this architecture

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
------_=_NextPart_001_01C6EE0B.433A7922
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=
=3D"urn:schemas-microsoft-com:office:word" xmlns=
=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
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

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>Hi ,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>&nbsp;&nbsp; I am trying to compile=
 mvista
linux&nbsp; , I am able to run make dep , make zImage successfully after I=
 do
make modules and make modules_install .<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>I am struck with below errors , I=
 found
that depmod which is x86 cant execute it on the modules created for Arm .=
 can
any one give me any suggestion to bypass this and make depmod as
crosscompile&nbsp; or over come this problem . I got few out by googling=
 that
we have to change few CFLAGS or depmod.pl , if any one has used it please=
 let
me know .Thanks in advance ..<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>Log<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>find kernel -path '*/pcmcia/*' -name=
 '*.o'
| xargs -i -r ln -sf ../{} pcmcia<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>if [ -r System.map ]; then=
 /sbin/depmod
-ae -F System.map&nbsp; 2.4.19-rmk7-ds3-mw1;=
 fi<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>depmod: ELF file
/lib/modules/2.4.19-rmk7-ds3-mw1/kernel/drivers/csr/csr.o not for this=
 architecture<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>depmod: ELF file
/lib/modules/2.4.19-rmk7-ds3-mw1/kernel/drivers/csr/csr_atmdAcc.o not for=
 this
architecture<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>depmod: ELF file
/lib/modules/2.4.19-rmk7-ds3-mw1/kernel/drivers/csr/csr_atmm.o not for this
architecture<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>depmod: ELF file=
 /lib/modules/2.4.19-rmk7-ds3-mw1/kernel/drivers/csr/csr_atmsch.o
not for this architecture<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>depmod: ELF file
/lib/modules/2.4.19-rmk7-ds3-mw1/kernel/drivers/csr/csr_codelets_atmDemo.o=
 not
for this architecture<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>depmod: ELF file
/lib/modules/2.4.19-rmk7-ds3-mw1/kernel/drivers/csr/csr_codelets_cryptoAcc.=
o
not for this architecture<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>depmod: ELF file
/lib/modules/2.4.19-rmk7-ds3-mw1/kernel/drivers/csr/csr_codelets_demoUtils.=
o
not for this architecture<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>depmod: ELF file
/lib/modules/2.4.19-rmk7-ds3-mw1/kernel/drivers/csr/csr_codelets_dmaAcc.o=
 not
for this architecture<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>depmod: ELF file
/lib/modules/2.4.19-rmk7-ds3-mw1/kernel/drivers/csr/csr_codelets_ethAal5App=
.o
not for this architecture<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>depmod: ELF file
/lib/modules/2.4.19-rmk7-ds3-mw1/kernel/drivers/csr/csr_codelets_ethAcc.o=
 not
for this architecture<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>depmod: ELF file
/lib/modules/2.4.19-rmk7-ds3-mw1/kernel/drivers/csr/csr_codelets_fpathAcc.o=
 not
for this architecture<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>depmod: ELF file=
 /lib/modules/2.4.19-rmk7-ds3-mw1/kernel/drivers/csr/csr_codelets_hssAcc.o
not for this architecture<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>depmod: ELF file
/lib/modules/2.4.19-rmk7-ds3-mw1/kernel/drivers/csr/csr_codelets_oam.o not=
 for
this architecture<o:p></o:p></span></font></p>

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
------_=_NextPart_001_01C6EE0B.433A7922--
