From: Cort Dougan <cort@fsmlabs.com>
Date: Fri, 28 Jun 2002 15:29:29 -0600
To: linuxppc-dev@lists.linuxppc.org
Subject: i8259.c spinlocks unnecessary
Message-ID: <20020628152929.K3851@host110.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I looked through the 8259 code and I believe the spinlocks there are
unnecessary.  The code is covered by a spinlock when called from irq.c.

I instrumented the code and after running quite some time my code review
matches what I've seen.

Anyone comment?  Does someone want to remove them?

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
