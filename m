Date: Sun, 24 Mar 02 08:02:31 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0203241602.AA23822@ivan.Harhan.ORG>
To: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Troy Benjegerdes <hozer@drgw.net> wrote:

> when I start merging the _galileo tree code to _devel, I'm likely to blow
> your changes away because I can't test them.

If you do I'll scream very loud and make you fix your breakage.

> And PLEASE give me a different eth driver ;)
>
> The one in the tree right now works for single cpus, but
> a) is ugly
> b) blows up very nicely with SMP.

I'll discuss this in a bit.

> The _galileo tree was created to keep us from thrashing in _devel with a
> bunch of crappy (but working) code.
           ^^^^^^^^^^^^^^^^^^^^^^^^^

If you have crappy code, you have to be prepared for someone else having
sparkling beautiful code ready to go to Marcelo, and you have to accept it
being used over your crappy one. (Just check out my patch from my CVS to see
what I mean by sparkling beautiful code. Just compare the EV64260 and EV64260MS
ports.)

> FYI, I am about ready to merge Zuma's gt64260_mpsc driver to 2_4_devel
> since it seems to work reasonably well, and the code is mostly sane. If
> you have another mpsc driver, speak now or forever hold your peace.

I don't have another MPSC driver nor do I have plans to do any MPSC work right
now. At SBS I was planning on making a done-right MPSC driver for 2_4_devel
because their boards all used MPSC, but then I got fired from SBS and my
current paying client doesn't care about MPSC (he's got a UART on his board
just like on the EVB).

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
