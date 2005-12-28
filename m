Return-Path: <srideep.devireddy@wipro.com>
Received: from wip-cdctls-mx1.wipro.com (wip-cdctls-mx1.wipro.com
	[203.91.201.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wip-cdctls-mx1.wipro.com",
	Issuer "VeriSign Trust Network" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1284F679E0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Dec 2005 17:39:07 +1100 (EST)
Received: from wip-cdctls-mx1.wipro.com (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with ESMTP id 888B03C4035
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Dec 2005 12:04:17 +0530 (IST)
Received: from chn-snr-bh1.wipro.com (chn-snr-bh1.wipro.com [10.145.50.91])
	by wip-cdctls-mx1.wipro.com (Postfix) with ESMTP id 7DCD93C4033
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Dec 2005 12:04:17 +0530 (IST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C60B79.609B8F89"
Date: Wed, 28 Dec 2005 12:08:56 +0530
Message-ID: <6AD9F6A5F6E096408F0B703773355A070E700C@CHN-SNR-MBX01.wipro.com>
From: <srideep.devireddy@wipro.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Linux kernel Hangs after transfer
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

------_=_NextPart_001_01C60B79.609B8F89
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi All,

  My target is MPC8247 board where i tried to load my MPC8272 kernel tested=
 by montavista , i loaded linux image uImage at 100000 and it hangs after=
 transferrinbg linux kernel . when i used to debug it found that it is not=
 able to write to the console the log messages . it is hung at=
 my_write_console ... so can some one help me to debug this .. i am getting=
 following log when i try to bootm 100000


Bytes transferred =3D 644777 (9d6a9 hex)
=3D> bootm
## Booting image at 00100000 ...
   Image Name:   Linux-2.4.20_mvl31-8272ads
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    644713 Bytes =3D 629.6 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x0FBC08D8 =3D> set upper limit to 0x00800000
## cmdline at 0x007FFF00 ... 0x007FFF68
bd address  =3D 0x0FBC0BB4
memstart    =3D 0x00000000
memsize     =3D 0x10000000
flashstart  =3D 0xFE000000
flashsize   =3D 0x02000000
flashoffset =3D 0x00000000
sramstart   =3D 0x00000000
sramsize    =3D 0x00000000
immr_base   =3D 0xF0000000
bootflags   =3D 0x00000001
vco         =3D    396 MHz
sccfreq     =3D     99 MHz
brgfreq     =3D 24.750 MHz
intfreq     =3D    264 MHz
cpmfreq     =3D    198 MHz
busfreq     =3D     66 MHz
ethaddr     =3D 00:11:22:33:44:55
IP addr     =3D 192.168.80.196
baudrate    =3D 115200 bps
No initrd
## Transferring control to Linux (at address 00000000) ...


Thanks & Regards
Srideep Reddy D






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
------_=_NextPart_001_01C60B79.609B8F89
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=
=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version=
 6.5.7232.39">
<TITLE>Linux kernel Hangs after transfer</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi All,<BR>
<BR>
&nbsp; My target is MPC8247 board where i tried to load my MPC8272 kernel=
 tested by montavista , i loaded linux image uImage at 100000 and it hangs=
 after transferrinbg linux kernel . when i used to debug it found that it=
 is not able to write to the console the log messages . it is hung at=
 my_write_console ... so can some one help me to debug this .. i am getting=
 following log when i try to bootm 100000<BR>
<BR>
<BR>
Bytes transferred =3D 644777 (9d6a9 hex)<BR>
=3D&gt; bootm<BR>
## Booting image at 00100000 ...<BR>
&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.4.20_mvl31-8272ads<BR>
&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip=
 compressed)<BR>
&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 644713 Bytes =3D 629.6 kB<BR>
&nbsp;&nbsp; Load Address: 00000000<BR>
&nbsp;&nbsp; Entry Point:&nbsp; 00000000<BR>
&nbsp;&nbsp; Verifying Checksum ... OK<BR>
&nbsp;&nbsp; Uncompressing Kernel Image ... OK<BR>
## Current stack ends at 0x0FBC08D8 =3D&gt; set upper limit to=
 0x00800000<BR>
## cmdline at 0x007FFF00 ... 0x007FFF68<BR>
bd address&nbsp; =3D 0x0FBC0BB4<BR>
memstart&nbsp;&nbsp;&nbsp; =3D 0x00000000<BR>
memsize&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x10000000<BR>
flashstart&nbsp; =3D 0xFE000000<BR>
flashsize&nbsp;&nbsp; =3D 0x02000000<BR>
flashoffset =3D 0x00000000<BR>
sramstart&nbsp;&nbsp; =3D 0x00000000<BR>
sramsize&nbsp;&nbsp;&nbsp; =3D 0x00000000<BR>
immr_base&nbsp;&nbsp; =3D 0xF0000000<BR>
bootflags&nbsp;&nbsp; =3D 0x00000001<BR>
vco&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D&nbsp;&nbsp;&nbsp;=
 396 MHz<BR>
sccfreq&nbsp;&nbsp;&nbsp;&nbsp; =3D&nbsp;&nbsp;&nbsp;&nbsp; 99 MHz<BR>
brgfreq&nbsp;&nbsp;&nbsp;&nbsp; =3D 24.750 MHz<BR>
intfreq&nbsp;&nbsp;&nbsp;&nbsp; =3D&nbsp;&nbsp;&nbsp; 264 MHz<BR>
cpmfreq&nbsp;&nbsp;&nbsp;&nbsp; =3D&nbsp;&nbsp;&nbsp; 198 MHz<BR>
busfreq&nbsp;&nbsp;&nbsp;&nbsp; =3D&nbsp;&nbsp;&nbsp;&nbsp; 66 MHz<BR>
ethaddr&nbsp;&nbsp;&nbsp;&nbsp; =3D 00:11:22:33:44:55<BR>
IP addr&nbsp;&nbsp;&nbsp;&nbsp; =3D 192.168.80.196<BR>
baudrate&nbsp;&nbsp;&nbsp; =3D 115200 bps<BR>
No initrd<BR>
## Transferring control to Linux (at address 00000000) ...<BR>
<BR>
<BR>
Thanks &amp; Regards<BR>
Srideep Reddy D<BR>
<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
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
------_=_NextPart_001_01C60B79.609B8F89--
