Date: Tue, 7 Oct 2003 06:37:59 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Gary Thomas <gary@mlbassoc.com>
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Kernel versions
Message-ID: <20031007133759.GA25450@ip68-0-152-218.tc.ph.cox.net>
References: <20031002121733.A2E32C59E4@atlas.denx.de> <001101c3894c$38833ab0$2803050a@JackyLam> <3F7D3238.2090400@bluewin.ch> <20031003151729.GC21468@ip68-0-152-218.tc.ph.cox.net> <1065224171.18201.805.camel@hermes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1065224171.18201.805.camel@hermes>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Oct 03, 2003 at 05:36:11PM -0600, Gary Thomas wrote:

> Tom,
>
> For more than a year now, I've been working from the linuxppc_2_4_devel
> tree, sending updates which have been merged in, etc.  I just looked at
> the recently discussed 2.4 tree (http://ppc.bkbits.net:8080/linuxppc-2.4)
> and I see none of this work present.
>
> So my questions are:
> * What is the "proper" tree to be working from (2.4, 2.6)?
> * What is the merge path from the work in 2_4_devel to these other trees?

For 2.6, a tree based off of Linus' BK (or CVS or SVN or tarball of
that) or current 2.6 release.  For 2.4, it depends on the type of board:
8xx: Should be mostly merged into kernel.org now, but if you need
something, pull it up and out separately.
'classic' mpc10x based: All of the library type bits of code
(mpc10x_common, gen550) are in kernel.org, so it should be trivial to
pull a platform out of _devel
gt64260 (and gt64360): At OLS Paul talked to Mark about what needs to
bee done to make him happy with the code and Mark has expressed a desire
to do some (other?) cleanups as well to the 64260 code, which should
take into account the 64360 when possible.
'other' classic: Most likely needs someone with the hardware to state
that it's still working.
8260: Needs things to be pulled up and out of 2_4_devel.

And by 'pull it up and out' I mean to make another patch / ChangeSet of
just those changes (or many, if there's many difference pieces to it)
that would go in before the patch for a given board.

Now, since 2.4 (2_4_devel, even) and 2.6 are not in sync for some code
(gt64260) and not all platforms work in 2.6 (8xx, 8260 is in almost
working shape again) it might not be an equal amount of work needed to
get something into 2.4 and 2.6, but it would be appreciated if patches
come in at roughly the same time for both (or 2.6 first, even).

The linuxppc-2.4 tree contains what's gone to Marcelo already, along
with some things that are being polished up.  At the moment, I don't
think there's anything special there, but I haven't looked.

> ... I wouldn't want all of my efforts to just get lost.

It won't be.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
