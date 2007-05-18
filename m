Return-Path: <Leonid@a-k-a.net>
Received: from mis011-1.exch011.intermedia.net
	(mis011-1.exch011.intermedia.net [64.78.21.128])
	by ozlabs.org (Postfix) with ESMTP id C3503DDF3F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 May 2007 02:54:18 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: BDI2000 configuration file for MPC8313E-RDB
Date: Fri, 18 May 2007 09:54:12 -0700
Message-ID: <406A31B117F2734987636D6CCC93EE3C017BA668@ehost011-3.exch011.intermedia.net>
In-Reply-To: <29DC34A6B43468409F5A371CFE34E84917683B@ex01.ads.ubidyne.de>
References: <29DC34A6B43468409F5A371CFE34E84917683B@ex01.ads.ubidyne.de>
From: "Leonid" <Leonid@a-k-a.net>
To: "Frank Prepelica" <Frank.Prepelica@ubidyne.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday, May 17, 2007 11:00 PM Frank Prepelica wrote:
> Hi Leonid,
> firstly, thanks for reply!

You are very welcome.

> But, are you sure that I cannot access NAND memory via=20
> BDI2000?=20

In the first place, let me quote Ruedi Dummermuth from Abatron, BDI2000
vendor:

> > Leonid asked:
> > And here most important question comes: for our actual HW we are
going=20
> > to use ST-Micro NAND flash, one of NAND512-B, NAND01G-B, NAND02G-B,=20
> > NAND04G-B and NAND08G-B. Is BDI2000 capable of programming these=20
> > flashes? What changes in .cfg file are required?

> Sorry, but the BDI does not support programming any NAND flash.
> You can write your own driver. Then load the data and the driver into=20
> SDRAM via the BDI and execute it.

This passage also has a suggestion how you can use BDI2000 to program
NAND indirectly: load NAND-capable software to RAM.

> Because I used BDI2000 with the MPC8343M Board=20
> and there is "only" 64MB NAND memory. Thus I stored the=20
> U-Boot (image was broken) into the flash memory.

I'm afraid I didn't understand you. Are you saying that you actually
were able to program NAND using BDI2000? I would like to know how you
achieved that. I suspect that was some kind of "indirect" procedure,
Ruedi wrote about, but please provide details.

See, it's not a question that BDI2000 can be used with board which has
NAND flash on it, just it's not capable of NAND direct programming as it
does in the case of NOR flash.

I also have AMCC Sequoia board with both NOR and NAND flash. On this
board you can boot u-boot from NOR first and use it to program NAND.

Regards,

Leonid.
