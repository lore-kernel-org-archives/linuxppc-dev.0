Date: Fri, 25 Aug 2000 09:12:06 +0200 (CEST)
From: Ronald Wahl <rwa@peppercon.de>
To: Dan Malek <dan@embeddededge.com>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: allocating uncachable memory
In-Reply-To: <Pine.LNX.4.21.0008240918310.625-100000@goliath.issistance.de>
Message-ID: <Pine.LNX.4.21.0008250907160.1624-100000@goliath.issistance.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 24 Aug 2000, Ronald Wahl wrote:

>
> On Wed, 23 Aug 2000, Dan Malek wrote:
>
> > Benjamin Herrenschmidt wrote:
> >
> > > ... Most PPC machines out there (all PCI PPC machines) are,
> > > AFAIK, cache coherents. PPC NuBus powermacs are not.
> >
> >
> > The MPC8xx and IBM 4xx systems can have PCI options but are not
> > cache coherent.  PCI masters are still challenging (if you can actually
> > get them to work :-).
>
> It's an MPC860 together with an PLX 9054 PCI Controller. The effect is
> that most of the data is correct but sometimes the MPC860 seems to get
> wrong data. Looks like more than a race condition than a cache side
> effect, but I'm not sure.

After some further tests I found out that it is the data cache of the
MPC860. If I switch the data cache off in head.S all goes well. So my
question again: How can I get an alias mapping (with _PAGE_NO_CACHE |
_PAGE_GUARDED) of some already mapped pages.
...or can I mark pages as non-cacheable w/o alias mapping?

thx,
ron


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
