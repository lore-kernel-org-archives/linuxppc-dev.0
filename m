Return-Path: <trini@kernel.crashing.org>
Date: Mon, 22 May 2006 15:22:27 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [HACK] add sandpoint + flattened dt support to arch/powerpc/boot
Message-ID: <20060522222227.GR32112@smtp.west.cox.net>
References: <20060518002142.GA23182@mag.az.mvista.com>
	<1147960021.7607.5.camel@localhost.localdomain>
	<20060519003730.GA7338@mag.az.mvista.com>
	<1147999765.8515.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1147999765.8515.6.camel@localhost.localdomain>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 19, 2006 at 10:49:25AM +1000, Michael Ellerman wrote:
> On Thu, 2006-05-18 at 17:37 -0700, Mark A. Greer wrote:
> > On Thu, May 18, 2006 at 08:47:01AM -0500, Matthew McClintock wrote:
> > > On Wed, 2006-05-17 at 17:21 -0700, Mark A. Greer wrote:
> > > > +void *
> > > > +dt_find_prop_by_name(void *dt_blob, char *full_name, u32 *val_sizep) 
> > > 
> > > Is there a reason you are not using of_get_flat_dt_prop() instead of
> > > implementing your own version?
> > 
> > Yes.  One is in the kernel, one isn't.  Or, are you asking why I didn't
> > just copy the kernel code?  If so, I probably should have.
> > 
> > Hrm, we almost need a library of code shared between the kernel &
> > the bootwrapper.  Sort of illegal but it would save duplicating code
> > like the flat dt code.
> > 
> > Comments?
> 
> Yeah we do. And it's not illegal IMHO as two of our boot wrappers
> (prom_init and the iSeries one) are linked with the kernel anyway.

And on all architectures (practically) the zlib inflate code is shared
between kernel and bootstuff.  So it's not unprecidented to do the ugly
define abstractions to let you easily share code as needed.

-- 
Tom Rini
