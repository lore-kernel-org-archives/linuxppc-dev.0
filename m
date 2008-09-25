Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E83AADDF6C
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Sep 2008 02:43:56 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m8PGhnCx001369
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 09:43:49 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m8PGhngQ016628
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 11:43:49 -0500 (CDT)
Date: Thu, 25 Sep 2008 11:43:48 -0500
From: Scott Wood <scottwood@freescale.com>
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH v2] powerpc: implement support for MPC8349-compatible SOC
	GPIOs
Message-ID: <20080925164348.GB4435@ld0162-tx32.am.freescale.net>
References: <20080917175820.GA22539@oksana.dev.rtsoft.ru>
	<871vziwoxj.fsf@macbook.be.48ers.dk>
	<20080918112020.GA11584@oksana.dev.rtsoft.ru>
	<87ej3gyxv0.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87ej3gyxv0.fsf@macbook.be.48ers.dk>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 19, 2008 at 05:11:15PM +0200, Peter Korsgaard wrote:
>  Anton> This is purposely. We also need support for 8610, and maybe
>  Anton> later we'll find another chip with the same unit. So, to not touch
>  Anton> the Kconfig for every new chip I just made it PPC32-wide. Other
>  Anton> option is to depend on FSL_SOC, but the driver really does not
>  Anton> depend on any fsl_soc stuff...
> 
> Adding another symbol to the Kconfig once it is verified that a new
> SoC is compatible doesn't seem like a big deal - Figuring out all the
> knobs we already have is, without having options for stuff that is
> known to be irrelevant for the SoC.

I agree with Anton; it's a lot less of a headache to say "no" to
some unfamiliar kconfig option than it is to hunt around and figure out
why you're not being given the option.  I'd be OK with depending on
FSL_SOC.

> The other 83xx specific drivers also depend on PPC_83xx.

As pointed out above, this isn't 83xx-specific.

-Scott
