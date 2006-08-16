Return-Path: <cthomas@Soneticom.com>
Received: from Soneticom.com (soneticom.com [209.114.210.150])
	by ozlabs.org (Postfix) with ESMTP id E338A679FD
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Aug 2006 07:06:07 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6C177.C91622B9"
Subject: Linux hanging on Xilinx SystemACE
Date: Wed, 16 Aug 2006 17:06:06 -0400
Message-ID: <3C02138692C13C4BB675FE7EA240952918DBED@bluefin.Soneticom.local>
From: "Clint Thomas" <cthomas@Soneticom.com>
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

------_=_NextPart_001_01C6C177.C91622B9
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hey,

Using the powerpc development tree of Linux 2.4, I am trying to boot my
system from CompactFlash using Xilinx SystemACE. My compact flash card
has two partitions, a 16MB FAT16 that holds the combination FPGA image /
Linux Kernel ELF file, and an Ext2 partition that holds the root file
system. The system starts the boot process, uncompresses the Linux
kernel and begins loading drivers. Part way into this process, it
conducts a partition check of the drive being reported to it by
SystemACE, however, it hangs at that point. No kernel panic, no error
message, it simply hangs. Here is the output at that point...

Partition check:
 xsysacea:
=20
what I am trying to find out is if this problem has been seen/fixed in
the past? or did I format the CF card incorrectly?
=20
Clinton Thomas
cthomas@soneticom.com
=20

------_=_NextPart_001_01C6C177.C91622B9
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2963" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D058180021-16082006>Hey,<BR><BR>Using=20
the powerpc development tree of Linux 2.4, I am trying to boot my system =
from=20
CompactFlash using Xilinx SystemACE. My compact flash card has two =
partitions, a=20
16MB FAT16 that holds the combination FPGA image / Linux Kernel ELF =
file, and an=20
Ext2 partition that holds the root file system. The system starts the =
boot=20
process, uncompresses the Linux kernel and begins loading drivers. Part =
way into=20
this process, it conducts a partition check of the drive being reported =
to it by=20
SystemACE, however, it hangs at that point. No kernel panic, no error =
message,=20
it simply hangs. Here is the output at that =
point...<BR><BR><EM>Partition=20
check:<BR>&nbsp;xsysacea:</EM></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D058180021-16082006>what I =
am trying to=20
find out is if this problem has been seen/fixed in the past? or did I =
format the=20
CF card incorrectly?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV align=3Dleft><FONT face=3DArial size=3D2>Clinton=20
Thomas<BR>cthomas@soneticom.com</FONT></DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C6C177.C91622B9--
