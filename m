Date: Thu, 10 May 2001 17:11:14 -0600
From: Cort Dougan <cort@fsmlabs.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org, Murray.Jensen@cmst.csiro.au
Subject: Re: linuxppc_2_5 source tree (and others)
Message-ID: <20010510171114.C1595@ftsoj.fsmlabs.com>
References: <20010510135742.W1595@ftsoj.fsmlabs.com> <200105102124.f4ALObA452146@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200105102124.f4ALObA452146@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Thu, May 10, 2001 at 05:24:37PM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Believe me, I know what it looks like.  I'm trying to clean things up but
it's a large problem.  I do appreciate your criticisms though, they are
useful in finding the worst parts.

Just to be clear, though, FSMLabs has nothing to do with Linux/PPC.  I just
happen to work here and use the web/ftp bandwidth.

} I'm sorry I was rude. Please try to imagine what PowerPC Linux
} development must look like to someone who does not happen to
} work for FSM Labs, Montevista, or BitKeeper.

Perhaps I can clear things up a bit.  I wanted _2_4 stable so that it
didn't get brand-new (untested and buggy) code.  I created _2_5 as a
work-area for us so people could push changes there, test them internally
and work out any problems.  We could then move them over to _2_4 quickly
when the changes were stable.  Unfortunately, people started giving out the
_2_5 tree and telling people to use it.

So, to solve that problem I created _2_4_devel so that we could get outside
testing and let users chose which kernel they wanted (brand-new features or
very stable and tested).

Unfortunately we need multiple trees since branches won't do the job for
us.  Lines of development will, though.  The people at BitMover and working
on that feature of BitKeeper for us already.

} It had 6750 support, and 2_4 didn't. I don't see why this
} situation would ever be created, but anyway, clearly 2_5
} was the better tree until it disappeared.
}
} If you need to do experimental work without disturbing the rest
} of the 2_4 code, you should be able to create a branch.

It wasn't a public tree, it should have stayed internal.  I did allow
outside access since all the developers except me are outside FSMLabs.
No-one was supposed to tell people to use it.  Often, it doesn't even
compile.  It's very experimental.  We're in the process of moving over the
code from that tree to the linuxppc_2_4_devel tree so no changes will be
lost.

} 1. why was there a public tree that was not "for outside use"

linuxppc_2_4 is a testing area before sending patches to Linus.  I never
want to have to revert a patch I've sent to Linus because it wasn't tested
and stable (Linus rarely takes patches as it is, I don't want to waste his
bandwidth).  linuxppc_2_4_devel is a working space before changes go to
linuxppc_2_4.

All changes that are stable and useful go to Linus in the end.  Not before
being tested and getting a good "beating around" first, though.

} 2. how can you have two trees, neither of which is a dead end?

When the real 2.5.0 comes out (when Linus creates it) I'll create another
tree, linuxppc_2_5.  I made a mistake in naming our experimental tree
linuxppc_2_5, this tree will be the real linuxppc_2_5.  We'll probably have
a linuxppc_2_5 and linuxppc_2_5_devel but that's still to be decided (it
will probably be decided by need).

So, I think that your short-term goal is to get the 6750 working, right?
linuxppc_2_4_devel should have what you need but if it doesn't it'll be
coming shortly.  You may also want to push MonteVista if you have a support
agreement with them on this board.

If the linuxppc_2_4_devel tree doesn't work for you let me know what
trouble you're having and I'll try to help.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
