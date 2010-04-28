Return-Path: <tglx@linutronix.de>
Date: Thu, 29 Apr 2010 00:28:00 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Guillaume Knispel <gknispel@proformatique.com>
Subject: Re: [PATCH 1/2] genirq: reliably replay pending edge-triggered irq
In-Reply-To: <20100428235657.7120edd9.gknispel@proformatique.com>
Message-ID: <alpine.LFD.2.00.1004290027090.2951@localhost.localdomain>
References: <1271941798-9659-1-git-send-email-gknispel@proformatique.com>
	<1271941798-9659-2-git-send-email-gknispel@proformatique.com>
	<alpine.LFD.2.00.1004271537130.2951@localhost.localdomain>
	<20100428235657.7120edd9.gknispel@proformatique.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Lars-Peter Clausen <lars@metafoo.de>, Russell King <linux@arm.linux.org.uk>,
	Haavard Skinnemoen <hskinnemoen@atmel.com>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Michael Buesch <mb@bu3sch.de>, Ingo Molnar <mingo@elte.hu>,
	Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 28 Apr 2010, Guillaume Knispel wrote:

> On Tue, 27 Apr 2010 15:42:11 +0200 (CEST)
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > On Thu, 22 Apr 2010, Guillaume Knispel wrote:
> [snip] 
> > > acked and masked at controller level and IRQ_PENDING is set.
> > > ---
> > >  arch/arm/Kconfig                                   |    4 ----
> > >  arch/arm/configs/acs5k_defconfig                   |    1 -
> > >  arch/arm/configs/acs5k_tiny_defconfig              |    1 -
> > 
> >    Changing the defconfigs should be a separate patch and I'm not
> >    going to push such a thing through the genirq tree. The stale
> >    entries do not hurt.
> 
> Ok
> In this separate patch, to I put "genirq" in the title?
> Do I put it in the same series?

Just keep them out for now and send them to the arch maintainers once
the change hits linus tree.

Thanks,

	tglx
