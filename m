Return-Path: <jwboyer@linux.vnet.ibm.com>
Date: Wed, 12 Dec 2007 06:54:37 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: subrata@linux.vnet.ibm.com
Subject: Re: Lnux 2.6.24-rc5
Message-ID: <20071212065437.73e708ef@weaponx>
In-Reply-To: <1197453301.4710.71.camel@subratamodak.linux.ibm.com>
References: <alpine.LFD.0.9999.0712102130370.28293@woody.linux-foundation.org>
	<1197453301.4710.71.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 12 Dec 2007 15:25:01 +0530
Subrata Modak <subrata@linux.vnet.ibm.com> wrote:

> On Mon, 2007-12-10 at 21:40 -0800, Linus Torvalds wrote:
> > It's been a week, and I promised to be a good boy and try to follow my 
> > release rules, so here is the next -rc.
> > 
> > Things _have_ slowed down, although I'd obviously be lying if I said we've 
> > got all the regressions handled and under control. They are being worked 
> > on, and the list is shrinking, but at a guess, we're definitely not going 
> > to have a final 2.6.24 out before xmas unless santa puts some more elves 
> > to work on those regressions..
> > 
> > So any elves out there - please keep working.
> > 
> > I'm including the shortlog since it's small enough, and quite frankly, 
> > gives about as readable explanation of the changes as can be imagined. 
> > Nothing hugely exciting here.
> > 
> > I'd post the diffstat too, but it's not really all that interesting, and 
> > it only highlights a textually big PA-RISC revert, and the powerpc 
> > defconfig updates. And the Blackfin SPI driver. The rest is largely random 
> > noise in various subsystems (drivers/net, xfs filesystem, and arch updates 
> > are some of the areas that show more changes).
> > 
> > 		Linus
> > 
> > ---
> > 
> > Benjamin Herrenschmidt (6):
> >       ibm_newemac: Fix ZMII refcounting bug
> >       ibm_newemac: Workaround reset timeout when no link
> >       ibm_newemac: Cleanup/Fix RGMII MDIO support detection
> >       ibm_newemac: Cleanup/fix support for STACR register variants
> >       ibm_newemac: Update file headers copyright notices
> >       powerpc: Fix IDE legacy vs. native fixups
> > 
> 
> Dear Benjamin,
> 
> Since you are working on Device drivers, do you want to see whether your
> Device drivers testcases can fit in here in LTP:
> http://ltp.cvs.sourceforge.net/ltp/ltp/testcases/kernel/device-drivers/,

There are no testcases for the EMAC drivers per se.  Also, I don't see
any testcases for any network driver in there at all.  Is that not
something LTP is testing yet?

josh
