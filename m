Date: Sat, 19 Jun 2004 16:16:02 +0200
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Sven Luther <sven.luther@wanadoo.fr>,
	Alan Cox <alan@www.pagan.org.uk>, Nicolas DET <nd@bplan-gmbh.de>,
	Linux-USB <linux-usb-devel@lists.sourceforge.net>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [linux-usb-devel] [Patch] for UHCI driver (from kernel 2.6.6).
Message-ID: <20040619141602.GD18025@pegasos>
References: <1087595028.2061.295.camel@gaston> <Pine.LNX.4.44L0.0406190953120.19842-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <Pine.LNX.4.44L0.0406190953120.19842-100000@netrider.rowland.org>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Jun 19, 2004 at 09:59:53AM -0400, Alan Stern wrote:
> On Fri, 18 Jun 2004, Benjamin Herrenschmidt wrote:
>
> > > I recently changed a few mb() calls to wmb(), because they only protected
> > > data the CPU was writing to be read by the device.  Do you think changing
> > > all the wmb()'s back to mb()'s would make a difference?
> > >
> > > (Actually it seems likely that this is _not_ directly related to the
> > > original problem, but it might be important anyway.)
> >
> > Well, the problem on ppc is that the eieio done by wmb() (or implicitely
> > done by all writeX IO accessors) will only order stores in the same
> > domain. That is cacheable aren't ordered vs. non cacheables.
>
> I'm not familiar with the term "eieio"; can you explain it?

Enforced In-Order Execution of I/O. Page 8-61 of the Programing
Environments for 32-Bit Microprocessors, by motorola, well, at least on
my version.

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
