Message-ID: <20010812190600.27233.qmail@web3805.mail.yahoo.com>
Date: Sun, 12 Aug 2001 12:06:00 -0700 (PDT)
From: bhupinder sahran <bhup_sah@yahoo.com>
Subject: running configuration cycle across the secondary side of a non transparent(21554) bridge
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi all
i am trying to run configuration cycle across the
secondary of 21554 bridge, from my MPC8240 on which
linux is running.
i am not able to write anything into the downstrean
configuration register which is at offset 0x90 from
the primary interface.
i have enabled the downstream configuration control &
status register also.
i have tried to write through CSR I/O BAR also.
but could not write.
can anybody tell me what could be the reason.
thanx in advance
bhupi


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
