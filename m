Return-Path: <ejohnson@acdstar.com>
Received: from mail.acdstar.com (mail.acdstar.com [209.98.244.9])
	by ozlabs.org (Postfix) with ESMTP id C016E67A6D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Feb 2005 06:43:36 +1100 (EST)
Received: from zaphod.acdstar.com (zaphod.int.acdstar.com [192.168.2.100])
	by mail.acdstar.com (8.13.0/8.13.0) with ESMTP id j19JWvqY020515
	for <linuxppc-embedded@ozlabs.org>; Wed, 9 Feb 2005 13:32:57 -0600
Message-Id: <6.2.1.2.1.20050209131409.02b2b718@mail.int.acdstar.com>
Date: Wed, 09 Feb 2005 13:31:35 -0600
To: linuxppc-embedded@ozlabs.org
From: "Eric N. Johnson (ACD)" <ejohnson@acdstar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Subject: MPC5200 JTAG/BDM Flash Burning
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm working on a custom MPC5200 board based heavily on the IceCube design 
from Motorola/Freescale.  We plan to use the u-boot bootloader.

I'm looking for a tool to allow us to burn u-boot into the flash memory on 
new board (with all flash devices unprogrammed).  Ideally, I'd like 
something like the Jflash-linux tool used with StrongARM linux, or a 
stand-along linux tool that lets us burn the memory.

Both the "MPCBDM" and "bdm4gdb" projects haven't been updated for 
years.  The BDM-Tools project is more active, but only seems to support 
68k/Coldfire processors.

The 5200lite "IceCube" demo board came with a Metrowerks "Wiretap" BDM 
interface, and a Green Hills "Slingshot" BDM module, but these seems to 
require a large (and expensive) windows based "Development environment" 
which is far more than we need.  Are there linux based drivers for either 
of these?

We may have to write our own JTAG based pin-wiggler, but this solution 
tends to be extremely slow.

Thanks
Eric
------------------------------------
Eric Johnson, Electrical Engineer
Advanced Communication Design
   7901 12th Avenue South
   Bloomington, MN 55425
Ph: 952-854-4000  Fax: 952-854-5774
