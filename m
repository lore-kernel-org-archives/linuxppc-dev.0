Return-Path: <sr@denx.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.188])
	by ozlabs.org (Postfix) with ESMTP id 0731ADDEE0
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 May 2007 05:04:22 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: BDI2000 configuration file for MPC8313E-RDB
Date: Fri, 18 May 2007 21:04:09 +0200
References: <29DC34A6B43468409F5A371CFE34E84917683B@ex01.ads.ubidyne.de>
	<406A31B117F2734987636D6CCC93EE3C017BA668@ehost011-3.exch011.intermedia.net>
In-Reply-To: <406A31B117F2734987636D6CCC93EE3C017BA668@ehost011-3.exch011.intermedia.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705182104.09993.sr@denx.de>
Cc: Leonid <Leonid@a-k-a.net>, Frank Prepelica <Frank.Prepelica@ubidyne.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday 18 May 2007, Leonid wrote:
> See, it's not a question that BDI2000 can be used with board which has
> NAND flash on it, just it's not capable of NAND direct programming as it
> does in the case of NOR flash.

Yes, "direct" NAND programming via BDI2000 is not possible. At least not at 
the moment with the current firmware versions.

> I also have AMCC Sequoia board with both NOR and NAND flash. On this
> board you can boot u-boot from NOR first and use it to program NAND.

Correct.

Just a side note: You can also boot the Sequoia from NAND directly if you have 
programmed the NAND U-Boot version for the Sequoia, as the 440EP(x) supports 
direct NAND booting.

Best regards,
Stefan
