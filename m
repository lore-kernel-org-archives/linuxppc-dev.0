Date: Thu, 10 Jun 2004 07:57:21 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: trouble starting "init" -- the followup
Message-ID: <Pine.LNX.4.58.0406100745200.5263@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


  (argh -- i managed to delete the response i got to my earlier posting
about the kernel failing to start any init-like program on my 8xx board.
sorry.)

  regarding the response, from memory, the poster suggested that, if i'm
using minit, i recompile busybox to be statically linked.  first, i'm not
using busybox's minit feature; that's been recently dropped from BB, so
i'm using the actual downloaded and cross-compiled (ELDK 3.0) source from
www.fefe.de/minit/.  the *other* possibilities for initial program at boot
time -- sh, init -- are part of BB, however.  but it's minit i'm using as
my first choice, so it's not exclusively a BB issue.

  i can recompile minit to be statically linked if that might be the
problem, but i'm still reminded that, not that long ago, i could at least
*start* minit before it hung.  now, as i mentioned, the calls to
run_init_process() in init/main.c all fail.  the obvious question would
be, is there any recent change to the BK tree that would have introduced
this problem that wasn't there before?

rday

p.s.  if someone has a mostly-working .config file for 8xx for that
linuxppc-2.5 tree, i'd certainly like to see it and test it.  along with
how they built their ramdisk image.

p.p.s.  i feel fairly helpless since i'm still new at this game.  i guess
the next obvious step would be to figure out how to step-by-step debug the
kernel as it boots.  time to figure out how this BDI2000 works, i guess.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
