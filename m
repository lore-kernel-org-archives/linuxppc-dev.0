Date: Fri, 5 Oct 2001 11:11:45 -0400
From: Kent Borg <kentborg@borg.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: BK to CVS?
Message-ID: <20011005111145.C8157@borg.org>
References: <20011003130559.F31866@borg.org> <20011003113245.B18196@cpe-24-221-152-185.az.sprintbbd.net> <20011004092511.A3914@borg.org> <20011004132953.B32269@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011004132953.B32269@cpe-24-221-152-185.az.sprintbbd.net>; from trini@kernel.crashing.org on Thu, Oct 04, 2001 at 01:29:53PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Progress.  I am telling cvs a "-ko" to keep keyword expansions as they
come in.

But I am still tripping over something that I either don't understand
in Bitkeeper, or Bitkeeper is misbehaving.  The following doesn't do
what I expect.


I started things up by doing:
- "bk clone", then
- "bk changes" to see what the most recent revision is, then
- a complete export of that rev, and put that in cvs as my starting
  point.

Then each day I have a script that does:
- "bk changes" to see the "before" rev,
- "bk pull" to get up to date,
- "bk changes" to see "after" rev,
- export of a patch between those two revs, apply that to my cvs.

The problem is that some of the patches fail because the cvs file
isn't in the state the patch expects.  Because I am still getting the
bugs out, we aren't doing any work in the cvs tree, only bk stuff is
going in there.

I did a new export from bk as of the latest "bk changes" rev and
compared that with an export from cvs.  (The idea being that beginning
dump + delta + delta + delta should equal ending dump.)  Yes, I get
some BK Id collisions that don't bother my daily patches, but I also
get a couple more files with substantial differences.  Is there
something wrong with my method?  Is there a likely problem with my
implementation?  Is Bitkeeper being buggy?


Thanks,

-kb, the Kent who is convinced he is getting close and so should soon
quit asking these annoying questions.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
