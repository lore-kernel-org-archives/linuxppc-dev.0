Return-Path: <cthomas@Soneticom.com>
Received: from Soneticom.com (soneticom.com [209.114.210.150])
	by ozlabs.org (Postfix) with ESMTP id BC16067B69
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Aug 2006 05:56:41 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6CADC.1357E43D"
Subject: PPC405 system slow boot
Date: Mon, 28 Aug 2006 15:56:38 -0400
Message-ID: <3C02138692C13C4BB675FE7EA240952918E1E2@bluefin.Soneticom.local>
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

------_=_NextPart_001_01C6CADC.1357E43D
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hey guys,

I've run through the loops to try and figure what could be wrong with
this system. The board in question is modeled after the Xilinx ML300
board. It uses a Xilinx System ACE chip to load a FPGA / Kernel image
from compact flash. Originally, I was trying to use the CompactFlash as
the root file system, but because of issues in either the design or
software, this would only work if SysAce was in polled I/O mode. To
circumvent this, I built my root filesystem into an initrd image and
built a single ELF file with the Kernel and RFS, then strapped that to
the FPGA bit file to make a single FPGA/Kernel/RFS SysAce file.

Upon decompression, the Linux kernel boots quickly and loads all of the
device drivers. However when it gets to the prompt, it starts slowing
down. Output and input to and from the board becomes very very slow (it
displays 2 characters roughly every 20 seconds). Originally I believed
this to be the CPU still polling SystemAce, so I disabled the Linux
System ACE drivers to remove that as a possibility, however after doing
this, the problem still persists, even with the RFS in ram! Has anybody
encountered a similar situation to this before, with possible insight
towards a solution? Thank you for your time.
=20
Clinton Thomas
cthomas@soneticom.com
=20

------_=_NextPart_001_01C6CADC.1357E43D
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2963" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D068485119-28082006><FONT face=3DArial size=3D2>Hey=20
guys,<BR><BR>I've run through the loops to try and figure what could be =
wrong=20
with this system. The board in question is modeled after the Xilinx =
ML300 board.=20
It uses a Xilinx System ACE chip to load a FPGA / Kernel image from =
compact=20
flash. Originally, I was trying to use the CompactFlash as the root file =
system,=20
but because of issues in either the design or software, this would only =
work if=20
SysAce was in polled I/O mode. To circumvent this, I built my root =
filesystem=20
into an initrd image and built a single ELF file with the Kernel and =
RFS, then=20
strapped that to the FPGA bit file to make a single FPGA/Kernel/RFS =
SysAce=20
file.<BR><BR>Upon decompression, the Linux kernel boots quickly and =
loads all of=20
the device drivers. However when it gets to the prompt, it starts =
slowing down.=20
Output and input to and from the board becomes very very slow (it =
displays 2=20
characters roughly every 20 seconds). Originally I believed this to be =
the CPU=20
still polling SystemAce, so I disabled the Linux System ACE drivers to =
remove=20
that as a possibility, however after doing this, the problem still =
persists,=20
even with the RFS in ram! Has anybody encountered a similar situation to =
this=20
before, with possible insight towards a solution? Thank you for your=20
time.</FONT></SPAN></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV align=3Dleft><FONT face=3DArial size=3D2>Clinton=20
Thomas<BR>cthomas@soneticom.com</FONT></DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C6CADC.1357E43D--
