Date: Fri, 19 Oct 2001 09:16:45 -0700
From: Larry McVoy <lm@bitmover.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Larry McVoy <lm@bitmover.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.linuxppc.org, tytso@thunk.org
Subject: Renames, BK, PPC, etc
Message-ID: <20011019091645.B17049@work.bitmover.com>
References: <15312.6740.808012.183783@cargo.ozlabs.ibm.com> <20011019081353.C7765@cpe-24-221-152-185.az.sprintbbd.net> <20011019081649.A17049@work.bitmover.com> <20011019083430.D7765@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011019083430.D7765@cpe-24-221-152-185.az.sprintbbd.net>; from trini@kernel.crashing.org on Fri, Oct 19, 2001 at 08:34:30AM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Oct 19, 2001 at 08:34:30AM -0700, Tom Rini wrote:
> On Fri, Oct 19, 2001 at 08:16:49AM -0700, Larry McVoy wrote:
>
> > If you do this reorg and send it out to Linus as a patch and then get it
> > back again, can you let me do that merge or work with whoever does it?
> > The key thing is that you want to catch the renames and BK will help you
> > with that if you let it.
>
> Er, I thought we've just intentionally not been tracking renames in our
> kernel.org version of the tree...

Well this raises an interesting issue.  Some of the other kernel people have
started asking about a BK tree to track, one that has the kernel history in
it and is well maintained.  Ted Tso went so far as to import a bunch of
history, complete with the release notes checked in as changeset comments,
into a new BK tree.  One option is to use that tree for anyone who wants
to use BK with the kernel.  If that catches on, that's likely to be the
tree that Linus would pick up and use if/when he starts using BK.

On the other hand, there is a lot of history in the various PPC BK trees.

The question is this: if Linus & Co were to start using BK, does anyone
here care whether it is the current PPC maintained tree or are you willing
to start over?  BK is not going to let you pull from the new tree to your
current tree, as far as BK is concerned those are completely unrelated
repositories.  So you'd have to switch.

If you haven't been maintaining the renames all along and there is lots
of crud in the tree, then I can see you not caring at all.  In fact, it
would probably be desirable to do a reset.  Paul?  Cort?  Others?

I'm putting Ted's tree up at http://linux.bkbits.net/ so you can take a
look at the nice job he did importing the data.  Let me know what you
think.
--
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
