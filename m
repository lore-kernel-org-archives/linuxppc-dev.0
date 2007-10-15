Return-Path: <domen.puncer@telargo.com>
Received: from kukmak.uni-mb.si (kukmak.uni-mb.si [164.8.100.3])
	by ozlabs.org (Postfix) with ESMTP id 43B2CDDE22
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 15:16:43 +1000 (EST)
Date: Mon, 15 Oct 2007 07:16:31 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] clk for mpc52xx: use psc_mclk's in spi driver
Message-ID: <20071015051631.GL3000@nd47.coderock.org>
References: <20071014080813.GH3000@nd47.coderock.org>
	<20071014081027.GJ3000@nd47.coderock.org>
	<fa686aa40710141542w552eacet7ba13e8e251e2285@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <fa686aa40710141542w552eacet7ba13e8e251e2285@mail.gmail.com>
Cc: david-b@pacbell.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 14/10/07 16:42 -0600, Grant Likely wrote:
> On 10/14/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> > Use clocks subsystem in spi driver.
> 
> I don't understand the advantage of this approach.  Is the current code broken?

Actually the calculations are broken. But ok, fix doesn't need to be like this.

And it wasn't my idea to use clk.h :-)
http://patchwork.ozlabs.org/linuxppc-embedded/patch?id=11186

> 
> I agree that abstraction is good; but in this case it seems these two
> patches add a lot of code for a very simple calculation.  Also, there
> is exactly 2 chips that use these devices, the mpc5200 and the
> mpc5200b, and they are both wired up in exactly the same way.  I'm
> inclined to believe that splitting of reading of the CDM into a
> separate driver (or at least using the clk infrastructure) is over the
> edge of diminishing returns.  However, I could be convinced that
> having a utility function for setting the PSC clock rate is a useful
> thing, but until arch/ppc goes away, you should support it in both
> arch/ppc and arch/powerpc.
> 
> Cheers,
> g.
> 
> -- 
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
> grant.likely@secretlab.ca
> (403) 399-0195

-- 
Domen Puncer | Research & Development
.............................................................................................
Telargo d.o.o. | Zagrebška cesta 20 | 2000 Maribor | Slovenia
.............................................................................................
www.telargo.com
