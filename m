From: Larry McVoy <lm@bitmover.com>
Date: Fri, 7 Jan 2000 12:42:29 -0800
Message-Id: <200001072042.MAA24660@work.bitmover.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: BK reader/writer locking
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


mea culpa.  I had writer locks at the repository level working but not
reader locks.  So you could get inconsistent data if you did a pull or
a resync while someone else was pushing.  

A pass at fixing this is in hq.fsmlabs.com:/home/lm/bk so please pull that
to your local machine and "cd src; make production".  This has already been
done on hq so you should be back in business on the shared repository.

By the way, I dunno if you know it, but you guys rate pretty much 24x7 
support.  Here's how to get it:

a) ALWAYS send help requests to dev@bitmover.com - contrary to public
   opinion, BK is not just me.  Andrew, Rick, Kim, and Aaron also
   work here and are good and helping and fixing bugs.

b) If you don't get an ACK pretty quickly, and you are being held up,
   you can call my business line which is in the US at 415-401-8808.
   If you are stalled and you are sure it is a BK problem, for the time
   being you can call 24 hours/day, I'll get up.  I know some of you are
   in Europe so I pretty much have to deal with the timezone difference.

Cheers,

--lm

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
