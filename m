Message-ID: <39BE4E5E.FA7437EE@mvista.com>
Date: Tue, 12 Sep 2000 11:40:14 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: mlan@cpu.lu, linuxppc-dev@lists.linuxppc.org,
        greyham@research.canon.com.au
Subject: Re: Getting patches in (was: Re: Roles for distributions)
References: <200009120614.IAA00922@piglet.grunz.lu> <20000912085918.23901@192.168.1.10>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

> That problem is not specific to the PPC port, how many times patches are
> sent to Linus without an answer, but without anything happening neither.

This is sometimes the problem we even have with patches.  Although I will
put them in, they don't make it into the Linus tree.  Other times,
Linus will pick up part of a patch because it is generically a
good thing, and then we have to re-work what is left in the PPC port.

> The latest batch of PPC patches sent by Paul, AFAIK, didn't appear in
> Linus test8 (was it rejected ? I don't know)

I had breakfast with Cort this morning.  One of the major issues on
the table is creating a stable 2.4 release.  There are lots of patches
sitting in limbo right now, and unless they can be proven to fix a
specific stability bug, they may not make into the first real 2.4.


> That's one of the reasons why we have this sourceforge site now. Pleast
> post your patches there. They may or may not get merged, but at least
> they will be available in a central position and won't be forgotten.

Many of us have been talking about a single point for posting patches.
There are several challenges to updating the sources, aside from adapting
them to the Linus tree.  I get lots of patches from people.  Some I
can deal with directly and some require the knowledge of others.  Among
the list of people Ben mentioned, we sometimes have to work together.
One of the greatest challenges of the PowerPC port is the different
processors and different board types.  This is unlike any other port.
When someone sends me a patch for the MPC823, I have to test this with
other MPC8xx processors as well as desktop/notebook PowerPC systems.
This is very tedious, and although it may look obvious to the originator
of the patch that it won't affect anything else, I have broken the tree
enough times to know I had better check everything.  It seems patches
come from several people for a common feature area, because of dicussions
on the mailing lists.  When we get these, they have to be merged and
sorted out.  Maintaining the source trees (of any kind) is a very time
consuming processes, and while it may have taken only a day or less to
make the code update work on one particular platform of interest, it
will take me days to merge it with all of the other patches, resync
against the  source trees, test on a variety of platforms and ensure the
update went smoothly.  There is nothing worse than making a 2AM update,
to return later in the morning faced with an inbox full of bitch
messages :-).

Hopefully, posting patches in a common place will allow people to see
what others have done, and some of this merging/testing can be done
earlier in the cycle.  This would be a great help.  Also, updates that
are generally useful to lots of people have a higher priority and are
more likely to find their way quickly into the source trees.  Something
that is unique to an individual, requires lots of code changes, or
adversely affects others will find it very slow.  Smaller, more frequent
patches are good :-).


> Well, a bit less actively for now, I want things to stabilize a bit and
> get merged with Linus before feeding the tree with new patches (and I
> have my own patches waiting too).

There are lots of patches waiting.  Cort and I discussed some solutions
to having both a stable tree and a single place to apply patches for
further testing.  He is going to discuss some BK features with Larry
(not new ones, just if certain combinations of existing ones) that will
help us do this.

> ..... Don't worry if you don't see anything
> happening on the sourceforge site for the upcoming days, that doesn't
> mean it's dead.

Or anywhere else....as I said there are lots of patches pending, waiting
for the stable 2.4 to happen and 2.5 to open up.



	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
