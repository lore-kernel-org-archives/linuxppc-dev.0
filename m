Return-Path: <tbachman@annapmicro.com>
Received: from whasmtp-tariff.pas.sa.earthlink.net
	(whasmtp-tariff.pas.sa.earthlink.net [207.217.120.87])
	by bilbo.ozlabs.org (Postfix) with ESMTP id EF109B707B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jul 2009 06:41:02 +1000 (EST)
Received: from [66.167.232.203] (helo=mimic)
	by whasmtp-tariff.pas.sa.earthlink.net with esmtpa (Exim 4.67)
	(envelope-from <tbachman@annapmicro.com>) id 1MU4jc-0007tg-Jk
	for linuxppc-dev@lists.ozlabs.org; Thu, 23 Jul 2009 13:17:48 -0700
From: "Thomas Bachman" <tbachman@annapmicro.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: SATA on PowerPC460EX with 2.6.27 kernel
Date: Thu, 23 Jul 2009 16:17:44 -0400
Message-ID: <0F154486D4C4480586F55434BEC41C3F@mimic>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00D6_01CA0BB1.1CDBE350"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_00D6_01CA0BB1.1CDBE350
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

We're trying to use the SATA interface on our PowerPC460EX. 
We've applied the following patch:
 
http://markmail.org/message/p5kdgzyneuxzdvjh
 
Our kernel is based on AMCC's "Arches" eval board distro kernel
(2.6.27-rc5), 
and with this patch, we're able to get the SATA interface up and running,
insomuch as 
it can discover our hard disk. Unfortunately, we're not able to mount,
format, or do any 
other functions with the disk. We see the following in our logs:
 
