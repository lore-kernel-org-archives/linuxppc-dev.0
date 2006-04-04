Return-Path: <galak@kernel.crashing.org>
Date: Mon, 3 Apr 2006 23:27:39 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH] Add 85xx CDS to arch/powerpc 
In-Reply-To: <E1FQBs8-00061K-BI@jdl.com>
Message-ID: <Pine.LNX.4.44.0604032326320.9767-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2 Apr 2006, Jon Loeliger wrote:

> So, like, the other day Arnd Bergmann mumbled:
> > [MPIC]
> > 
> > Shouldn't all this come from the device tree?
> > 
> > ...
> >
> > > +/* PCI interrupt controller */
> > > +#define PIRQ0A			MPC85xx_IRQ_EXT0
> > > +#define PIRQ0B			MPC85xx_IRQ_EXT1
> > > +#define PIRQ0C			MPC85xx_IRQ_EXT2
> > > +#define PIRQ0D			MPC85xx_IRQ_EXT3
> > > +#define PIRQ1A			MPC85xx_IRQ_EXT11
> > 
> > And these as well, more importantly?
> 
> Yep.  In time they will.  However, the parsing of the
> PIC nodes hasn't been added to the 85xx (uh, nor 83xx)
> as of yet.
> 
> It is on "the list".
> 
> We should defer to Kumar to accepting these at this stage
> or not.

As Jon stated its on the list.  We need to work up something like what we 
have for parsing memory addresses for irqs.  Ben has some ideas, until 
then we make forward progress using the old style of things.

- k
