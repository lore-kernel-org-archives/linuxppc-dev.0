Mime-Version: 1.0
Message-Id: <p04330100b7b754433776@[66.57.12.104]>
Date: Sat, 1 Sep 2001 23:19:36 -0400
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: dcache.h kernel bug?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Running 2.4.10pre2 on a 6500. Have been getting random crashes into
xmon with no keyboard control so I cannot do a backtrace. The crashes
have only occurred in X.

Got one tonight, and on reboot, I could not start X as a user, only
as root. When starting as a user, it said authentication failed, and
perhaps I do not have control of the console?

This is all leading up to the following, dunno if any is related or not:

Back in the console, I was removing a file when I got:

kernel BUG: at /usr/src/linux/include/linux/dcache.h:244!

Is this something possibly related to my X crashes? Can it be fixed?
It was a hard lockup, no 3-fingers, had to power down and reboot.

Regardless, how do I launch X again as a user? I had just updated
glib to 1.2.10-ximian, don't know if that had anything to do with
anything.


Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