sata-dwc sata-dwc.0: sata_dwc_error_intr SCR_ERROR=0x04050002
intpr=0x00000008 status=0x000000
80 dma_intp=0 pending=-1070221560 issued=4 dma_err_status=0x00000000
ata1: exception Emask 0x30 SAct 0x0 SErr 0x4050002 action 0xe frozen
ata1: SError: { RecovComm PHYRdyChg CommWake DevExch }
scsi 0:0:0:0: Direct-Access     ATA      TOSHIBA MK1216GS RS01 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 234441648 512-byte hardware sectors (120034 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support
DPO or FUA
sd 0:0:0:0: [sda] 234441648 512-byte hardware sectors (120034 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support
DPO or FUA
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: link is slow to respond, please be patient (ready=0)
ata1: prereset failed (errno=-16)
ata1: reset failed, giving up
ata1.00: disabled
end_request: I/O error, dev sda, sector 0
Buffer I/O error on device sda, logical block 0
end_request: I/O error, dev sda, sector 0
Buffer I/O error on device sda, logical block 0
 unable to read partition table
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
 
 
The disk is a 120GB Toshiba hard drive, 1.5Gbps SATA.
 
I found that someone had a similar problem when going to a newer kernel:
 
http://lists-archives.org/linux-kernel/19814689-about-synopsys-designware-co
res-dwc-sata-host-driver.html
 
Has this been fixed? We weren't sure if this patch ever happened, and if so,
where we could get it. 
 
 
-Thomas Bachman
-Annapolis Micro Systems, Inc.

------=_NextPart_000_00D6_01CA0BB1.1CDBE350
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Dus-ascii" =
http-equiv=3DContent-Type>
<META name=3DGENERATOR content=3D"MSHTML 8.00.6001.18783"></HEAD>
<BODY>
<DIV><SPAN class=3D100115619-23072009><FONT size=3D2 face=3DArial>We're =
trying to use=20
the SATA interface on our PowerPC460EX. </FONT></SPAN></DIV>
<DIV><SPAN class=3D100115619-23072009><FONT size=3D2 face=3DArial>We've =
applied the=20
following patch<SPAN =
class=3D051340620-23072009>:</SPAN></FONT></SPAN></DIV>
<DIV><SPAN class=3D100115619-23072009><FONT size=3D2 face=3DArial><SPAN=20
class=3D051340620-23072009></SPAN></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D100115619-23072009><FONT size=3D2 face=3DArial><SPAN=20
class=3D051340620-23072009><A=20
href=3D"http://markmail.org/message/p5kdgzyneuxzdvjh">http://markmail.org=
/message/p5kdgzyneuxzdvjh</A></SPAN></FONT></SPAN></DIV>
<DIV><SPAN class=3D100115619-23072009><FONT size=3D2 face=3DArial><SPAN=20
class=3D051340620-23072009></SPAN></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D100115619-23072009><SPAN =
class=3D051340620-23072009></SPAN><FONT=20
face=3DArial><FONT size=3D2><SPAN =
class=3D051340620-23072009>Our</SPAN>&nbsp;kernel is=20
based o<SPAN class=3D051340620-23072009>n</SPAN>&nbsp;<SPAN=20
class=3D051340620-23072009>AMCC's "A</SPAN></FONT></FONT></SPAN><SPAN=20
class=3D100115619-23072009><FONT size=3D2 face=3DArial>rches<SPAN=20
class=3D051340620-23072009>" eval board</SPAN>&nbsp;distro kernel=20
(</FONT></SPAN><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D100115619-23072009>2.6.27-rc5</SPAN><SPAN =
class=3D100115619-23072009>),=20
</SPAN></FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN =
class=3D100115619-23072009>and&nbsp;<SPAN=20
class=3D051340620-23072009>with this patch, we're </SPAN>able to =
</SPAN><SPAN=20
class=3D100115619-23072009>get the SATA interface up and running, =
insomuch as=20
</SPAN></FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN =
class=3D100115619-23072009>it can=20
discover our </SPAN></FONT></FONT><SPAN class=3D100115619-23072009><FONT =
size=3D2=20
face=3DArial>hard disk. Unfortunately, we're not able to mount, format, =
or do any=20
</FONT></SPAN></DIV>
<DIV><SPAN class=3D100115619-23072009><FONT size=3D2 face=3DArial>other=20
f</FONT></SPAN><SPAN class=3D100115619-23072009><FONT size=3D2 =
face=3DArial>unctions=20
</FONT></SPAN><SPAN class=3D100115619-23072009><FONT size=3D2 =
face=3DArial>with the=20
disk. We see the following in our logs:</FONT></SPAN></DIV>
<DIV><SPAN class=3D100115619-23072009><FONT size=3D2=20
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D100115619-23072009><FONT size=3D2 =
face=3DArial>sata-dwc sata-dwc.0:=20
sata_dwc_error_intr SCR_ERROR=3D0x04050002 intpr=3D0x00000008 =
status=3D0x000000<BR>80=20
dma_intp=3D0 pending=3D-1070221560 issued=3D4 =
dma_err_status=3D0x00000000<BR>ata1:=20
exception Emask 0x30 SAct 0x0 SErr 0x4050002 action 0xe frozen<BR>ata1: =
SError:=20
{ RecovComm PHYRdyChg CommWake DevExch }<BR>scsi 0:0:0:0:=20
Direct-Access&nbsp;&nbsp;&nbsp;&nbsp; ATA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TOSHIBA=20
MK1216GS RS01 PQ: 0 ANSI: 5<BR>sd 0:0:0:0: [sda] 234441648 512-byte =
hardware=20
sectors (120034 MB)<BR>sd 0:0:0:0: [sda] Write Protect is off<BR>sd =
0:0:0:0:=20
[sda] Write cache: enabled, read cache: enabled, doesn't support DPO or=20
FUA<BR>sd 0:0:0:0: [sda] 234441648 512-byte hardware sectors (120034 =
MB)<BR>sd=20
0:0:0:0: [sda] Write Protect is off<BR>sd 0:0:0:0: [sda] Write cache: =
enabled,=20
read cache: enabled, doesn't support DPO or FUA</FONT></SPAN></DIV>
<DIV><SPAN class=3D100115619-23072009><FONT size=3D2 =
face=3DArial>ata1.00: exception=20
Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen<BR>ata1.00: cmd=20
c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096=20
in<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; res=20
40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)<BR>ata1.00: =
status: {=20
DRDY }<BR>ata1: link is slow to respond, please be patient =
(ready=3D0)<BR>ata1:=20
prereset failed (errno=3D-16)<BR>ata1: reset failed, giving =
up<BR>ata1.00:=20
disabled<BR>end_request: I/O error, dev sda, sector 0<BR>Buffer I/O =
error on=20
device sda, logical block 0<BR>end_request: I/O error, dev sda, sector=20
0<BR>Buffer I/O error on device sda, logical block 0<BR>&nbsp;unable to =
read=20
partition table<BR>sd 0:0:0:0: [sda] Attached SCSI disk<BR>sd 0:0:0:0: =
Attached=20
scsi generic sg0 type 0</FONT></SPAN></DIV>
<DIV><SPAN class=3D100115619-23072009><FONT size=3D2=20
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D100115619-23072009><FONT size=3D2=20
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D100115619-23072009><FONT size=3D2 face=3DArial>The =
disk is a 120GB=20
Toshiba hard drive, 1.5Gbps SATA.</FONT></SPAN></DIV>
<DIV><SPAN class=3D100115619-23072009><FONT size=3D2=20
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D100115619-23072009><FONT size=3D2 face=3DArial>I =
found that someone=20
had a similar problem when going to a newer kernel:</FONT></SPAN></DIV>
<DIV><SPAN class=3D100115619-23072009><FONT size=3D2=20
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D100115619-23072009><FONT size=3D2 face=3DArial><A=20
title=3Dblocked::http://lists-archives.org/linux-kernel/19814689-about-sy=
nopsys-designware-cores-dwc-sata-host-driver.html=20
href=3D"http://lists-archives.org/linux-kernel/19814689-about-synopsys-de=
signware-cores-dwc-sata-host-driver.html">http://lists-archives.org/linux=
-kernel/19814689-about-synopsys-designware-cores-dwc-sata-host-driver.htm=
l</A></FONT></SPAN></DIV>
<DIV><SPAN class=3D100115619-23072009><FONT size=3D2=20
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D100115619-23072009><FONT face=3DArial><FONT =
size=3D2><SPAN=20
class=3D051340620-23072009>Has this been </SPAN><SPAN=20
class=3D100115619-23072009><SPAN=20
class=3D051340620-23072009>fixed?</SPAN></SPAN><SPAN =
class=3D051340620-23072009>=20
W</SPAN>e weren't sure if this patch ever happened, and if so, where we =
could=20
get it.&nbsp;</FONT></FONT></SPAN></DIV>
<DIV><SPAN class=3D100115619-23072009><FONT size=3D2=20
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D100115619-23072009><FONT size=3D2=20
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D100115619-23072009>
<DIV align=3Dleft><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D051340620-23072009>-</SPAN>Thomas Bachman</FONT></FONT></DIV>
<DIV align=3Dleft><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D051340620-23072009>-</SPAN>Annapolis Micro Systems,=20
Inc.</FONT></FONT></DIV></SPAN></DIV></BODY></HTML>

------=_NextPart_000_00D6_01CA0BB1.1CDBE350--
