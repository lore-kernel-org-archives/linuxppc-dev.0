Return-Path: <ma.harounansari@gdatech.co.in>
Received: from gdatech.co.in (mail.gdatech.co.in [202.144.30.226])
	by ozlabs.org (Postfix) with ESMTP id EE6ECDDE09
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Jan 2008 21:45:52 +1100 (EST)
Received: from [172.29.36.2] (localhost.localdomain [127.0.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 74B988780B4
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Jan 2008 02:26:21 -0800 (PST)
Received: from mail.gdatech.co.in (unknown [172.29.36.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 2707D87805D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Jan 2008 02:26:21 -0800 (PST)
Message-ID: <002401c85761$12104700$bb261dac@Ansari>
From: "Ansari" <ma.harounansari@gdatech.co.in>
To: <linuxppc-embedded@ozlabs.org>
Subject: USB Mass Storare (PCI Based) 
Date: Tue, 15 Jan 2008 15:56:20 +0530
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0021_01C8578F.2BBEE610"
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

------=_NextPart_000_0021_01C8578F.2BBEE610
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I want to configure linux kernel for USB Mass Storage device (PCI =
Based).In that i have few doubts. Can u pls calrify it.

Hardware=20
---------------
 MPC8560 (PCI Host  Mode )
 MPC8540 (PCI Agent Mode )
 ISP1564 (PCI Target - USB Host Controller)

Software=20
---------------
 Uboot 1.1.2
 Linux Kernel 2.4.10

Problem=20
--------------

 I am using default pci & usb driver given in uboot and linux kernel.

 In my board both MPC8560 (PCI Host), MPC8540 (PCI Agent) should access =
the ISP1564 USB host controller (PCI Target). All the three PCI devices =
connected in a single pci bus.

 My problem is when i load uboot (with PCI Config) and kernel (with =
PCI,USB-EHCI,USB Mass storage Config) in MPC8560. Its working properly.

 After MPC8560 booted , when i try to load uboot (with PCI support =
disabled) and kernel (with PCI,USB-EHCI,USB Mass storage Config).=20

The mass storage is not working in  MPC8540 . But its working in =
MPC8560.

 Few oberservation while testing :

  1. When i enable PCI support in MPC8540 uboot and not booting kernel. =
The usb mass storage not working in MPC8560 kernel.
  2. When i disable PCI support in MPC8540 uboot and not booting =
kernel(even if i boot kernel also). The usb mass storage working in =
MPC8560 kernel.
  3. In both the case /proc/bus/pci and /proc/pci not created in  =
MPC8540 kernel.( Note : I have enabled the option of proc file system , =
virtual file system support in MPC8540 kernel).

Questions=20
---------------

 1. By the above problem defintion can u able to guess . Wht would be =
the problem ???
 2. Why proc entry for pci is not created in MPC8540 kernel ??? . =
Whether PCI agent mode has any impact on it.??
 3. Whether any special changes required in pci uboot/kernel driver of =
MPC8540. Since PCI of MPC8540 is in Agent Mode.
 4. Whether any special changes required in USB kernel driver of =
MPC8540. Since PCI of MPC8540 is in Agent Mode.=20


Thanks in Advance
=20
Regards
Haroun Ansari=20


------=_NextPart_000_0021_01C8578F.2BBEE610
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.6000.16587" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi,</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I want to configure linux kernel for =
USB Mass=20
Storage device (PCI Based).In that i have few doubts. Can u pls calrify=20
it.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><BR>Hardware </FONT></DIV>
<DIV><FONT face=3DArial size=3D2>---------------</DIV>
<DIV>&nbsp;MPC8560 (PCI Host&nbsp; Mode )<BR>&nbsp;MPC8540 (PCI Agent =
Mode=20
)<BR>&nbsp;ISP1564 (PCI Target - USB Host Controller)</DIV>
<DIV>&nbsp;</DIV>
<DIV>Software </DIV>
<DIV>---------------</DIV>
<DIV>&nbsp;Uboot 1.1.2<BR>&nbsp;Linux Kernel 2.4.10</DIV>
<DIV>&nbsp;</DIV>
<DIV>Problem&nbsp;</DIV>
<DIV>--------------</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;I am using default pci &amp; usb driver given in uboot and =
linux=20
kernel.</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;In my board both MPC8560 (PCI Host), MPC8540 (PCI Agent) =
should=20
access the ISP1564 USB host controller (PCI Target). All the three PCI =
devices=20
connected in a single pci bus.</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;My problem is when i load uboot (with PCI Config) and kernel =
(with=20
PCI,USB-EHCI,USB Mass storage Config) in MPC8560.&nbsp;Its working=20
properly.</DIV>
<DIV><BR>&nbsp;After MPC8560 booted , when i try to load uboot (with PCI =
support=20
disabled) and kernel (with PCI,USB-EHCI,USB Mass storage Config). </DIV>
<DIV>&nbsp;</DIV>
<DIV>The mass storage is not working in&nbsp; MPC8540 . But its working =
in=20
MPC8560.</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;Few oberservation while testing :</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;1. When i enable PCI support in MPC8540 uboot and not =
booting=20
kernel. The usb mass storage not working in MPC8560 =
kernel.<BR>&nbsp;&nbsp;2.=20
When i disable PCI support in MPC8540 uboot and not booting kernel(even =
if i=20
boot kernel also). The usb mass storage working in MPC8560=20
kernel.<BR>&nbsp;&nbsp;3. In both the case /proc/bus/pci and /proc/pci =
not=20
created in &nbsp;MPC8540 kernel.( Note : I have enabled the option of =
proc file=20
system , virtual file system support in MPC8540 kernel).</DIV>
<DIV><BR>Questions </DIV>
<DIV>---------------</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;1. By the above&nbsp;problem defintion can u able to guess . =
Wht=20
would be the problem ???<BR>&nbsp;2. Why proc entry for pci is not =
created in=20
MPC8540 kernel ??? . Whether PCI agent mode has any impact on =
it.??<BR>&nbsp;3.=20
Whether any special changes required in pci uboot/kernel driver of =
MPC8540.=20
Since PCI of MPC8540 is in Agent Mode.<BR>&nbsp;4. Whether any special =
changes=20
required in USB kernel driver of MPC8540. Since PCI of MPC8540 is in =
Agent Mode.=20
</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanks in Advance</DIV>
<DIV>&nbsp;</DIV>
<DIV>Regards<BR>Haroun Ansari </DIV>
<DIV>&nbsp;</DIV>
<DIV></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0021_01C8578F.2BBEE610--
