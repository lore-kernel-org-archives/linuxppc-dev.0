Message-ID: <20030629153700.13980.qmail@web20009.mail.yahoo.com>
Date: Sun, 29 Jun 2003 08:37:00 -0700 (PDT)
From: Raghava Raju <vraghava_raju@yahoo.com>
Subject: delegating to a cpu
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Currently interrupt handler in our driver uses
tasklet to process some of less important info
to save some interrupt time. But problem is that
tasklet ends up in the same cpu, and second  cpu
is not taking much of the work.
1) Is there any mechanism to delegate the less
important work to other cpu an example would really
help.
2) We dont have multiple interrupts, so please
dont give irq affinity solution!!
3) Our kernel version is 2.4.19.

I am not subscribed to this list, so please
mail back at vraghava_raju@yahoo.com.

Raju.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
