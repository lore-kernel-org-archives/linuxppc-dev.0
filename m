Return-Path: <julia@diku.dk>
Date: Wed, 1 Sep 2010 18:05:45 +0200 (CEST)
From: Julia Lawall <julia@diku.dk>
To: Joe Perches <joe@perches.com>
Subject: Re: question about arch/powerpc/platforms/cell/celleb_scc_uhc.c
In-Reply-To: <1283356950.1797.159.camel@Joe-Laptop>
Message-ID: <Pine.LNX.4.64.1009011805320.32566@ask.diku.dk>
References: <Pine.LNX.4.64.1009011748050.32566@ask.diku.dk>
	<1283356950.1797.159.camel@Joe-Laptop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: cbe-oss-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 1 Sep 2010, Joe Perches wrote:

> On Wed, 2010-09-01 at 17:51 +0200, Julia Lawall wrote:
> > The file arch/powerpc/platforms/cell/celleb_scc_uhc.c contains the 
> > following function:
> > static inline int uhc_clkctrl_ready(u32 val)
> > {
> >         const u32 mask = SCC_UHC_USBCEN | SCC_UHC_USBCEN;
> >         return((val & mask) == mask);
> > }
> > The variable mask is a bit or of two identical constants.  Later in the 
> > same file in the function enable_scc_uhc, I see the code:
> > val |= (SCC_UHC_USBCEN | SCC_UHC_USBEN);
> > Should the code in uhc_clkctrl_ready also be SCC_UHC_USBCEN | SCC_UHC_USBEN?
> > Or something else?
> 
> Thanks Julia.
> 
> This was also noticed a couple of years ago and not applied
> http://lkml.indiana.edu/hypermail/linux/kernel/0808.2/1428.html
> 
> One day...

OK, thanks, I will send a patch shortly.

julia
