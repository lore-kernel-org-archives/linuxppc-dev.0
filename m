Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: David Jander <david.jander@protonic.nl>
To: "Frank Robbins" <Frank.Robbins@Analogue-Micro.com>
Subject: Re: Support for MPC852T, any experience ?
Date: Thu, 19 Jun 2003 11:06:38 +0200
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <200306171314.50574.david.jander@protonic.nl> <00e801c33593$37971a20$9c0ca8c0@analogue.domain>
In-Reply-To: <00e801c33593$37971a20$9c0ca8c0@analogue.domain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200306191106.39116.david.jander@protonic.nl>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wednesday 18 June 2003 14:14, Frank Robbins wrote:
> Yes we have designed a board  Adder II  + the ppc-linux-kernel-2.4.21p7-1
> kernel is in the development tree

Great ! Have you had much trouble making all the hardware work, or do all the
existing drivers in arch/ppc/8xx_io work out of the box ?
We plan on using the FEC, SPI, SMC as RS232 port, SCC3 and SCC4 as aditional
RS232/485 serial ports or second ethernet depending on the aplication.
Equiped with a MMC slot (for MMC's in SPI mode over the SPI interface),
16-64Mb SDRAM, 2-8Mb Flash (for kernel, bootloader, some basic rootfs, data
storage) and the applications mostly on a fs on MMC.

> What help do you need ?

We are just starting development, and I was looking for some experience with
some or all of the elements I mention above. Some warnings about things to
avoid from the beginning, possible pitfalls, etc...
Right now we are in the middle of component choices and basic schematic design
of the CPU board.
I am specially interested in hearing about experience with using a filesystem
on a MMC via the SPI interface.

> You could just by the board it has every thing and is priced fairly
> agreeable....?

I looked at your web-page, and the little board looks quite interesting as a
testbed for starting software development and debugging before we actually
have some hadware, but we are not in such a hurry, and in the end we will
have our own hardware and the other board might just end up collecting dust
somewhere, and that would be a shame.... thank you for the offer anyway.

Greetings,

--
David Jander
Protonic Holland.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
