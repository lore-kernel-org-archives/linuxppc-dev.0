Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Fri, 17 Jan 2003 14:58:53 +0100
From: BREUVART Jean-Charles <jean-charles.breuvart@airbus.com>
Subject: building lilo, grub or PPCBoot for a custom board
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Message-id: <36EB27C27D93D4119DE500508BDF85B30B2D7178@TOCOMEXC03>
MIME-version: 1.0
Content-type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi !

I' succedded in building denx-eldk from rpm packages on my RedHat 8.0
(thanks wolfgang !), and then a 1st linux kernel that I'd like to download
via the VME into the FLash ROM.

So I'm trying to build a cute boot loader (for linux of course !) for my
custom board :

 - VME64x based
 - PCC755 without L2 cache
 - no PCI bus
 - 2Mo Flash 29DL163 at 0xFFE00000
 - 128 Mo SDRAM at 0x0000000
 - a simple UART
 - some analog I/Os

the UART, VME and Flash drivers source code is ok, but I still have somme
questions :

 - where and how to introduce the arch dependent source code in the source
tree of those boot loaders ?
 - how to configure the Makefile to build a light exe ?
 - how to configure the linker command file or ld swithes for a particular
mapping ?

Thanks,

Regards, JC.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
