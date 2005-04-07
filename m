Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by ozlabs.org (Postfix) with ESMTP id 3AEA367A2E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Apr 2005 03:20:10 +1000 (EST)
Date: Thu, 7 Apr 2005 10:20:03 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrei Konovalov <akonovalov@ru.mvista.com>
Message-ID: <20050407172003.GP3396@smtp.west.cox.net>
References: <424ACFF1.5000403@bitsim.se>
	<111d2ae873d1bfee413409dfc4f2f064@freescale.com>
	<424BEDFC.8080300@jonmasters.org>
	<1112284541.23088.77.camel@cashmere.sps.mot.com>
	<4250EACF.1040403@bitsim.se> <42511D55.4040507@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42511D55.4040507@ru.mvista.com>
Cc: Jon Masters <jonathan@jonmasters.org>, Sylvain Munaut <tnt@246tNt.com>,
	Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>,
	Jakob Viketoft <jakob.viketoft@bitsim.se>
Subject: Re: Flat OF Device Tree for ppc32 [was: Platform bus/ppc sys
	model...]
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Apr 04, 2005 at 02:56:21PM +0400, Andrei Konovalov wrote:

> Should we rely on U-Boot to give that device tree structure to
> the kernel? If I got it correct this is how the Freescale team

It shouldn't matter who passes the flattened tree really, so long as the
information is correct.  arch/ppc/boot/simple/ should translate
older-non-uboot-bd_t, or PReP residual, or statically construct, or
some combination, into the tree and pass it in.  U-Boot (or yaboot or
grub or whatever) can just pass it right to the kernel.

Part of the point of this is to move to a defined interface :)

-- 
Tom Rini
http://gate.crashing.org/~trini/
