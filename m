Date: Fri, 14 Dec 2001 13:53:12 -0500
From: Kent Borg <kentborg@borg.org>
To: linuxppc-embedded@lists.linuxppc.org
Cc: marc.paquin@motorola.com, peter.barada@motorola.com
Subject: Good GDB Version?
Message-ID: <20011214135312.B12904@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We are having problems with gdb.

Using gdb to talk to gdbserver over ethernet to our custom 405 board
we can run a trivial application, we can drop a breakpoint, land at
the breakpoint, look at variables and stuff--but trying to continue
doesn't move us forward.

When we revert to an old kernel we were using that originally came
from mvista.com's area51 (circa last spring) gdb/gdbserver works, so I
don't think it is an immediate operator error (but it maybe something
more subtle...).

I am wondering whether we have the right gdb.  Our current version is
5.0.  We also tried 5.0.93 (it didn't work either), but we worry that
our gdbserver wasn't matched with it.

What gdb/gdbserver do y'all use?  (Where did you get it??)  When
co-worker Peter last built gdbserver for us he couldn't find
maintained sources and had to do some cobbling to make it work.  (That
was at 5.0, a few months ago.)

Have there maybe been signifcant changes to ptrace that we need to
know about here?  Is ptrace is working order currently?

One more detail, these symptoms are on a kernel brought up to date
with a linuxppc devel rsync from yesterday afternoon.

Suggestions?


Thanks,

-kb, the Kent who is writing this on behalf of a colleague who isn't
on the list.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
