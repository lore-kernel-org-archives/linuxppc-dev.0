Date: Wed, 3 Oct 2001 13:05:59 -0400
From: Kent Borg <kentborg@borg.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: BK to CVS?
Message-ID: <20011003130559.F31866@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We use cvs internally and I am trying to get all the daily patches out
of Bitkeeper and into a cvs module.  Are others doing this?  Is it
reasonable?  If so, how are you doing it?

I tried using "bk export" to generate a patch file I could apply to my
cvs tree, but there are Id keywords that cvs honored the last time
around making the patch not apply properly.

I noticed in the documentation for export that it apparently only
honors the "-k" switch for killing keywords when doing a complete
export--so I tried that intending to make my patch from two complete
Linux trees.  Except the -k didn't work.  The Id contents are still
there in the exported files.

Finally, I tried writing some perl to post-process the "bk export"
patch to remove the simple Id changes.  Cool, but bunches of files, at
least in yesterday's pull, have changes up near the Id and so are part
of the same patch hunk, and catching that in a perl script is going to
be a lot harder.


How do the rest of you use Bitkeeper with other source control
systems?  (Or do you?)


Thanks,

-kb, the Kent who is coming to hate keywords in source code control
systems.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
