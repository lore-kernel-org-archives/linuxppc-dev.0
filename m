From: mutex@kerneli.org
Date: Thu, 29 May 2003 08:41:43 -0700
To: linuxppc-dev@lists.linuxppc.org
Subject: new ATI sleep code freezes
Message-ID: <20030529154143.GC7896@heliosphan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,
This has taken me a while to decide it was a bug and not a freak
accident. About one to two times a week I have noticed that my powerbook
will hand during the sleep process. Usually, when the sleep operation
completes, there is a quick screen power blank. Then about another 1.5
seconds of the LCD being illuminated, with what looks like some random
part of video memory being displayed, then finally the machine goes
to sleep. Occasionally I am seeing a freeze during the step where the
machine stays on for 1.5 seconds and has not quite been put to sleep. I
have been unable to diagnose this, as it happens so infrequently, but I
figured by posting I could hopefully get some more people experiencing
this as well. my specs:
	1ghz tipb, 1gig ram, radeon 9M, 2.4.20-ben8

I also do not seem to be doing any tasks at this time, just idling my
window manager.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
