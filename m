Message-ID: <37FE23D9.637A54FD@pop.agri.ch>
Date: Fri, 08 Oct 1999 19:03:23 +0200
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Linux-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: mouseconfig-4/ kernel headers?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
I know this is not a directly linuxppc specific topic. But maybe one of
you struggled also about this thing.

I try to rebuild mouseconfig-4 (and 3x). Every time it errors in lib pnp_probe_parport.c
LP_DELAY and LP_PERRORP are not defined! Although linux/lp.h is
included. I the saw that in lp.h there is a switch __KERNEL__,
uncommenting this switch helps and I can build mouseconfig-x.

Now, is this an old lp.h file? Dated 93. My kernel-source is 2.2.13pre15
based on stock 2.2.12.

Or should I insert -D__KERNEL__ in the make file?

Any hint?


Thanks 
Andreas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
