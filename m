Message-ID: <20020325171639.22867.qmail@web9507.mail.yahoo.com>
Date: Mon, 25 Mar 2002 09:16:39 -0800 (PST)
From: Pete McCormick <pete261@yahoo.com>
Subject: booting linux kernel 2.4.18 on Motorola MPC8260ADS board
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

I am having a problem booting the linux kernel 2.4.18 on a Motorola MPC8260ADS
board.  I am stuck in arch/ppc/kernel/head.S, just after the start_here label.
The software never returns from an "RFI" instruction (around line 1586).  This
is at the end of the block of code preceded by the comment "Go back to running
unmapped".

I suspect something is not right in the MMU setup but I don't know what.

Any ideas or suggestions would be helpful.

Thanks,

Pete


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
