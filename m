Return-Path: <jim@jklewis.com>
Received: from que02.suddenlink.net (que02.suddenlink.net [208.180.40.87])
	by ozlabs.org (Postfix) with ESMTP id CBB77DDFB3
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 03:20:52 +1100 (EST)
Subject: Re: [PATCHSET] libata: PATA driver for Celleb
From: Jim Lewis <jim@jklewis.com>
To: Jens Osterkamp <jens@de.ibm.com>
In-Reply-To: <200702151141.49708.jens@de.ibm.com>
References: <200701260724.l0Q7OISY027645@toshiba.co.jp>
	<45D3EAA7.80805@garzik.org>
	<1171525923.20192.243.camel@localhost.localdomain>
	<200702151141.49708.jens@de.ibm.com>
Content-Type: text/plain
Date: Thu, 15 Feb 2007 10:03:06 -0600
Message-Id: <1171555386.3219.37.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Jeff Garzik <jeff@garzik.org>, arnd@arndb.de, linuxppc-dev@ozlabs.org,
	linux-ide@vger.kernel.org, paulus@samba.org,
	Andrew Morton <akpm@linux-foundation.org>, alan@lxorguk.ukuu.org.uk
Reply-To: jim@jklewis.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


 We have had some discussions previously about Linas Vepstas taking over
the maintainership of Spidernet from me. I will look into this and see
if we can make it happen. 

Jim Lewis


On Thu, 2007-02-15 at 11:41 +0100, Jens Osterkamp wrote:
> On Thursday 15 February 2007, Benjamin Herrenschmidt wrote:
> > 
> > > I'm totally confused about who the heck is the spidernet maintainer.
> > 
> > Me too :-)
> > 
> > > My 
> > > inbox is pelted by spidernet driver updates from multiple people, and 
> > > often the spidernet patches (regardless of author) receive comments that 
> > > give me pause.  The MAINTAINERS file says
> > > 
> > > > SPIDERNET NETWORK DRIVER for CELL
> > > > P:      Jim Lewis
> > > > M:      jim@jklewis.com
> > > > L:      netdev@vger.kernel.org
> > > > S:      Supported
> > > 
> > > but I do not see patch roll-ups or much activity from him at all.  In 
> > > practice, it seems like Linas does patchsets for spidernet, but there is 
> > > also Jakob Osterkemp(sp?) and Ishizaki and....
> > 
> > I think Jens Osterkampf should be the final ACK/NAK'er as he has all the
> > hardware to test except the Toshiba gear :-) In fact, Jens, if you are
> > ok with that, I'd like to have you be the maintainer of that driver,
> > unless you think it's better for Linas to do it.
> > 
> > > My overall impression of spidernet development is that EVERYBODY is 
> > > submitting patches at once, and expecting me to sort out the mess.  No 
> > > thanks.
> > 
> > It's been a bit of a mess. I suggest we get our gear together (Linas,
> > Jens, Kou) and provide you a single patch set from a single source in
> > the upcoming couple of days coming from the designated maintainer.
> > 
> > Jens ? Linas ? Is that ok with you guys ? Who gets to be that
> > maintainer ?
> > 
> > _ALSO_ since spidernet uses (and modifies) sungem_phy.c, we need either
> > DaveM or my ack there (DaveM is sungem maintainer but I wrote sungem_phy
> > and most of it is only used on powermacs).
> > 
> > Thus let's move that back to the cbe-oss-dev mailing list, our
> > designated maintainer will post there a candidate patch set, I will
> > verify the sungem_phy change is ok with powermac (I myself haven't
> > followed enough to figure out what patch is the latest there), we'll all
> > test on our respective hardware, and then that maintainer will send you
> > one patch set to apply.
> > 
> > That shouldn't take more than a few days. If we miss -rc1, well, then it
> > will be in -rc2, as most of the patches have been around for long enough
> > etc... it's really mostly a matter of getting our gear together.
> > 
> > > Speaking with one voice would be much appreciated.  And said speaker 
> > > should patch the MAINTAINERS file to reflect reality.
> 
> Sounds reasonable. I fully agree.
> 
> Linas has done a pretty good job on improving the driver in the last half
> year or so and he also has access to all the necessary hardware so I think
> he would be the right person for the job.
> 
> Jens
