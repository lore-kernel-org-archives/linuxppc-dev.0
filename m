Date: Thu, 17 Jun 2004 11:57:24 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Leigh Brown <leigh@solinno.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [RFC][PATCH 3/9] Support for old IBM PReP boxes
Message-ID: <20040617185724.GB811@smtp.west.cox.net>
References: <1831.80.7.99.14.1086886556.squirrel@www.solinno.co.uk> <20040617161616.GK24479@smtp.west.cox.net> <1618.80.7.99.14.1087489756.squirrel@www.solinno.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1618.80.7.99.14.1087489756.squirrel@www.solinno.co.uk>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jun 17, 2004 at 05:29:16PM +0100, Leigh Brown wrote:

>
> Tom Rini said:
> > On Thu, Jun 10, 2004 at 05:55:56PM +0100, Leigh Brown wrote:
> >
> >>
> >> This patch adds a function residual_pcidev_irq() which finds out
> >> from the residual data which IRQ the given PCI device should use.
> >> The interesting part about this patch is the changes I made to
> >> prep_pcibios_fixup().  The old code was more than a little
> >> opaque so I tried to change it to make it a bit clearer.  I'd
> >> definitely be pleased if someone could cast their eyes over
> >> that bit.
> >
> > Is this jsut a "Residual Data is Good" type change, or does it fix some
> > set of IBM machines?  I ask since residual data on Motorola PRePs can be
> > incorrect, iirc.
>
> The idea is that we can support machines we don't know about, assuming
> their residual data is correct.  IMO it is better to use the residual
> data where possible, then add code for those machines that have broken
> residual data.
>
> In my experience, the only IBM PReP machines I know that have broken
> residual data are the 6020 and 6030 laptops.  I'm planning on adding
> code to work around their brokeness when I get a chance.

How soon until you might have some sort of code to handle a list of
machines to blacklist residual information on?  If we could do that, and
then use something like that then ignore the bad residual data on Mot
preps, I'd be happier with the first change here.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
