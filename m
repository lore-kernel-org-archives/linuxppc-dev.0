Subject: Status of 2.6 8560 support.
From: David Woodhouse <dwmw2@infradead.org>
To: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Content-Type: text/plain
Message-Id: <1086707023.15845.67.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Tue, 08 Jun 2004 16:03:43 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I need to support the WindRiver PowerQUICC III MPC8560 board in 2.6. I
see a handful of #ifdef CONFIG_BOOKE in 2.6 but it's not actually
possible to set it, and parts which are in 2.4 (like motobooke_mmu.c)
are still missing.

Where's the rest of the 8560 support for 2.6? What needs to be done to
it to get it merged? You can consider me to have been volunteered ;)

--
dwmw2


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
