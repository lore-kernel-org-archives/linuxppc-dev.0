Return-Path: <srideep.devireddy@wipro.com>
Received: from wip-cdctls-mx3.wipro.com (wip-cdctls-mx3.wipro.com
	[203.91.201.23])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wip-cdctls-mx3.wipro.com",
	Issuer "wip-cdctls-mx3.wipro.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B68186890D
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Dec 2005 02:44:42 +1100 (EST)
Received: from wip-cdctls-mx3.wipro.com (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with ESMTP id 5516429C476
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Dec 2005 20:47:57 +0530 (IST)
Received: from chn-snr-bh1.wipro.com (chn-snr-bh1.wipro.com [10.145.50.91])
	by wip-cdctls-mx3.wipro.com (Postfix) with ESMTP id 48BC229C2C7
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Dec 2005 20:47:57 +0530 (IST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6070A.E2D92C38"
Date: Thu, 22 Dec 2005 20:47:56 +0530
Message-ID: <6AD9F6A5F6E096408F0B703773355A070E6FE4@CHN-SNR-MBX01.wipro.com>
From: <srideep.devireddy@wipro.com>
To: <linuxppc-dev@ozlabs.org>
Subject: console problem on 8247
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6070A.E2D92C38
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


=0D
 HI ,
=0D
i am trying to use Ram disk with my mpc8247 board and compiled both the=
 linux kernel image and the ramdisk image and tried to load it on to the =
 board when i try doing this i am getting a familiar error  which is know=
 to all  hangs after uncompressing linux kernel ... actually  so please do=
 tell me what might be the problem as we are using SMC as the console .
=0D
=3D> bootm 100000 b00000
## Booting image at 00100000 ...
   Image Name:   Linux-2.4.20_mvl31-8272ads
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    680207 Bytes =3D 664.3 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x0FBC18D8 =3D> set upper limit to 0x00800000
## cmdline at 0x007FFF00 ... 0x007FFF49
bd address  =3D 0x0FBC1BB4
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
## Loading RAMDisk Image at 00b00000 ...
   Image Name:   uImage.ramdisk
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    1827099 Bytes =3D  1.7 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## initrd at 0x00B00040 ... 0x00CBE15A (len=3D1827099=3D0x1BE11B)
   Loading Ramdisk to 0fa02000, end 0fbc011b ... OK
## Transferring control to Linux (at address 00000000) ...

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
------_=_NextPart_001_01C6070A.E2D92C38
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"><HTML DIR=
=3Dltr><HEAD><META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html;=
 charset=3Diso-8859-1"></HEAD><BODY>
<DIV dir=3Dltr id=3DidOWAReplyText33986>
<DIV dir=3Dltr><FONT color=3D#000000 face=3DArial size=
=3D2>&nbsp;</FONT></DIV>
<DIV dir=3Dltr><FONT color=3D#000000 face=3DArial size=3D2>&nbsp;HI=
 ,</FONT></DIV>
<DIV dir=3Dltr>&nbsp;</DIV>
<DIV dir=3Dltr><FONT face=3DArial size=3D2>i am trying to use Ram disk with=
 my mpc8247=0D
board and compiled both the linux kernel image and the ramdisk image and=
 tried=0D
to load it on to the&nbsp; board when i try doing this i am getting a=
 familiar=0D
error&nbsp; which is know to all&nbsp; hangs after uncompressing linux=
 kernel=0D
... actually&nbsp; so please do tell me what might be the problem as we are=
=0D
using SMC as the console .</FONT></DIV>
<DIV dir=3Dltr>&nbsp;</DIV>
<DIV dir=3Dltr><FONT face=3DArial size=3D2>=3D&gt; bootm 100000=
 b00000<BR>## Booting=0D
image at 00100000 ...<BR>&nbsp;&nbsp; Image Name:&nbsp;&nbsp;=0D
Linux-2.4.20_mvl31-8272ads<BR>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC=
 Linux=0D
Kernel Image (gzip compressed)<BR>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp;=
=0D
680207 Bytes =3D 664.3 kB<BR>&nbsp;&nbsp; Load Address:=
 00000000<BR>&nbsp;&nbsp;=0D
Entry Point:&nbsp; 00000000<BR>&nbsp;&nbsp; Verifying Checksum ...=0D
OK<BR>&nbsp;&nbsp; Uncompressing Kernel Image ... OK<BR>## Current stack=
 ends at=0D
0x0FBC18D8 =3D&gt; set upper limit to 0x00800000<BR>## cmdline at=
 0x007FFF00 ...=0D
0x007FFF49<BR>bd address&nbsp; =3D 0x0FBC1BB4<BR>memstart&nbsp;&nbsp;&nbsp;=
 =3D=0D
0x00000000<BR>memsize&nbsp;&nbsp;&nbsp;&nbsp; =3D=
 0x10000000<BR>flashstart&nbsp; =3D=0D
0xFE000000<BR>flashsize&nbsp;&nbsp; =3D 0x02000000<BR>flashoffset =3D=0D
0x00000000<BR>sramstart&nbsp;&nbsp; =3D=
 0x00000000<BR>sramsize&nbsp;&nbsp;&nbsp; =3D=0D
0x00000000<BR>immr_base&nbsp;&nbsp; =3D 0xF0000000<BR>bootflags&nbsp;&nbsp;=
 =3D=0D
0x00000001<BR>vco&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=0D
=3D&nbsp;&nbsp;&nbsp; 396 MHz<BR>sccfreq&nbsp;&nbsp;&nbsp;&nbsp;=0D
=3D&nbsp;&nbsp;&nbsp;&nbsp; 99 MHz<BR>brgfreq&nbsp;&nbsp;&nbsp;&nbsp; =3D=
 24.750=0D
MHz<BR>intfreq&nbsp;&nbsp;&nbsp;&nbsp; =3D&nbsp;&nbsp;&nbsp; 264=0D
MHz<BR>cpmfreq&nbsp;&nbsp;&nbsp;&nbsp; =3D&nbsp;&nbsp;&nbsp; 198=0D
MHz<BR>busfreq&nbsp;&nbsp;&nbsp;&nbsp; =3D&nbsp;&nbsp;&nbsp;&nbsp; 66=0D
MHz<BR>ethaddr&nbsp;&nbsp;&nbsp;&nbsp; =3D 00:11:22:33:44:55<BR>IP=0D
addr&nbsp;&nbsp;&nbsp;&nbsp; =3D=
 192.168.80.196<BR>baudrate&nbsp;&nbsp;&nbsp; =3D=0D
115200 bps<BR>## Loading RAMDisk Image at 00b00000 ...<BR>&nbsp;&nbsp;=
 Image=0D
Name:&nbsp;&nbsp; uImage.ramdisk<BR>&nbsp;&nbsp; Image Type:&nbsp;&nbsp;=
 PowerPC=0D
Linux RAMDisk Image (gzip compressed)<BR>&nbsp;&nbsp; Data=0D
Size:&nbsp;&nbsp;&nbsp; 1827099 Bytes =3D&nbsp; 1.7 MB<BR>&nbsp;&nbsp; Load=
=0D
Address: 00000000<BR>&nbsp;&nbsp; Entry Point:&nbsp;=
 00000000<BR>&nbsp;&nbsp;=0D
Verifying Checksum ... OK<BR>## initrd at 0x00B00040 ... 0x00CBE15A=0D
(len=3D1827099=3D0x1BE11B)<BR>&nbsp;&nbsp; Loading Ramdisk to 0fa02000, end=
 0fbc011b=0D
... OK<BR>## Transferring control to Linux (at address 00000000)=0D
...<BR></FONT></DIV></DIV>
<DIV dir=3Dltr id=3DidSignature55147><PRE>&nbsp;</PRE></DIV></BODY></HTML>
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
------_=_NextPart_001_01C6070A.E2D92C38--
