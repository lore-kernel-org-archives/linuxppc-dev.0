Mime-Version: 1.0
Message-Id: <p04330104b7a79e11b8be@[24.25.18.209]>
Date: Tue, 21 Aug 2001 01:16:50 -0400
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: 2.4.9-bk and X on 6500, not so good
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have a stock 6500/300, on which I just compiled and installed the
ppc.bitkeeper linuxppc_2_4 (2.4.9) kernel. In console mode (RL3) it
works just fine.

But whenever I launch X (Gnome for example, or a plain window
manager), about 70% of the time it breaks into the mon debugger
before X has fully launched.

Problem is, there is no keyboard response at this point, and I can't
even restart with the 3-fingered approach (no response). Only thing
that works is power down, and restart.

Any suggestions? To create a backtrace appears impossible...


Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
