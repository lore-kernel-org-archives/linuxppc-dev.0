Date: Thu, 24 Aug 2000 09:42:53 +0200 (CEST)
From: Ronald Wahl <rwa@peppercon.de>
To: Dan Malek <dan@embeddededge.com>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: allocating uncachable memory
In-Reply-To: <39A40BE3.11A6D4E1@embeddededge.com>
Message-ID: <Pine.LNX.4.21.0008240918310.625-100000@goliath.issistance.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 23 Aug 2000, Dan Malek wrote:

> Benjamin Herrenschmidt wrote:
>
> > ... Most PPC machines out there (all PCI PPC machines) are,
> > AFAIK, cache coherents. PPC NuBus powermacs are not.
>
>
> The MPC8xx and IBM 4xx systems can have PCI options but are not
> cache coherent.  PCI masters are still challenging (if you can actually
> get them to work :-).

It's an MPC860 together with an PLX 9054 PCI Controller. The effect is
that most of the data is correct but sometimes the MPC860 seems to get
wrong data. Looks like more than a race condition than a cache side
effect, but I'm not sure.

ron


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
