Date: Fri, 5 May 2000 00:07:43 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Martin Costabel <costabel@wanadoo.fr>
cc: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.3.99-pre6 sound hfs
In-Reply-To: <3911DC0D.DE0C0C13@wanadoo.fr>
Message-ID: <Pine.LNX.4.10.10005042359580.31989-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > > >From my personal mail archive, I see that HFS was already broken in
> > > 2.3.18 last September.
> >
> > And it got fixed enough to be working again at least in 2.3.48 - that fix
> > (or rather workaround) may have been broken again lately.
>
> This is a little mysterious. It looks almost as if HFS is working for
> some people and not for others.

So it seems. I've no idea why I wasn't bitten by this bug - I've used the
approx. 300 MB HFS exchange partition a lot to copy kernels to MacOS but I
probably never ever did things like create a folder there (all the kernels
pile up in the top level directory :-)

And another thing: I recall initially having trouble with the kernel
panicking when I unmounted the HFS filesystem. Not each time, but on
occasion. Went away as soon as I started to sync before unmount (but I
haven't really pushed it).

> Around 2.3.45, there was a discussion with Ani Joshi who said that it
> was working for him. For me it definitely wasn't. It hosed a ZIP disk so
> thoroughly that MacOS died every time I just inserted it into the drive.
> I had to reformat it first under Linux before MacOS would even touch it.

I'll do my best to hose a ZIP disk, thanks for the tip. The 2.3.45 or so
fix must be what I remember (I had had a look at the HFS code and decided
that a few functions needed a complete rewrite, but someone found some
easier way to deal with it, though I never quite understood how that
worked).

> More recently (already in the 2.3.99's), Tom Rini claimed that HFS was
> working for him. And it seems that even now it works for some people.
> Weird.

I'll give 2.3.99 a spin.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
