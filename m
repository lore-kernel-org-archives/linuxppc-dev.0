Date: Tue, 26 Sep 2000 10:10:49 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Ethan Benson <erbenson@alaska.net>
cc: Guillaume Laures <guillaume.laures@noos.fr>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: MacOS X and yaboot wars.
In-Reply-To: <20000925145411.G1928@plato.local.lan>
Message-ID: <Pine.LNX.4.10.10009261007560.513-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > It's a 27G disk...
> > May be I'll change "Apple_Bootstrap" to "Apple_Boot" ?
>
> i wouldn't then MOSX will think that its it owns this partition and
> who know what it will do to it then.  if its Apple_Bootstrap its less
> likely apple will destroy it randomly since OSX does not know what it
> is.

Does ybin rely on the Apple_Bootstrap type? If not, just call it any way
you like to make MacOS messing with it even more unlikely.

> i very much doubt they reorder the partition table at every boot so
> using the `r' command in mac-fdisk should allow you to reorder the
> table so Apple_Bootstrap is first.

Caution: I've found the reorder option to work in very non-obvious ways
(partitions could only be moved one way IIRC). I'll have to investigate
that in more detail.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
