Message-ID: <3B803FEE.7079F34C@acm.org>
Date: Sun, 19 Aug 2001 15:38:38 -0700
From: Ira Weiny <iweiny@acm.org>
MIME-Version: 1.0
To: Linux1394dev <linux1394-devel@lists.sourceforge.net>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Task Queue Imediate Bottom Halfs question.
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is going to seem like a real stupid question but I just got burned
because I did not know the answer and I would like to know.

In the 1394 stack (OHCI) the IRQ handler schedules "bottom half tasklets
(task queues in the old stack)".  They are scheduled to be "imediate"
bottom half's.  I thought (wrongly) that a bottom half executed out of
IRQ time with interrupts __enabled__.  As a result I put in a Async Rec
handler which used printk (60ms worth to be exact).  Needless to say
this greatly disturbed our ISO transfers which did not get processed.

So, my question is, why use a bottom half here?  Or really what is the
difference between scheduling a task queue (tasklet) imediate vs just
running the code in the IRQ handler?

Thanks,
Ira Weiny
iweiny@acm.org

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
