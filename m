Message-ID: <368EB981.27DC761C@wanadoo.fr>
Date: Sun, 03 Jan 1999 01:27:45 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: vger-2.2-pre3 bugs
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The current vger kernel does not compile:

In include/asm-ppc/init.h r1.11, a necessary patch from 1.10 was
removed, so that __cacheline_aligned is undefined in kernel/sched.c

In drivers/sound/dmasound.c r1.35, a patch from 1.33 was applied once
more, so that sq_allocate_buffers and sq_release_buffers are doubly
defined.

Both give fatal errors in egcs-1.1.1.

--
Martin

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
