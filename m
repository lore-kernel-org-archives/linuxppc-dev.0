Date: Fri, 16 Mar 2001 10:46:13 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Stefano Coluccini <s.coluccini@caen.it>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Sym53c875 problem with last 2_5 updates
Message-ID: <20010316104613.G872@opus.bloom.county>
References: <20010316081831.D872@opus.bloom.county> <NDBBIFIMCKPOADMAJOKMOECJDAAA.s.coluccini@caen.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <NDBBIFIMCKPOADMAJOKMOECJDAAA.s.coluccini@caen.it>; from s.coluccini@caen.it on Fri, Mar 16, 2001 at 06:22:04PM +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Mar 16, 2001 at 06:22:04PM +0100, Stefano Coluccini wrote:
>
> > On Fri, Mar 16, 2001 at 09:38:47AM +0100, Stefano Coluccini wrote:
> >
> > >   few days ago (I don't remember the exact date) I have
> > resynced my local
> > > repository of 2_5 and today I have recompiled a kernel. While before the
> > > updates my sym53c875 based board had always worked fine, now the driver
> > > unsuccesfully try to download script on the chip continually. I
> > have seen
> > > that the sym53c8xx.c file is changed, in fact I have correct the problem
> > > replacing the new file with the old.
> > > I have not found any mention of sym53c8xx.c change in the changesets at
> > > http://www.bitmover.com:8888//home/ppc/linuxppc_2_5 so I have
> > thinked it can
> > > be an erroneous update ... it is possible ?
> >
> > It got updated when I updated 2_5 with some of the changes from 2_4.  What
> > machine is this?
>
> My machine is a Motorola MVME5100 with a PMC150-K mezzanine card based on
> the sym53c875 chip.
>
> >  Search the linuxppc-dev list, as Geert had this same problem
> > on his LongTrail.
>
> Yes, Geert had the same problem, but following the thread it seems to me
> that     it is still unsolved, or I have not understand ?
> I have not the necessary skill on SCSI to find and patch the problem, but
> the developer(s) working on that can use me as tester or other.

The problem is actually w/ PCI resources, if I remember it correctly.
It's a problem in phys_to_bus, or so Geert determined.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
