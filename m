From: Miles Lane <miles.lane@comcast.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: linuxppc-2.5 (mvista rsync) -- drivers/ide/ppc/pmac.c:1843: error: request for member `queue_head' in something not a structure or union
Date: Sun, 10 Aug 2003 13:51:01 -0700
Cc: linuxppc-dev@lists.linuxppc.org
References: <200308100851.04174.miles.lane@comcast.net> <1060547919.599.34.camel@gaston>
In-Reply-To: <1060547919.599.34.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200308101351.01114.miles.lane@comcast.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun August 10 2003 1:38 pm, Benjamin Herrenschmidt wrote:
> On Sun, 2003-08-10 at 17:51, Miles Lane wrote:
> >   CC      drivers/ide/ppc/pmac.o
> > drivers/ide/ppc/pmac.c: In function `idepmac_wake_device':
> > drivers/ide/ppc/pmac.c:1843: error: request for member `queue_head' in
> > something not a structure or union
> > drivers/ide/ppc/pmac.c: In function `idepmac_wake_drive':
> > drivers/ide/ppc/pmac.c:1927: error: request for member `queue_head' in
> > something not a structure or union
>
> I sent an updated version of this driver to linus today

When you send patches to Linus to fix problems that show up in
the linuxppc-2.5 tree, you don't also apply the patch directly to
the linuxppc-2.5 tree?  If you and Paul use BK, couldn't you have
Paul pull the changeset?  Is our current process the most efficient
we could use?

I am curious, why do you and Paul not use a system more like Russell's
(changes move into Linus' tree as soon as they are fairly well tested
and he maintains the ARM patches in
http://www.kernel.org/pub/linux/kernel/people/rmk/arm/v2.5/)?

Thanks,
	Miles

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
