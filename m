From: Gabriel Paubert <paubert@iram.es>
Date: Fri, 18 Jun 2004 00:36:26 +0200
To: Tom Rini <trini@kernel.crashing.org>
Cc: Leigh Brown <leigh@solinno.co.uk>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: [RFC][PATCH 3/9] Support for old IBM PReP boxes
Message-ID: <20040617223626.GB21217@iram.es>
References: <1831.80.7.99.14.1086886556.squirrel@www.solinno.co.uk> <20040617161616.GK24479@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040617161616.GK24479@smtp.west.cox.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jun 17, 2004 at 09:16:16AM -0700, Tom Rini wrote:
>
> On Thu, Jun 10, 2004 at 05:55:56PM +0100, Leigh Brown wrote:
>
> >
> > This patch adds a function residual_pcidev_irq() which finds out
> > from the residual data which IRQ the given PCI device should use.
> > The interesting part about this patch is the changes I made to
> > prep_pcibios_fixup().  The old code was more than a little
> > opaque so I tried to change it to make it a bit clearer.  I'd
> > definitely be pleased if someone could cast their eyes over
> > that bit.
>
> Is this jsut a "Residual Data is Good" type change, or does it fix some
> set of IBM machines?  I ask since residual data on Motorola PRePs can be
> incorrect, iirc.

On my PreP machines (well PowerPlus since they are actually
Raven/Falcon or Hawk based), the residual data for interrupt
routing is correct, but some people insisted in writing code
without having read the spec, and refused mine which correctly
decoded this information :-(

BTW: I believe that we should really merge PPlus, MVME5100 and PreP,
they are really minor variants (and on my MVME2[467]xx machine which
boot as PreP, I reprogram the Raven/Hawk so that they look more like
CHRP because I need a very large PCI address space, but 1GB of I/O
space is stupid.

For now I'm still running 2.2 with an 1999 distribution (machines
are not visible from the internet so security is not that
critical). I plan some upgrade but don't hold your breath since
I first have to finish 2 (or 3 or 4) microwave hardware projects.

	Regards,
	Gabriel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
