Message-ID: <3FFC0C8D.8060402@mixed-mode.de>
Date: Wed, 07 Jan 2004 14:41:33 +0100
From: Tamas Bara <tba@mixed-mode.de>
MIME-Version: 1.0
To: linuxppc mail list <linuxppc-embedded@lists.linuxppc.org>
Subject: IDMA on MPC8265
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have an MPC8265 board with linux-2.4.20 as
OS and and a Gigabit Ethernet controller on
the PCI bus.

I have to implement a workaround, using one of
the IDMA channels, to avoid a deadlock caused
by PCI bus mastering of the GBE card.

Are there any mean pitfalls I should keep an
eye on, like using only certain regions of the
Dual Port RAM?

Thanks.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
