Return-Path: <dgibson@ozlabs.org>
Date: Tue, 18 Dec 2007 11:43:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 1/3] 8xx: Analogue & Micro Adder875 board support.
Message-ID: <20071218004329.GB9489@localhost.localdomain>
References: <20071212225427.GA19027@loki.buserror.net>
	<20071217035706.GA3262@localhost.localdomain>
	<47669285.8010707@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47669285.8010707@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 17, 2007 at 09:15:17AM -0600, Scott Wood wrote:
> David Gibson wrote:
> > On Wed, Dec 12, 2007 at 04:54:27PM -0600, Scott Wood wrote:
> >> Signed-off-by: Scott Wood <scottwood@freescale.com>
> > [snip]
> >> diff --git a/arch/powerpc/boot/dts/adder875-redboot.dts b/arch/powerpc/boot/dts/adder875-redboot.dts
> >> new file mode 100644
> >> index 0000000..4d28220
> >> --- /dev/null
> >> +++ b/arch/powerpc/boot/dts/adder875-redboot.dts
> > [snip]
> >> diff --git a/arch/powerpc/boot/dts/adder875-uboot.dts b/arch/powerpc/boot/dts/adder875-uboot.dts
> >> new file mode 100644
> >> index 0000000..33d198c
> >> --- /dev/null
> >> +++ b/arch/powerpc/boot/dts/adder875-uboot.dts
> > 
> > Having two different device trees for the different firmwares is
> > pretty yucky, and could be a pain in the bum for synchronization of
> > fixes.
> 
> Yes, that's why we need some sort of macro/template facility in dtc. :-)
> 
> > Can't you have a common tree, and just poke the places that
> > are differently configured by the two firmwares from the bootwrapper.
> 
> Enh.  That can get icky as well, and the bootwrapper isn't necessarily 
> even used for u-boot, and I'd rather not require it be used just for this.

So make the template in the u-boot form, and poke it as necessary from
the redboot wrapper.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
