Message-Id: <200002090046.QAA04327@work.bitmover.com>
To: Tom Rini <trini@kernel.crashing.org>
cc: Dan Bethe <dan_bethe@yahoo.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: the state of the linuxppc-dev community
In-Reply-To: Your message of "Tue, 08 Feb 2000 17:26:05 MST."
             <Pine.LNX.4.10.10002081724450.30794-100000@opus.bloom.county>
Date: Tue, 08 Feb 2000 16:46:36 -0800
From: Larry McVoy <lm@bitmover.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


: On Tue, 8 Feb 2000, Tony Mantler wrote:
:
: > Mind you, the PPC-Linux rsync server makes it very easy to get the
: > latest-ish kernel sources, which I used quite successfully recently to
: > compile a kernel for my friend's PBG3. (well, mostly successful. got some
: > missing symbols from some unimportant modules that I didn't care to track
: > down. used the benh sources)
:
: Except that the server is never current, yes.  The _only_ place right now
: with any sort of current sources is in bitkeeper trees.  So once bk is
: released, things should look a bit better.

In the it-doesn't-help-at-all department, the reason BK hasn't been publicly
released is that we _know_ of bad rename problems.  We've been working with
Cort to get those resolved and you'll all be happy to know that the BK
resolve process (the thing that shleps in new work and figures out all the
renames, conflicts, etc) has been rewritten and is passing all regressions.
We're gonna spring it on you by the end of the week.  If Cort and the other
BK users bless it, we'll do a public release.

--lm

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
