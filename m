Date: Wed, 7 Jun 2000 11:21:18 -0500 (CDT)
From: Seanano <sto9013@ksu.edu>
To: Bernhard Reiter <bernhard@intevation.de>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Powerbook hard freeze summary (sort of)
In-Reply-To: <20000608013517.A30902@freeonline.com.au>
Message-ID: <Pine.GSO.4.21L.0006071107400.2240-100000@unix1.cc.ksu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


  As I said before, I'm running a 400mhz lombard with 192 Megs of RAM
without any problems.  I've run multiple compiles at the same time for
upwards of an hour without any problem.  Let's sit back and examine this
for a minute.  So far I've seen maybe 4 reports of this problem.  Yet I
see a lot of peole on this list and the linuxppc-user list have lombards
and pismos matching the description for machines that may have this
problem that never report it.  It would seem that the problem then does
not lie in a "sloppy driver" or something universally wrong with the
pismo/lombard but rather something specific to those machines. at least,
IMHO...

Sean



On Thu, 8 Jun 2000, Chris Leishman wrote:

>
> On Wed, May 24, 2000 at 04:18:37PM +0200, Bernhard Reiter wrote:
> > Okay, we have a couple of people running stable Lombards with
> > more than 64 MB.
> >
> > On the other hand, we have people having hard freezes with
> > Lombard and Pismos even with 64 MB.
> >
> > So my analysis is as follows:
> >
> > High bus speed (400 Mhz) seems to be necessary to trigger this hard
> > freeze.
> > More memory makes it more likely for hard freezes to appear.
> >
> > If there is a problem with the memory it is more likely that it is with the
> > original 64 MB.
> >
> >
> > Is there somebody out there having a >=400 Mhz Lombard
> > and Pismo who is _not encountering hard freezes_ under high pressure?
> > (Preferably with more that 64MB. Because I never got the hard freeze
> > when I only used 64MB with the mem=64MB switch.)
> >
> > It might as well be a design problem of the Powerbooks. Can any of the
> > hardware kernel hackers comments on the differences in architecture
> > for powerbooks and the other G3s? Maybe a linux driver is written sloppy
> > in this area not taking in account how the hardware actually works?
> >
> > 	Bernhard
> >
> > ps.: Just I reminder: I am not subscribed ot the list.
>
>
> Just to let you know that I'm also running a Pismo with 192 megs ram,
> and it seems very stable.  I'm compiled kernels and run tripwire over the
> filesystem (lots of IO doing that) and no problems.  I'm running the
> linux-pmac-stable kernel.
>
> Chris
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
