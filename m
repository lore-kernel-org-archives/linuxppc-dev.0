Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp7.wanadoo.fr (smtp7.wanadoo.fr [193.252.22.24])
	by ozlabs.org (Postfix) with ESMTP id 422AB67A6E
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  6 Mar 2005 06:39:22 +1100 (EST)
Date: Sat, 5 Mar 2005 20:27:52 +0100
To: Dale Farnsworth <dale@farnsworth.org>
Message-ID: <20050305192752.GA28491@pegasos>
References: <41F6E0E1.6000803@mvista.com> <20050224082508.GA30005@pegasos>
	<421DF2B8.6040007@mvista.com> <20050224160411.GA11197@pegasos>
	<20050224172420.GA6932@xyzzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20050224172420.GA6932@xyzzy>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: Nicolas DET <det.nicolas@free.fr>, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH][PPC32] mv64x60 updates
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Feb 24, 2005 at 10:24:20AM -0700, Dale Farnsworth wrote:
> On Thu, Feb 24, 2005 at 04:04:11PM +0000, Sven Luther wrote:
> > > >I am a bit bewildered by what you are doing here. How does this mv64x60 
> > > >code relate to the mv643xx_eth driver from the mips folk ? 
> > 
> > [...]
> > 
> > On Thu, Feb 24, 2005 at 08:28:56AM -0700, Mark A. Greer wrote:
> > > has spent a lot of time making it work on both MIPS and PPC.  The code 
> > > you see in the mv64x60.c file is a part of that.  I believe that Dale's 
> > 
> > Ok, so the code in question is in addition to the existing driver from the
> > mips guys and works with it ? I had the impression that it was a separate
> > driver development or something.
> 
> The code in mv64x60.c is related to but separate from the ethernet driver.
> It is platform-specific code that passes register addresses, irqs,
> mac addrs, phy addrs, etc. to the arch-agnostic ethernet driver.
> 
> All of my changes to the mv643xx ethernet driver have been posted to
> LKML or the netdev list.  I have removed all arch-specific code from
> the ethernet driver itself.

What is the status of this with regard to the 2.6.11 mainline kernel ?

> > Ok. Do you know if Dale's patches are available separatedly while they are not
> > yet in mainline, so Nicolas Det can work on them and make sure they also work
> > on the Pegasos board, which is not an embedded board but from the chrp
> 
> See bk://dfarnsworth.bkbits.net/linux-2.5-mv643xx-enet

I guess i need to look there, as in mainline 2.6.11, there doesn't seem to be
direct related code between the ppc specific mv64x60 stuff, and the mips
related ethernet one.

> > lineage. Nicolas already did some mv643xx ethernet driver work last summer,
> > but apparently had trouble integrating this in the mainline kernel, and it
> 
> I'm sorry I wasn't aware of Nicolas' work on the driver.
> 
> > seems his work has now been redone by Dale or something. Do you know who the
> > right person to communicate with about this would be ? The MIPS folk didn't
> > reply to any of our mails about this subject.
> 
> Sounds familiar.  Fortunately, Jeff Garzik picked up my changes.
> I would appreciate feedback from you or Nicolas on the current driver.

Well, as i am doing the powerpc debian 2.6.11 kernel, i really would like to
port your work to the pegasos, but what i have seen from the code in the
mainline kernel doesn't really make sense.

Friendly,

Sven Luther
