Return-Path: <markc@mail.com>
Received: from relay01.roc.ny.frontiernet.net (relay01.roc.ny.frontiernet.net
	[66.133.131.34]) by ozlabs.org (Postfix) with ESMTP id E611067ACD
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Feb 2005 07:00:17 +1100 (EST)
Message-ID: <002501c50ee2$852b4390$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: <linuxppc-embedded@ozlabs.org>,
	"Eric N. Johnson (ACD)" <ejohnson@acdstar.com>
References: <6.2.1.2.1.20050209131409.02b2b718@mail.int.acdstar.com>
Date: Wed, 9 Feb 2005 15:04:05 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: MPC5200 JTAG/BDM Flash Burning
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



> I'm working on a custom MPC5200 board based heavily on the IceCube design
> from Motorola/Freescale.  We plan to use the u-boot bootloader.
>

I'm doing the same.

> I'm looking for a tool to allow us to burn u-boot into the flash memory on
> new board (with all flash devices unprogrammed).  Ideally, I'd like
> something like the Jflash-linux tool used with StrongARM linux, or a
> stand-along linux tool that lets us burn the memory.
>

The BDI2000 from abatron, which in the US you probably want to get
from  www.ultsol.com (send my commision to...).  The difference between
the BDI product and others that my have similar spec sheets is that it
actually works, including the flash burning portions.

Once you have u-boot and/or the kernel up you can use them to update
flash.

> Both the "MPCBDM" and "bdm4gdb" projects haven't been updated for
> years.  The BDM-Tools project is more active, but only seems to support
> 68k/Coldfire processors.
>

As I understand it, Freescale has not publicly released the OCD interface
so that's why it's not supported in the open source community.

> The 5200lite "IceCube" demo board came with a Metrowerks "Wiretap" BDM
> interface, and a Green Hills "Slingshot" BDM module, but these seems to
> require a large (and expensive) windows based "Development environment"
> which is far more than we need.  Are there linux based drivers for either
> of these?
>

You could also look at magraigor.com.  I had problems with their 5200 device
but they've probably got them worked out by now.

Mark Chambers

P.S. Love the way you play the guitar!
