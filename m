Subject: Re: linuxppc-2.5 (mvista rsync) -- drivers/ide/ppc/pmac.c:1843:
	error: request for member `queue_head' in something not a structure or union
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Miles Lane <miles.lane@comcast.net>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200308101351.01114.miles.lane@comcast.net>
References: <200308100851.04174.miles.lane@comcast.net>
	 <1060547919.599.34.camel@gaston>
	 <200308101351.01114.miles.lane@comcast.net>
Content-Type: text/plain
Message-Id: <1060548925.599.42.camel@gaston>
Mime-Version: 1.0
Date: 10 Aug 2003 22:55:25 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2003-08-10 at 22:51, Miles Lane wrote:
> On Sun August 10 2003 1:38 pm, Benjamin Herrenschmidt wrote:
> > On Sun, 2003-08-10 at 17:51, Miles Lane wrote:
> > >   CC      drivers/ide/ppc/pmac.o
> > > drivers/ide/ppc/pmac.c: In function `idepmac_wake_device':
> > > drivers/ide/ppc/pmac.c:1843: error: request for member `queue_head' in
> > > something not a structure or union
> > > drivers/ide/ppc/pmac.c: In function `idepmac_wake_drive':
> > > drivers/ide/ppc/pmac.c:1927: error: request for member `queue_head' in
> > > something not a structure or union
> >
> > I sent an updated version of this driver to linus today
>
> When you send patches to Linus to fix problems that show up in
> the linuxppc-2.5 tree, you don't also apply the patch directly to
> the linuxppc-2.5 tree?  If you and Paul use BK, couldn't you have
> Paul pull the changeset?  Is our current process the most efficient
> we could use?

Right now, I'm sending massive PowerMac driver updates directly
to Linus. Typically, all of this is available from my linuxppc-2.5-benh
tree, though I don't really recommend for non-hackers to use that.

> I am curious, why do you and Paul not use a system more like Russell's
> (changes move into Linus' tree as soon as they are fairly well tested
> and he maintains the ARM patches in

I'm trying to completely avoid having a "ppc" or "powermac" tree with
2.6, at least once all the "pending" bits from mine have been in Linus.
I want to keep as close as Linus tree as I can, not reproduce what I did
for 2.4 where I had megabytes of diffs piling up.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
