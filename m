Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC5xx now with MMU
Message-ID: <OF4942DBEA.BFBB1E47-ONC1256BB8.0028BB55@intern.matrix-vision.de>
From: "Werner Armingeon" <werner.armingeon@matrix-vision.de>
Date: Mon, 13 May 2002 19:51:44 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Yes, I keep an eye on the MGT5100 since its announcement. Since few days I
even have a board from Motorola with that most interesting MCU. It's
simply called "IceCube - MGT5100 Evaluation Board" and has all you need
for a nice embedded Linux system on chip/board:

- MGT5100 ( PPC603e core )
- 8MB Flash, 64 MB SDRAM
- ATA interface
- 3.3V PCI
- Serial Port, 2 x CAN, Ethernet 10/100, USB, I2C
- up to 44 GPIO

All controllers for the listed interfaces are integrated in the MCU. The
"IceCube" is shipped with an evaluation copy of CodeWarrior for Windows
:-( . No signs of Linux in the package, but a CodeWarrior shirt and a
multi-function tool instead ;-) .

I'm not very experienced regarding the Motorola integrated controllers
what means that I can't say anything about similarities to the peripherals
in the other PPC MCUs already supported by Linux. As usual the "MGT5100
User Manual" says nearly nothing about this point.

Are there any others interested on a MGT5100 Linux port or even working on
it?


  Werner Armingeon / werner.armingeon@matrix-vision.de


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
