From: "Ron Bianco" <ronb@junction.net>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: A stable linux 2.2.xx for sandpoint-8240 anywhere?
Date: Fri, 29 Dec 2000 15:31:52 -0800
Message-ID: <000901c071ef$85b814d0$4d012ac7@warp-speed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3A4D079E.1778BCEC@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks Dan & Tom,

> > There are problems as this port was based on an experimental
> and unstable
> > kernel.
> > There are patches (tons) that fix some of the problems we've
> been seeing,
>
> Really?  Although not suitable for a product, there shouldn't be "tons"
> of patches required to make it useful in a development environment.
> There may be patches required to work around the different revisions
> of the Sandpoint hardware.

We do now need something suitable for a product.  And to use initrd as root.

I was attempting to summarize the following conclusions of a co-worker:

"By the way, last night I found info on the one problem we were having with
the linux kernel booting.  The people at Montavista originally ported
linux 2.3.16 to the PPC 8240 chip. all linux 2.3.* versions are designated
as experimental and unstable.  Since then (feb 2000) there have been over
100 sets of patches to the linux kernel.  I'll take a look to see what is
best to do: apply the changes to the stable 2.2.18 kernel, or apply the
changes to the almost stable 2.4.0-test12, the totally latest kernel
version as of last week.  The changes themselves have to change depending
on what is chosen.  The problem with the initial ram disk is not a ram
disk specific bug, the bug is in the MMU paging/caching system and I don't
think it was fixed until 2.3.47 or so. It can cause other subtle problems,
such as crashing during ftp of large files."


> That is where all of the resources seem to be going right now, to
> custom hardware.  The 8240 is just a 603 with 106/107 OpenPIC PCI
> bridge.  The Sandpoint is what required all of the code changes.  If
> your hardware is like a Sandpoint, then there are still changes
> required to suit your needs.  Most people aren't building Sandpoint-like
> hardware that I know about.
>
> > Eventually we'll make our patches for 8240 available.
>
> Do it quickly, as there will soon be 824x updates in the 2.4 kernel.

We'll probably wait to see what those are, so as to avoid duplication.
Yeah, our board is not very sandpoint-like either.  But changing
sandpoint_setup.c (and sandpoint_pci.c) to suit our board seemed the
easiest.    Now that I'm finished debugging the hardware, the final kernel
changes we needed were minor.

Ron


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
